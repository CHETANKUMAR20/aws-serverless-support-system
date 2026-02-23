resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "handler.handler"
  runtime       = "nodejs18.x"

  filename         = "${path.module}/../../lambda-app/function.zip"
  source_code_hash = filebase64sha256("${path.module}/../../lambda-app/function.zip")
  
  timeout = 10

  environment {
    variables = var.environment_variables
  }
  
  tracing_config {
    mode = "Active"
  }
  
  tags = var.tags   # ✅ Only here
}

# 👇 ADD THIS RIGHT BELOW THE LAMBDA RESOURCE

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = 14
}

