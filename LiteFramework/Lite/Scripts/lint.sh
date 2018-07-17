#!/usr/bin/env bash

# Run SwiftLint
START_DATE=$(date +"%s")

SWIFT_LINT=${PODS_ROOT}/SwiftLint/swiftlint

# Run SwiftLint for given filename
run_swiftlint() {
local filename="${1}"
${SWIFT_LINT} lint --path "${filename}"
}

if [[ -e "${SWIFT_LINT}" ]]; then
echo "SwiftLint version: $(${SWIFT_LINT} version)"
# Run for both staged and unstaged files
git diff --relative --diff-filter=d --name-only | grep "\.swift" | while read filename; do run_swiftlint "${filename}"; done
git diff --relative --diff-filter=d --cached --name-only | grep "\.swift" | while read filename; do run_swiftlint "${filename}"; done
else
echo "${SWIFT_LINT} is not installed."
exit 1
fi

END_DATE=$(date +"%s")

DIFF=$(($END_DATE - $START_DATE))
echo "SwiftLint took $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds to complete."
