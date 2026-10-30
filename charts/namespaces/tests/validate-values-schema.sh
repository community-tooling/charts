#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHART_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
VALID_DIR="${SCRIPT_DIR}/values/valid"
INVALID_DIR="${SCRIPT_DIR}/values/invalid"
TMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "${TMP_DIR}"
}

trap cleanup EXIT

run_checked() {
  local label="$1"
  local output_file="$2"
  shift 2

  if ! "$@" >"${output_file}" 2>&1; then
    echo "FAILED: ${label}"
    echo "command: $*"
    echo "output:"
    sed 's/^/  /' "${output_file}"
    exit 1
  fi
}

run_valid() {
  local file lint_output template_output
  file="$1"
  lint_output="${TMP_DIR}/$(basename "${file}").lint.out"
  template_output="${TMP_DIR}/$(basename "${file}").template.out"

  echo "valid: ${file}"
  run_checked "helm lint for valid fixture ${file}" "${lint_output}" \
    helm lint "${CHART_DIR}" -f "${file}"
  run_checked "helm template for valid fixture ${file}" "${template_output}" \
    helm template test-release "${CHART_DIR}" -f "${file}"
}

run_invalid() {
  local file lint_output
  file="$1"
  lint_output="${TMP_DIR}/$(basename "${file}").lint.out"

  echo "invalid: ${file}"
  if helm lint "${CHART_DIR}" -f "${file}" >"${lint_output}" 2>&1; then
    echo "FAILED: expected helm lint to fail for invalid fixture ${file}"
    echo "command: helm lint ${CHART_DIR} -f ${file}"
    echo "output:"
    sed 's/^/  /' "${lint_output}"
    exit 1
  fi
}

for file in "${VALID_DIR}"/*.yaml; do
  run_valid "${file}"
done

for file in "${INVALID_DIR}"/*.yaml; do
  run_invalid "${file}"
done

echo "schema fixture validation passed"
