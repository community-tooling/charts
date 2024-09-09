# Contributing

Pull requests are welcome here. Please keep the [Code of Conduct](CODE_OF_CONDUCT.md) in mind when contributing.

## Opening issues

Please describe the problem or your suggestion as detailed as possible when opening an issue.

## Development

Before you commit, please run pre-commit. This will also generate the documentation for the helm charts.

To set up pre-commit to run automatically on commit, run (example for Ubuntu)

```sh
# Linux
pip3 install pre-commit

# macOS
brew install pre-commit

# Install the unittest plugin
make install

pre-commit install --hook-type commit-msg --hook-type pre-commit
```

### Commit messages

This repository uses [Conventional Commit messages](https://www.conventionalcommits.org/en/v1.0.0/). Please ensure all your commit messages follow this syntax to enable people to quickly check what a commit does.

Valid commit types are defined in [commitizen/conventional-commit-types](https://github.com/commitizen/conventional-commit-types/blob/v3.0.0/index.json).

### Versioning

Helm charts use semantic versioning. For the charts in this repository, only `[MAJOR].[MINOR].[PATCH]` syntax is used, without any pre-releases.

Please bump as follows:

- Major version for breaking changes (this includes updates of default values as users may need to manually update their values)
- Minor version when you add features
- Patch version for bug fixes and documentation updates
