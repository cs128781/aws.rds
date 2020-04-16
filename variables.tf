variable "region" {
  default = "us-east-1"
}
variable "key_name" {
  default = "localdbtest"
}
variable "vpc_cidr" {
  default = "192.0.0.0/16"

}

variable "subnet1" {
    default = "192.0.1.0/24"
}
variable "subnet2" {
    default = "192.0.2.0/24"
}
variable "subnet3" {
    default = "192.0.3.0/24"
}
variable "rds_db_name" {
    default = "customer_onboard"
}
variable "rds_username" {
    default = "dbc"
}
variable "rds_pwd" {
    default = "icobdbc99"
}

#######################
variable "is_local"{
    default = 1
}

#######################

variable "Rsubnet1" {
  default="null"
}
variable "Rsubnet2" {
  default="null"
}
variable "Rsubnet3" {
  default="null"
}
