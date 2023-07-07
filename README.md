# charts

This repository contains all charts that I use throughout my infrastructure that weren’t already built by someone else.

Pull requests are welcome, check [CONTRIBUTING.md](CONTRIBUTING.md) for detailed information.

## Usage

```sh
helm repo add community-tooling https://community-tooling.github.io/charts/

# Install a cronjob with the cronjob chart. Fill the my-cron-values.yaml file before running this!
helm install cronjob community-tooling/cronjob --values my-cron-values.yaml
```

## Maintainers

The people listed here maintain this repository. At least one of them will automatically get requested as a reviewer for PRs. On issues, feel free to mention us.

| Avatar                                                                        | Name               |
| ----------------------------------------------------------------------------- | ------------------ |
| ![Avatar of morremeyer](https://avatars.githubusercontent.com/u/7683567?s=80) | Morre (morremeyer) |
| ![Avatar of ekeih](https://avatars.githubusercontent.com/u/3430656?s=80)      | Max Rosin (ekeih)  |
