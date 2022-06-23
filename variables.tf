variable "ami" {
    default = "ami-0022f774911c1d690"
    description = "AWS Instance AMI"
}

variable "instance_type" {
    default = "m5.xlarge"
    description = "Size of the Instance. Large is recommended"
}

variable "user" {
    default = "ec2-user"
}

variable "private_key" {
    default = "~/.ssh/cockroach-morgan.pem"
    description = "Location of Private Key to SSH into instance"
}
variable "key_name" {
    default = "cockroach-morgan"
    description = "Key Name in AWS that relates to the private_key above"
}

variable "zones" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}