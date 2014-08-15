variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "key_name" {}
variable "aws_region" {}
variable "cidr" {
    default = "192.168.11.0/24"
}
variable "amis" {
    default = {
        "ap-northeast-1": "ami-29dc9228",
        "ap-southeast-1": "ami-a6b6eaf4",
    }
}
variable "availability_zones" {
    default = {
        "ap-northeast-1": "c",
        "ap-southeast-1": "b",
    }
}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

output "region" {
    value = "${var.aws_region}"
}

resource "aws_vpc" "my-vpc" {
    cidr_block = "${var.cidr}"
}

output "vpc_id" {
    value = "${aws_vpc.my-vpc.id}"
}

resource "aws_subnet" "main" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    cidr_block = "${var.cidr}"
    availability_zone = "${var.aws_region}${lookup(var.availability_zones, var.aws_region)}"
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.my-vpc.id}"
}

resource "aws_route_table" "igw" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    route {
        gateway_id = "${aws_internet_gateway.gw.id}"
        cidr_block = "0.0.0.0/0"
    }
}

resource "aws_route_table_association" "main_and_igw" {
    subnet_id = "${aws_subnet.main.id}"
    route_table_id = "${aws_route_table.igw.id}"
}

resource "aws_security_group" "allow_all" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    name = "allow_all"
    description = "Allow all inbound traffic"
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "community-jp" {
    ami = "${lookup(var.amis, var.aws_region)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.main.id}"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.allow_all.id}"]
    count = 1
}

resource "aws_eip" "community-jp" {
    instance = "${aws_instance.community-jp.id}"
    vpc = true
}

output "public_ip.community-jp" {
    value = "${aws_instance.community-jp.public_ip}"
}
