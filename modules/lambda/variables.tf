variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN for Lambda"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables map"
  type        = map(string)
}

variable "tags" {
  type = map(string)
}
