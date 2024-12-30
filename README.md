## Features
1. spin up EC2 instance based on amazon linux2 on default VPC public subnet

## Usage

```
module "ec2module" {
  source  = "rajibpodder12/ec2module/aws"
  version = "4.0.0"
  # insert the 2 required variables here
}

```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2 |
| <a name="provider_http "></a> [http](#provider\_http)| 3.4.5 |
