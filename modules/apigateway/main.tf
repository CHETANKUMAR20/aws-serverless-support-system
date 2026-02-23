resource "aws_apigatewayv2_api" "this" {
  name          = var.api_name
  protocol_type = "HTTP"
  tags = var.tags

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "PATCH"]
    allow_headers = ["content-type"]
  }
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_invoke_arn
  payload_format_version = "2.0"
}

# POST /tickets
resource "aws_apigatewayv2_route" "create_ticket" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "POST /tickets"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

# GET /tickets/{id}
resource "aws_apigatewayv2_route" "get_ticket" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "GET /tickets/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
}

# Permission for API Gateway to call Lambda
resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this.execution_arn}/*/*"
}


