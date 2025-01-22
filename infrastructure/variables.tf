variable "project_id" {
  description = "Project ID"
  type        = string
  default     = "my-project"
}

variable "region" {
  description = "Region of project"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zone of project"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "k8s Cluster Name"
  type        = string
  default     = "my-cluster"
}

variable "node_pool_name" {
  description = "k8s Node Pool Name"
  type        = string
  default     = "my-node-pool"
}