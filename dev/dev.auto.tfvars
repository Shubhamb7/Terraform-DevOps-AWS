profile = "default"
env = "dev"
aws_region = "us-east-1"

#======================= Network Configuration =============================
vpc_cidr_block = "10.0.0.0/16"
# Create subnets in diffent AZs for HA
subnet_availability_zones = ["us-east-1a","us-east-1c"]
public_subnet_cidr = ["10.0.1.0/24","10.0.3.0/24"]
private_subnet_cidr = ["10.0.2.0/24","10.0.4.0/24"]

#====================== Instance Configuration =============================
# AMI ID for Ubuntu 20.04.4
ami = "ami-08d4ac5b634553e16"
server_list             = ["bastion","web", "app", "db"]
instance_type_list      = ["t2.micro","t2.small", "t2.small", "t2.micro"]
instance_subnet_list    = ["public","public", "private", "private"]
user_data_map = {
    "bastion" = "user-data-scripts/generic.sh",
    "web" = "user-data-scripts/install-web.sh",
    "db"  = "user-data-scripts/install-db.sh",
    "app" = "user-data-scripts/install-app.sh"
}
sg_list = ["bastionsg","websg","appsg","dbsg","albsg"]
keypair = "terraform-test"

#===================== Hosted zone and DNS ==============================
zone_id = "Z06873712X6UPH4I7I3G2"
domain_name = "terraform-devops-test.tk"