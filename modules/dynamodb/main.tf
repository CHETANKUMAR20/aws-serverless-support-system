resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ticket_id"

  attribute {
    name = "ticket_id"
    type = "S"
  }

  # Enable Point-in-Time Recovery (Protection against accidental delete/update)
  point_in_time_recovery {
    enabled = true
  }

  # Use standardized tags from environment
  tags = var.tags
}
