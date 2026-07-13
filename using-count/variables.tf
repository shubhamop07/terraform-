variable "ec2-config" {
  type = list(object({
    ami = string
    instance_type = string
  }))
}

variable "ec2_map" {

  type = map(object({
    ami = string
    instance_type = string
  }))
  
}