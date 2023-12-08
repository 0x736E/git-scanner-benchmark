#!/bin/bash

# ENVIRONMENT
ROOT_DIR=`pwd`

LOG_DIR="${ROOT_DIR}/logs"
if [ ! -d "${LOG_DIR}" ]; then
  mkdir -p ${LOG_DIR}
fi

BENCH_LOGS="${ROOT_DIR}/results"
if [ ! -d "${BENCH_LOGS}" ]; then
  mkdir -p ${BENCH_LOGS}
fi

python3 -m venv env 
source ./env/bin/activate
pip install GitPython==3.0.6
pip install truffleHogRegexes
git config --global diff.renameLimit 9999 # for detect-secrets

# TOOLS
TOOLS_DIR="`pwd`/tools"
if [ ! -d "${TOOLS_DIR}" ]; then

  mkdir ${TOOLS_DIR}
  cd ${TOOLS_DIR}


  # TruffleHog
  if ! trufflehog -h &> /dev/null ; then

    # v3.63.1 (golang)
    git clone --branch v3.63.1 https://github.com/trufflesecurity/trufflehog.git
    cd trufflehog
    sudo GOBIN=/usr/local/bin/ /usr/local/go/bin/go install
    cd ${TOOLS_DIR}

    # 2.1.13 (python)
    git clone --branch v2 https://github.com/trufflesecurity/trufflehog.git trufflehog_v2
    cd trufflehog_v2
    git checkout 82dd2d5
    cd ${TOOLS_DIR}

  fi

  # Amazon git-secrets
  if ! git-secrets -h &> /dev/null ; then
    git clone --branch 1.3.0 https://github.com/awslabs/git-secrets.git
    cd gitleaks
    sudo make install
    cd ${TOOLS_DIR}


    # configure patterns to detect
    declare -a pattern_array=(
      '\-{5}BEGIN [A-Z]+ PRIVATE KEY\-{5}',                                           # Private Keys
      'AIza[0-9A-Za-z_-]{35}',                                                        # Google API Key
      'ya29\.[0-9A-Za-z\-_]+',                                                        # Google OAuth Access Token
      'AKIA[0-9A-Z]{16}',                                                             # AWS Key
      'amzn\\.mws\\.[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'     # Amazon MWS
      'EAACEdEose0cBA[0-9A-Za-z]+',                                                   # Facebook
      '[rs]k_live_[a-zA-Z0-9]{20,30}',                                                # Stripe
      '(xox[pborsa]-[0-9]{12}-[0-9]{12}-[0-9]{12}-[a-z0-9]{32})'                      # Slack Token
      'sq0atp-[0-9A-Za-z\\-_]{22}'                                                    # Square
    )


    for PATTERN in "${pattern_array[@]}"
    do
      git secrets --add ${PATTERN} --global
    done
  fi

  # gitleaks
  if ! git-secrets -h &> /dev/null ; then
    git clone --branch v8.18.1 https://github.com/gitleaks/gitleaks.git
    cd gitleaks
    make build
    sudo GOBIN=/usr/local/bin/ /usr/local/go/bin/go install
  fi

  # noseyparker
  if ! noseyparker -h &> /dev/null ; then
    sudo mkdir -p /usr/local/bin/noseyparker/
    sudo tar -xvzf  noseyparker-v0.15.0-x86_64-unknown-linux-gnu.tar.gz -C /usr/local/bin/noseyparker/
    echo 'export PATH=$PATH:/usr/local/bin/noseyparker/bin' >> ~/.profile
  fi

fi


if [ ! -f ./env/bin/detect-secrets ]; then
  pip install detect-secrets==1.4.0
fi


