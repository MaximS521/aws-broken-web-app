#!/usr/bin/env bash
set -euo pipefail
STACK="${1:-broken-webapp}"
REGION="us-east-1"
TEMPLATE_URL="$(cat "$(dirname "$0")/template-url.txt")"

aws cloudformation create-stack \
  --stack-name "$STACK" \
  --region "$REGION" \
  --template-url "$TEMPLATE_URL" \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM

echo "Waiting for stack create to complete..."
aws cloudformation wait stack-create-complete --stack-name "$STACK" --region "$REGION"

aws cloudformation describe-stacks --stack-name "$STACK" --region "$REGION" \
  --query "Stacks[0].Outputs"
