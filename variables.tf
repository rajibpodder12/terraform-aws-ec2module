variable "region" { type = string}
variable "instance_type" {
    type = string
    validation {
        condition = var.instance_type != "t2.micro"
        error_message = "Instance type should be t2.micro"
    }
}
