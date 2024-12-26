## Features
1. spin up EC2 instance based on amazon linux2 on default VPC public subnet

## Usage

```
module "ec2" {
    source = "rajibpodder12/terraform-aws-ec2module/modules"
}

```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.46.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |