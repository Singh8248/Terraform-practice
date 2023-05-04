resource "aws_vpc" "uat" {
  cidr_block = "10.20.0.0/16"
  tags = {
   Name = "UAT"
 }
}
resource "aws_subnet" "uat" {
  vpc_id     = aws_vpc.uat.id
  cidr_block = "10.20.0.0/24"

  tags = {
    Name = "UAT-pub-sub"
  }
}
resource "aws_internet_gateway" "ngw" {
    vpc_id = aws_vpc.uat.id

  tags = {
    Name = "ngwuat"
  }
}
resource "aws_route_table" "uat" {
  vpc_id = aws_vpc.uat.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ngw.id
  }
  tags = {
    Name = "uat-pub-rt"
  }
}
resource "aws_route_table_association" "pub-rt-association" {
  gateway_id     = aws_internet_gateway.ngw.id
  route_table_id = aws_route_table.uat.id
}