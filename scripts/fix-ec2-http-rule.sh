#!/usr/bin/env bash
# Example: add HTTP 80 from ALB SG to EC2 SG
set -euo pipefail
EC2_SG_ID="${1:-sg-xxxxxxxxxxxxxxx}"
ALB_SG_ID="${2:-sg-yyyyyyyyyyyyyyy}"
REGION="${3:-us-east-1}"

aws ec2 authorize-security-group-ingress \
  --group-id "$EC2_SG_ID" \
  --region "$REGION" \
  --ip-permissions IpProtocol=tcp,FromPort=80,ToPort=80,UserIdGroupPairs="[{GroupId=$ALB_SG_ID}]"
