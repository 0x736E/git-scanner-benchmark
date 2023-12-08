# Introduction
Benchmarks of various tools for detecting secrets in git repositories.


## Laptop: 
* Apple MacBook Pro 16" 2023 
* M2 Max (ARM)
* 32 GB
* 1 TB SSD

#### https://github.com/0x736E/expired-creds.git
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|
| `gitleaks` | 2.9 ± 0.1 | 2.7 | 3.1 | 1.00 |
| `trufflehog v3` | 63.9 ± 0.5 | 63.2 | 64.6 | 21.82 ± 0.86 |
| `noseyparker` | 183.6 ± 1.4 | 180.2 | 185.1 | 62.69 ± 2.48 |
| `trufflehog v2 (entropy enabled)` | 8909.5 ± 24.8 | 8871.4 | 8942.5 | 3042.51 ± 118.30 |
| `detect-secrets` | 89866.4 ± 7514.7 | 82085.0 | 102517.1 | 30688.32 ± 2828.74 |


#### https://github.com/openssl/openssl
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|
| `gitleaks` | 3.2 ± 0.1 | 3.1 | 3.3 | 1.00 |
| `trufflehog v3` | 67.4 ± 0.5 | 66.1 | 68.0 | 21.09 ± 0.45 |
| `noseyparker` | 186.6 ± 3.3 | 183.1 | 193.7 | 58.41 ± 1.55 |
| `detect-secrets` | 47851.8 ± 180.5 | 47547.5 | 48252.2 | 14977.29 ± 301.76 |
| `trufflehog v2 (entropy enabled)` | 903969.5 ± 4880.2 | 893116.3 | 911869.6 | 282936.24 ± 5804.31 |


## Laptop: 
* Apple MacBook Pro 15" 2019
* i9 2.4GHz (x86)
* 32 GB
* 1 TB SSD

#### https://github.com/0x736E/expired-creds.git
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|
| `gitleaks` | 8.8 ± 2.4 | 6.7 | 13.3 | 1.00 |
| `trufflehog v3` | 171.0 ± 11.5 | 158.8 | 195.2 | 19.41 ± 5.40 |
| `noseyparker` | 467.9 ± 6.2 | 461.6 | 479.0 | 53.09 ± 14.36 |
| `trufflehog v2 (entropy enabled)` | 24489.9 ± 2018.2 | 22087.2 | 28583.8 | 2778.64 ± 784.87 |
| `detect-secrets` | 96907.8 ± 8787.9 | 83753.0 | 108471.2 | 10995.20 ± 3133.54 |


#### https://github.com/openssl/openssl
| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|
| `gitleaks` |  5.8 ± 0.6 |       5.2 |       7.0 |   1.00 |
| `trufflehog v3` |   145.0 ± 3.0 |     140.0 |     149.0 | 25.00 ± 0.51 |
| `noseyparker` | 662.9 ± 68.1 |     570.0 |     747.1 |  113.73 ± 16.38 |
| `detect-secrets` |   154129.0 ± 43882.3 |  111570.9 |  207589.2 | 26443.80 ± 7988.03 |
| `trufflehog v2 (entropy enabled)` | 3105848.0 ± 406515.0 | 2855278.0 | 4053491.0 |    535491.03 ± 92326.03 |


## Server: 
* Intel Xeon E3-1270v6 - 4c/8t - 3.8 GHz/4.2 GHz
* 32 GB ECC 2400 MHz
* 2 × 450 GB SSD NVMe (SoftRaid)

#### https://github.com/0x736E/expired-creds.git

| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|
| `git-log` | 0.8 ± 0.0 | 0.8 | 0.9 | 1.00 |
| `detect-secrets (1.4.0)` | 134.3 ± 0.5 | 133.7 | 135.0 | 165.89 ± 6.45 |
| `trufflehog (3.63.1)` | 884.1 ± 5.8 | 874.5 | 892.2 | 1091.85 ± 42.87 |
| `noseyparker (v0.15.0)` | 999.5 ± 13.7 | 989.7 | 1033.8 | 1234.42 ± 50.70 |
| `git-secrets (1.3.0)` | 2256.4 ± 3.0 | 2252.0 | 2261.5 | 2786.82 ± 107.93 |
| `gitleaks (v8.18.1)` | 2910.1 ± 28.1 | 2861.2 | 2937.7 | 3594.12 ± 143.37 |
| `trufflehog (2.2.1) (no-entropy)` | 6699.8 ± 153.7 | 6537.6 | 7059.4 | 8274.64 ± 372.29 |

#### https://github.com/0x736E/random-data-samples.git

| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|
| `git-log` | 0.9 ± 0.1 | 0.8 | 0.9 | 1.00 |
| `detect-secrets (1.4.0)` | 134.3 ± 0.3 | 133.9 | 134.7 | 156.42 ± 11.04 |
| `noseyparker (v0.15.0)` | 22139.1 ± 398.2 | 21671.5 | 23137.7 | 25789.68 ± 1877.54 |
| `trufflehog (2.2.1) (no-entropy)` | 32985.9 ± 201.8 | 32776.8 | 33325.4 | 38425.10 ± 2720.87 |
| `git-secrets (1.3.0)` | 59740.5 ± 106.4 | 59572.5 | 59901.2 | 69591.40 ± 4910.89 |
| `gitleaks (v8.18.1)` | 256553.0 ± 618.1 | 255934.4 | 257964.5 | 298857.33 ± 21095.17 |
| `trufflehog (3.63.1)` | 1123970.5 ± 1831.3 | 1120992.7 | 1126743.2 | 1309307.86 ± 92389.69 |

#### https://github.com/gitleaks/gitleaks.git

| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
|:---|---:|---:|---:|---:|
| `git-log` | 0.8 ± 0.0 | 0.8 | 0.9 | 1.00 |
| `detect-secrets (1.4.0)` | 133.9 ± 0.5 | 133.2 | 134.7 | 162.97 ± 6.44 |
| `noseyparker (v0.15.0)` | 602.9 ± 13.9 | 589.4 | 632.4 | 733.73 ± 33.46 |
| `gitleaks (v8.18.1)` | 887.4 ± 15.7 | 871.5 | 910.2 | 1079.98 ± 46.62 |
| `trufflehog (3.63.1)` | 1017.1 ± 68.5 | 954.5 | 1191.3 | 1237.77 ± 96.57 |
| `trufflehog (2.2.1) (no-entropy)` | 5777.1 ± 105.2 | 5621.8 | 5937.4 | 7030.60 ± 304.96 |
| `git-secrets (1.3.0)` | 61506.3 ± 64.4 | 61444.5 | 61648.2 | 74852.14 ± 2947.65 |