# LOCAL SOURCES
REPO_DIR="`pwd`/repos"
if [ ! -d "${REPO_DIR}" ]; then
  mkdir ${REPO_DIR}
  cd ${REPO_DIR}
  git clone --branch v0.1-alpha https://github.com/0x736E/random-data-samples.git   # 3 (lots of files)
  git clone --branch v0.1-alpha https://github.com/0x736E/expired-creds.git         # 14
  git clone --branch v8.18.1 https://github.com/gitleaks/gitleaks.git               # 982
  git clone --branch v19.2.2 https://github.com/puppeteer/puppeteer.git             # 3,039
  git clone --branch v1.38.4 https://github.com/denoland/deno.git                   # 10,285
  git clone --branch openssl-3.2.0 https://github.com/openssl/openssl.git           # 34,291
  git clone --branch 12.1.284 https://github.com/v8/v8.git                          # 85,803
  git clone --branch v6.6 https://github.com/torvalds/linux.git                     # 1,217,245
  cd ..
fi


function do_benchmark () {

    # configure patterns to detect
    declare -a repo_array=(
      "${REPO_DIR}/expired-creds"
      "${REPO_DIR}/random-data-samples"
      "${REPO_DIR}/gitleaks"
      "${REPO_DIR}/puppeteer"
      "${REPO_DIR}/deno" 
      "${REPO_DIR}/openssl"
      "${REPO_DIR}/v8"
      "${REPO_DIR}/linux"
    )

    INDEX=0
    for REPO_URL in "${repo_array[@]}"
    do
      INDEX=$(expr $INDEX + 1)
      echo "Running benchmark (${INDEX}) for ${REPO_URL}"
      hyperfine \
        -w 3 \
        -r 10 \
        --ignore-failure \
        --export-markdown "${BENCH_LOGS}/bench_${INDEX}.md" \
        --export-json "${BENCH_LOGS}/bench_${INDEX}.json" \
        --export-csv "${BENCH_LOGS}/bench_${INDEX}.csv" \
        --time-unit millisecond \
        --setup 'rm -rf datastore.np' \
        --cleanup 'rm -rf datastore.np' \
        --prepare 'rm -rf datastore.np' \
        \
        -n "git-log" \
        "git log --oneline -p --pickaxe-regex -S'(\-{5}BEGIN [A-Z]+ PRIVATE KEY\-{5})|(AIza[0-9A-Za-z_-]{35})|(ya29\.[0-9A-Za-z\-_]+)|(AKIA[0-9A-Z]{16})|(amzn\\.mws\\.[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})|(EAACEdEose0cBA[0-9A-Za-z]+)|([rs]k_live_[a-zA-Z0-9]{20,30})|(xox[pborsa]-[0-9]{12}-[0-9]{12}-[0-9]{12}-[a-z0-9]{32})|sq0atp-[0-9A-Za-z\\-_]{22}'  >> ${LOG_DIR}/git-log_${INDEX}.log" \
        \
        -n "gitleaks (v8.18.1)" \
        "gitleaks detect -s ${REPO_URL} >> ${LOG_DIR}/gitleaks_${INDEX}.log" \
        \
        -n "noseyparker (v0.15.0)" \
        "noseyparker scan ${REPO_URL} >> ${LOG_DIR}/noseyparker_${INDEX}.log" \
        \
        -n "git-secrets (1.3.0)" \
        "cd ${REPO_URL} && git secrets --scan-history >> ${LOG_DIR}/git-secrets_${INDEX}.log && cd ${ROOT_DIR}" \
        \
        -n "detect-secrets (1.4.0)" \
        "./env/bin/detect-secrets -C {REPO_URL} scan >> ${LOG_DIR}/detect-secrets_${INDEX}.log" \
        \
        -n "trufflehog (2.2.1)" \
        "python tools/trufflehog_v2/truffleHog/truffleHog.py --repo_path ${REPO_URL} bug_requires_git_url_even_though_its_not_used >> ${LOG_DIR}/trufflehog_v2_${INDEX}.log" \
        \
        -n "trufflehog (2.2.1) (no-entropy)" \
        "python tools/trufflehog_v2/truffleHog/truffleHog.py --entropy False --repo_path ${REPO_URL} bug_requires_git_url_even_though_its_not_used >> ${LOG_DIR}/trufflehog_v2_noentropy_${INDEX}.log" \
        \
        -n "trufflehog (3.63.1)" \
        "trufflehog --no-verification --no-update filesystem ${REPO_URL} >> ${LOG_DIR}/trufflehog_v3_${INDEX}.log"
    done

}

do_benchmark
