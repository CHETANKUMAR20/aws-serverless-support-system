variable "table_name" {
  description = "Name of DynamoDB table"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
}
