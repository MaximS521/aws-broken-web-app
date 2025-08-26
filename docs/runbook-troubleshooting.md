# Troubleshooting Runbook

## Symptoms
- ALB DNS endpoint not resolving or loading
- Target Group targets reported as Unhealthy

## Checks (in order)
1. **Target Group → Targets**: Confirm EC2 instances are registered.  
2. **Health checks**: Ensure path is `/`, port 80, success codes include `200`.  
3. **Security Groups**:  
   - ALB SG inbound: allow HTTP :80 from 0.0.0.0/0  
   - EC2 SG inbound: allow HTTP :80 only from ALB SG  
4. **Application Layer**:  
   - `curl -I http://localhost`  
   - `systemctl status httpd` (Amazon Linux) / `apache2` (Ubuntu)  
5. **DNS Accuracy**:  
   - Copy ALB DNS name from **EC2 → Load Balancers → Description**  
   - Watch for typos between lowercase `l` and uppercase `I`
