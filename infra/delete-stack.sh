#!/usr/bin/env bash
set -euo pipefail
STACK="${1:-broken-webapp}"
REGION="us-east-1"

aws cloudformation delete-stack --stack-name "$STACK" --region "$REGION"
echo "Waiting for stack delete..."
aws cloudformation wait stack-delete-complete --stack-name "$STACK" --region "$REGION"
echo "Deleted."
