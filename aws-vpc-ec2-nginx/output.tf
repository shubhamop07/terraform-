output "ip" {

  value = aws_instance.nginx-server.public_ip
  
}

output "public_url" {

  value = "http://${aws_instance.nginx-server.public_ip}"
  
}