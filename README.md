# Azure Secure Infrastructure Automation with Terraform

## **Table of Contents**

1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Architecture Diagram](#architecture-diagram)
4. [Setup & Configuration](#setup-configuration)
    - [Pre-requisites](#pre-requisites)
    - [Running the Code](#running-the-code)
    - [Cleaning Up Resources](#cleaning-up-resources)
5. [Security Best Practices](#security-best-practices)
6. [Conclusion](#conclusion)
7. [Sources](#sources)

---

## **Project Overview**

This project demonstrates the process of securely provisioning and managing infrastructure on **Microsoft Azure** using **Terraform**. The focus is on automating the creation of key cloud resources such as **resource groups**, **virtual networks**, **subnets**, **network security groups (NSGs)**, **Windows virtual machines (VMs)**, and **public IP addresses** with a strong emphasis on **security best practices**. It is intended to help you quickly set up a scalable, secure environment on Azure with a clear and repeatable infrastructure-as-code workflow.

The primary goal of this project is to showcase how to:

- Automate the deployment of secure, cost-effective, and scalable cloud infrastructure.
- Follow industry-standard **security best practices** for managing sensitive data, such as using **Azure Key Vault** for passwords and secrets.
- Demonstrate proficiency in **Terraform** and **Azure**, which are essential skills for modern cloud security professionals and DevOps engineers.

---

## **Features**

This project contains the following key features:

- **Resource Group**: A dedicated **resource group** is created to logically organize and manage all the Azure resources within a defined scope.
- **Virtual Network and Subnet**: A **Virtual Network (VNet)** with a **subnet** is set up to ensure isolated networking for the resources in the environment.
- **Network Security Group (NSG)**: A **Network Security Group** (NSG) is created with specific inbound and outbound rules to ensure that only necessary ports (such as RDP for Windows VMs) are open, limiting exposure to unauthorized traffic.
- **Key Vault Integration**: Sensitive information such as VM **admin passwords** is stored in **Azure Key Vault**, ensuring that credentials are kept secure and separate from the infrastructure code.
- **Windows Virtual Machine**: A **Windows VM** is provisioned using the latest **Windows Server 2022** image. The VM is associated with the virtual network and security group to ensure proper networking and security controls.
- **Public IP Address**: A **static public IP address** is provisioned for the VM, allowing remote access, but securely restricted via NSG rules.
- **Modular and Scalable Design**: The project uses **variables** to make it flexible and scalable, allowing you to easily modify parameters like the VM size, location, and admin credentials.

---

## **Setup & Configuration**

### **Pre-requisites**

To run this project, you must have the following tools installed and set up on your machine:

1. **Terraform**: Ensure you have **Terraform 1.x** installed. You can download it from the [official Terraform website](https://www.terraform.io/downloads.html).
2. **Azure CLI**: The **Azure CLI** should be installed and authenticated on your system. Follow the instructions to install the Azure CLI from [here](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
3. **An Azure Subscription**: You must have an active Azure subscription. You can sign up for a free account if needed [here](https://azure.microsoft.com/free/).

### **Running the Code**

Follow these steps to deploy the infrastructure:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/azure-terraform-infrastructure.git
   cd azure-terraform-infrastructure
   ```

2. **Set Variables**:
   Update the `terraform.tfvars` file with your preferred configuration values, such as the **admin username** and **location** for the resources.

3. **Initialize Terraform**:
   Initialize the Terraform project to download the required providers and modules.
   ```bash
   terraform init
   ```

4. **Apply the Terraform Configuration**:
   Run `terraform apply` to create the infrastructure. Review the execution plan and type `yes` to proceed.
   ```bash
   terraform apply
   ```

5. **Verify the Deployment**:
   Once the infrastructure is applied successfully, you can access the public IP address of the **Windows VM** to verify the setup. You can find the IP address in the output from Terraform.

### **Cleaning Up Resources**

To clean up the resources and avoid unnecessary charges, use the `terraform destroy` command:
```bash
terraform destroy
```
Confirm the destruction of resources by typing `yes` when prompted.

---

## **Security Best Practices**

This project follows several key **security best practices** for working with cloud infrastructure:

1. **Sensitive Information Management**:
   - The **admin password** for the Windows VM is stored in **Azure Key Vault**, not hard-coded in the Terraform files. This ensures that sensitive information is kept secure and not exposed in version control.
   - **Key Vault** is referenced through the `azurerm_key_vault_secret` resource, making the secrets management more secure.

2. **Network Security**:
   - **Network Security Groups (NSGs)** are configured to restrict RDP access to the VM to only the **allowed IP address**. This limits exposure to just the required source IP.
   - The **RDP rule** is configured with the **priority** of 100, which ensures that it takes precedence over other conflicting rules.

3. **Least Privilege Principle**:
   - The setup is designed to expose only essential services (such as RDP) and to keep all unnecessary ports closed.
   - Use of the **Azure Key Vault** and secure access controls to manage passwords follows the **least privilege principle** by restricting access to sensitive resources.

4. **Modular Code**:
   - The use of **variables** and **outputs** allows for easier modification and maintenance of the Terraform configuration, making it reusable and adaptable for different environments and use cases.

---

## **Conclusion**

This project is a comprehensive demonstration of securely provisioning infrastructure on **Azure** using **Terraform**. It showcases how to automate the creation of key resources like **virtual machines**, **virtual networks**, **public IPs**, and **network security groups**, while adhering to **cloud security best practices**. The modular and flexible design ensures that this setup can be easily adapted for different cloud environments and scaled to meet various requirements.

---

## **Sources**

1. [Terraform Documentation](https://www.terraform.io/docs)
2. [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
3. [Azure Key Vault Documentation](https://learn.microsoft.com/en-us/azure/key-vault/)
4. [Azure Network Security Group Best Practices](https://learn.microsoft.com/en-us/azure/network-security/network-security-best-practices)
