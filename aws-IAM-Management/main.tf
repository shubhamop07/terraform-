terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.54.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

locals {
  user_data = yamldecode(file("./users.yaml")).users

  user_role_pair = flatten([for user in local.user_data : [for role in user.role : {
    username = user.username
    role = role
  }]])
}

output "output" {
  value = local.user_role_pair
}

#creating users


resource "aws_iam_user" "users" {

  for_each = toset(local.user_data[*].username)
  name = each.value
  
}

resource "aws_iam_user_login_profile" "profile" {

  for_each = aws_iam_user.users
  user = each.value.name
  password_length = 16

  lifecycle {
    ignore_changes = [password_length , password_reset_required,pgp_key]
  }
}


  #attach policies

  resource "aws_iam_user_policy_attachment" "attach"{

    for_each = {
      for pair in local.user_role_pair :
      "${pair.username}-${pair.role}" => pair
        
      
    }

    user = aws_iam_user.users[each.value.username].name
    policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"

  }

  


  
