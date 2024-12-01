terraform {
  required_providers {
    aws     = "~> 5.77"
  }
}

provider "aws" {
  # Utilizando Aws Cli profile
  # profile = ""

  # Utilizando Chaves de acesso
  # access_key = ""
  # secret_key = ""

  region  = "us-east-1"

  default_tags {
    tags = {
      Project   = "Desafio Cloud Wise"
      Managed   = "Grupo 5"
      Owner     = "Grupo 5"
      terraform = "bootstrap"
    }
  }
}