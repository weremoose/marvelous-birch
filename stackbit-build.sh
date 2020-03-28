#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5db57ebbc3ba9f0014f134ee/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5db57ebbc3ba9f0014f134ee 
fi
curl -s -X POST https://api.stackbit.com/project/5db57ebbc3ba9f0014f134ee/webhook/build/ssgbuild > /dev/null
gatsby build

curl -s -X POST https://api.stackbit.com/project/5db57ebbc3ba9f0014f134ee/webhook/build/publish > /dev/null
