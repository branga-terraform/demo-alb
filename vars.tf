variable AWS_REGION {
  default = "us-west-2"
}

variable access_key {
  default = ""
}

variable secret_key {
  default = ""
}

variable "Security_Group" {
  default = "sg-94a72be8"
}

variable "SSH_KeyName" {
  default = "DockerSSHKey"
}

variable "http_tcp_listeners" {
  description = "A list of maps describing the HTTPS listeners for this ALB. Required key/values: port, protocol. Optional key/values: target_group_index (defaults to 0)"
  type        = "list"

  default = []
}
