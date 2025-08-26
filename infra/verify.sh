#!/usr/bin/env bash
set -euo pipefail
STACK="${1:-broken-webapp}"
REGION="us-east-1"

echo "ALB DNS:"
ALB_DNS=$(aws elbv2 describe-load-balancers --region "$REGION" \
  --query "LoadBalancers[0].DNSName" --output text)
echo "$ALB_DNS"

echo
echo "Listeners:"
aws elbv2 describe-listeners --load-balancer-arn "$(aws elbv2 describe-load-balancers --region "$REGION" --query "LoadBalancers[0].LoadBalancerArn" --output text)" --region "$REGION"

echo
echo "Target Groups & Health:"
TG_ARN=$(aws elbv2 describe-target-groups --region "$REGION" --query "TargetGroups[0].TargetGroupArn" --output text)
aws elbv2 describe-target-health --target-group-arn "$TG_ARN" --region "$REGION"

echo
echo "HTTP HEAD via curl:"
curl -I "http://$ALB_DNS" || true
