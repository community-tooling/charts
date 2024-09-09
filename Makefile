SHELL := /bin/bash -o pipefail -o errexit

install:
	helm plugin install https://github.com/helm-unittest/helm-unittest
