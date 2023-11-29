| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|
| `noseyparker scan $/Users/seannicholls/projects/benchmark/git-scanner-benchmark/repos/openssl` | 2.4 ± 0.2 | 2.2 | 2.7 | 1.00 |
| `noseyparker scan $/Users/seannicholls/projects/benchmark/git-scanner-benchmark/repos/expired-creds` | 2.4 ± 0.2 | 2.2 | 2.9 | 1.01 ± 0.11 |
| `gitleaks detect -s $/Users/seannicholls/projects/benchmark/git-scanner-benchmark/repos/openssl` | 3.0 ± 0.1 | 2.8 | 3.2 | 1.25 ± 0.10 |
| `gitleaks detect -s $/Users/seannicholls/projects/benchmark/git-scanner-benchmark/repos/expired-creds` | 3.0 ± 0.1 | 2.8 | 3.1 | 1.26 ± 0.11 |
| `trufflehog --no-verification --no-update filesystem $/Users/seannicholls/projects/benchmark/git-scanner-benchmark/repos/openssl` | 64.3 ± 0.5 | 63.1 | 64.8 | 27.00 ± 1.94 |
| `trufflehog --no-verification --no-update filesystem $/Users/seannicholls/projects/benchmark/git-scanner-benchmark/repos/expired-creds` | 64.3 ± 0.4 | 63.7 | 65.1 | 27.02 ± 1.94 |
| `./env/bin/trufflehog /Users/seannicholls/projects/benchmark/git-scanner-benchmark/repos/openssl` | 73.3 ± 1.0 | 72.6 | 76.0 | 30.80 ± 2.24 |
| `./env/bin/detect-secrets -C /Users/seannicholls/projects/benchmark/git-scanner-benchmark/repos/openssl scan` | 107.1 ± 3.9 | 101.9 | 112.8 | 45.00 ± 3.60 |
| `./env/bin/trufflehog /Users/seannicholls/projects/benchmark/git-scanner-benchmark/repos/expired-creds` | 8977.5 ± 49.0 | 8897.0 | 9044.7 | 3772.10 ± 269.98 |
| `./env/bin/detect-secrets -C /Users/seannicholls/projects/benchmark/git-scanner-benchmark/repos/expired-creds scan` | 73404.5 ± 3070.6 | 70963.2 | 79161.2 | 30842.62 ± 2551.33 |
