variable "vpc_config" {

  type = object({
    cidr_block = string
    name = string
  })
  
}

variable "subnet_config" {
  type = map(object({
    
    cidr_block = string
    az = string
    public = optional(bool , false)

  
  }))

    validation{
      condition = alltrue([
        for config in var.subnet_config : can(cidrnetmask(config.cidr_block))
      ])
      error_message = "Invalid subnet CIDR block."
    }

  
}
