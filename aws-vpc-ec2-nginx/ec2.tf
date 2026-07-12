resource "aws_instance" "nginx-server" {

  ami = "ami-0aba19e56f3eaec05"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet.id

  user_data = file("nginx.sh")

  vpc_security_group_ids = [ aws_security_group.nginx-sg.id ]
  associate_public_ip_address = true

  tags = {
    Name = "nginx-server"
  }
  
}