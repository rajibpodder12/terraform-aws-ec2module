variable "region" { 
    type = string
    description = "provide aws_region as input variable"
    }
variable "instance_type" {
    type = string
    description = "instance type should be t2.micro, otherwise it will error out"
    validation {
        condition = var.instance_type != "t2.micro"
        error_message = "Instance type should be t2.micro"
    }
}
