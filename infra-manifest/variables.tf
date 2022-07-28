variable "profile" {
  type = string
}
variable "aws_region" {
  type = string
}
variable "env" {
  type = string
}
variable "ami" {
  type = string
}
variable "vpc_cidr_block" {
  type = string
}
variable "public_subnet_cidr" {
  type = list(any)
}
variable "private_subnet_cidr" {
  type = list(any)
}
variable "subnet_availability_zones" {
  type = list(any)
}
variable "instance_type_list" {
  type = list(any)
}
variable "keypair" {
  type = string
}
variable "server_list" {
  type = list(any)
}
variable "instance_subnet_list" {
  type = list(any)
}
variable "user_data_map" {
  type = map(any)
}
variable "sg_list" {
  type = list(any)
}
variable "zone_id" {
  type = string
}
variable "domain_name" {
  type = string
}