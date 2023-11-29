# Introduction
Benchmarks of various tools for detecting secrets in git repositories.

## Methodology
The benchmarks are run using hyperfine, against the following repositories:
* https://github.com/0x736E/expired-creds
* https://github.com/openssl/openssl


### Apple MacBook Pro 16" 2023 M2 Max 32GB

#### expired-creds
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|
| `gitleaks` | 2.9 ± 0.1 | 2.7 | 3.1 | 1.00 |
| `trufflehog v3` | 63.9 ± 0.5 | 63.2 | 64.6 | 21.82 ± 0.86 |
| `noseyparker` | 183.6 ± 1.4 | 180.2 | 185.1 | 62.69 ± 2.48 |
| `trufflehog v2` | 8909.5 ± 24.8 | 8871.4 | 8942.5 | 3042.51 ± 118.30 |
| `detect-secrets` | 89866.4 ± 7514.7 | 82085.0 | 102517.1 | 30688.32 ± 2828.74 |


#### openssl
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|
| `gitleaks` | 3.2 ± 0.1 | 3.1 | 3.3 | 1.00 |
| `trufflehog v3` | 67.4 ± 0.5 | 66.1 | 68.0 | 21.09 ± 0.45 |
| `noseyparker` | 186.6 ± 3.3 | 183.1 | 193.7 | 58.41 ± 1.55 |
| `detect-secrets` | 47851.8 ± 180.5 | 47547.5 | 48252.2 | 14977.29 ± 301.76 |
| `trufflehog v2` | 903969.5 ± 4880.2 | 893116.3 | 911869.6 | 282936.24 ± 5804.31 |

