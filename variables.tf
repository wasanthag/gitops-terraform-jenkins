variable "instance_count" {
  default = 1
}

variable "key_name" {
  description = "Private key name to use with instance"
  default     = "wasantha-us-east1"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t3.small"
}

variable "ami" {
  description = "Base AMI to launch the instances"

  # Bitnami NGINX AMI
  default = "ami-021acbdb89706aa89"
}

variable "org" {
  description = "TFE org name"
  default = "TFE-DEMO-ORG"
  }

variable "workspace" {
  description = "workspace name where TF is run"
  default = "jenkins-dev"
  }
