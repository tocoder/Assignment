provider "aws" {
    region = var.aws_region
}

resource "aws_vpc" "tocoder_vpc" {
    cidr_block = var.vpc_cidr
}

resource "aws_subnet" "tocoder_public_subnet" {
    count = 2

    vpc_id = aws_vpc.tocoder_vpc.id
    cidr_block = element(var.public_subnet_cidr, count.index)
    availability_zone = element(var.availability_zones, count.index)
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.prefix}-public-${count.index + 1}"
    }
}

resource "aws_subnet" "tocoder_private_subnet" {
    count = 2

    vpc_id = aws_vpc.tocoder_vpc.id
    cidr_block = element(var.private_subnet_cidr, count.index)
    availability_zone = element(var.availability_zones, count.index)
    

    tags = {
        Name = "${var.prefix}-private-${count.index + 1}"
    }
}

resource "aws_internet_gateway" "tocoder_igw"{
    vpc_id = aws_vpc.tocoder_vpc.id

    tags = {
        Name = "${var.prefix}-igw"
    }
}

resource "aws_route_table" "tocoder_public_rt" {
    vpc_id = aws_vpc.tocoder_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.tocoder_igw.id
    }

    tags = {
        Name = "${var.prefix}-public-rt"
    }

}

resource "aws_route_table" "tocoder_private_rt" {
    vpc_id = aws_vpc.tocoder_vpc.id

    tags = {
        Name = "${var.prefix}-private-rt"
    }

}

resource "aws_route_table_association" "tocoder_public_rta" {
    count = 2

    subnet_id = aws_subnet.tocoder_public_subnet[count.index].id
    route_table_id = aws_route_table.tocoder_public_rt.id

}

resource "aws_route_table_association" "tocoder_private_rta" {
    count = 2

    subnet_id = aws_subnet.tocoder_private_subnet[count.index].id
    route_table_id = aws_route_table.tocoder_private_rt.id

}

resource "aws_security_group" "tocoder_https" {
    vpc_id = aws_vpc.tocoder_vpc.id

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.prefix}-https-sg"
    }


}