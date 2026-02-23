resource "aws_iam_role" "lambda_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
  
  tags = var.tags   # ✅ Only here
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "dynamodb_access" {
  name = "${var.role_name}-dynamodb-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = [
        "dynamodb:PutItem",
        "dynamodb:GetItem"
      ]
      Resource = var.dynamodb_arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_dynamodb" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

