variable "region" {
    default = "us-east-1"
}
variable "environment" {
    default = "Development"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "keyname" {
    default = "jenkins-server-key"
}