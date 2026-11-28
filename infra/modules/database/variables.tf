variable "name" {
  description = "Name for the database and its secret."
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  description = "Address range allowed to connect on port 5432."
  type        = string
}

variable "private_subnet_ids" {
  description = "At least two private subnets in different zones."
  type        = list(string)
}

variable "engine_version" {
  description = "PostgreSQL major version; AWS picks the latest minor."
  type        = string
  default     = "17"
}

variable "instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "multi_az" {
  description = "Standby copy in a second zone. Prod: true."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Block deletes and take a final snapshot. Prod: true."
  type        = bool
  default     = false
}

variable "password_version" {
  description = "Bump to generate and store a new master password."
  type        = number
  default     = 1
}

variable "backup_retention_days" {
  description = "Days of automated backups. The AWS free plan allows at most 1."
  type        = number
  default     = 7
}
