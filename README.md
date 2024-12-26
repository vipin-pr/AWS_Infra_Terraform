Here’s an advanced Terraform practice task to help you use most of Terraform’s features, focusing on AWS:

---

### **Task: Build a Scalable Web Application on AWS**

**Objective**: Use Terraform to deploy a scalable web application with a highly available infrastructure on AWS. This task will involve networking, compute, storage, load balancing, and IAM. You’ll leverage Terraform features like modules, workspaces, variables, outputs, conditional expressions, and the `for_each` loop.

---

### **Requirements**

1. **Networking**:
   - Create a VPC with multiple subnets (public and private).
   - Set up an Internet Gateway for public subnets.
   - Set up NAT Gateways for private subnets.

2. **Compute**:
   - Launch EC2 instances in private subnets as application servers.
   - Use an Auto Scaling Group to ensure a minimum of 2 and a maximum of 5 instances.
   - Attach a Security Group to the EC2 instances to allow only necessary traffic (e.g., SSH, HTTP).

3. **Storage**:
   - Attach an S3 bucket for storing application data.
   - Enable versioning and server-side encryption for the bucket.

4. **Load Balancing**:
   - Deploy an Application Load Balancer (ALB) in public subnets.
   - Forward HTTP traffic to the EC2 instances in the private subnets.

5. **IAM**:
   - Create an IAM Role for the EC2 instances to allow access to the S3 bucket.
   - Create an IAM Policy for restricting bucket access.

6. **Variables**:
   - Use variables for common configurations (e.g., region, instance type, bucket name).
   - Include default values and allow overrides through `terraform.tfvars`.

7. **Outputs**:
   - Output the ALB DNS name and S3 bucket name after deployment.

8. **Modules**:
   - Break the configuration into reusable modules (e.g., networking, compute, storage).

9. **Workspaces**:
   - Use workspaces to deploy separate environments (`dev` and `prod`) with different instance sizes and scaling limits.

10. **Conditional Logic**:
    - Use conditional expressions to enable logging for the S3 bucket only in the `prod` environment.

11. **Provisioning**:
    - Use a provisioner to execute a script on EC2 instances to configure the application.

---

### **Features Used**
- **Variables**: For flexible and reusable configurations.
- **Outputs**: To share important information after deployment.
- **Modules**: To organize your Terraform code into logical components.
- **Workspaces**: For environment-specific configurations.
- **for_each**: For creating resources dynamically.
- **Provisioners**: For EC2 instance configuration.
- **Conditional Expressions**: For environment-specific customizations.

---

### **Expected Deliverables**
1. **Terraform Code**:
   - `main.tf`: The entry point for calling modules and managing resources.
   - `variables.tf`: Definition of variables.
   - `outputs.tf`: Outputs of the infrastructure.
   - `modules/`: Directory containing the `networking`, `compute`, and `storage` modules.

2. **Deployment**:
   - Use `terraform workspace new dev` to create a `dev` environment.
   - Use `terraform workspace new prod` to create a `prod` environment.

3. **Validation**:
   - Access the ALB DNS and verify that traffic is routed to the EC2 instances.
   - Check the S3 bucket for proper versioning and encryption settings.
   - Confirm IAM role and policy are correctly attached to the EC2 instances.

---
