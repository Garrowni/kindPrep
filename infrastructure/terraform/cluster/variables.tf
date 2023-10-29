variable "ingress_nginx_helm_version" {
  type        = string
  description = "The helm version for nginx ingress controller."
  default     = "4.8.3"
}

variable "ingress_nginx_namespace" {
  type        = string
  description = "The nginx ingress namespace (will be created)"
  default     = "ingress-nginx"
}

variable "kind_cluster_config_path" {
  type        = string
  description = "The location where this cluster's kubeconfig will be saved to."
  default     = "~/.kube/config"
}
variable "kind_cluster_name" {
  type        = string
  description = "The name of the cluster"
  default     = "local-demo"
}
