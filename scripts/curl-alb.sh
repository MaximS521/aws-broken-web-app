#!/usr/bin/env bash
set -euo pipefail
ALB_DNS="$1"
curl -I "http://$ALB_DNS"
