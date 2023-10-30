terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.2.1"
    }
    kubernetes = {
      source  = "registry.terraform.io/hashicorp/kubernetes"
      version = "~> 1.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
  required_version = ">= 1.0.0"
}

provider "kind" {}
provider "kubernetes" {
    
    //config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
      config_path = "~/.kube/config"
  }
}
