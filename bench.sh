#!/bin/zsh

python3 -m venv env 
source ./env/bin/activate

if [ ! -d ./repos ]; then
  mkdir repos
fi

if [ ! -d ./repos/expired-creds ]; then
  cd repos
  git clone https://github.com/0x736E/expired-creds.git
  cd ..
fi

if [ ! -d ./repos/openssl ]; then
  cd repos
  git clone https://github.com/openssl/openssl.git
  cd ..
fi

if [ ! -f ./env/bin/trufflehog ]; then
	pip install trufflehog
fi

if [ ! -f ./env/bin/detect-secrets ]; then
	pip install detect-secrets
fi

REPO_DIR="`pwd`/repos"


hyperfine \
  -w 3 \
  -r 10 \
  --sort 'mean-time' \
  --ignore-failure \
  --export-markdown bench.md \
  -L REPO_URL "${REPO_DIR}/expired-creds" \
  --setup 'rm -rf datastore.np' \
  --cleanup 'rm -rf datastore.np' \
  --prepare 'rm -rf datastore.np' \
  -n 'noseyparker' \
  'noseyparker scan ${REPO_URL}' \
  -n 'detect-secrets' \
  './env/bin/detect-secrets -C {REPO_URL} scan' \
  -n 'gitleaks' \
  'gitleaks detect -s ${REPO_URL}' \
  -n 'trufflehog v2' \
  './env/bin/trufflehog {REPO_URL}' \
  -n 'trufflehog v3' \
  'trufflehog --no-verification --no-update filesystem ${REPO_URL}'


hyperfine \
  -w 3 \
  -r 10 \
  --sort 'mean-time' \
  --ignore-failure \
  --export-markdown bench2.md \
  -L REPO_URL "${REPO_DIR}/openssl" \
  --setup 'rm -rf datastore.np' \
  --cleanup 'rm -rf datastore.np' \
  --prepare 'rm -rf datastore.np' \
  -n 'noseyparker' \
  'noseyparker scan ${REPO_URL}' \
  -n 'detect-secrets' \
  './env/bin/detect-secrets -C {REPO_URL} scan' \
  -n 'gitleaks' \
  'gitleaks detect -s ${REPO_URL}' \
  -n 'trufflehog v2' \
  './env/bin/trufflehog {REPO_URL}' \
  -n 'trufflehog v3' \
  'trufflehog --no-verification --no-update filesystem ${REPO_URL}'

decativate