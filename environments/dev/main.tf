locals {
  common_tags = {
    Project     = "ServerlessSupportSystem"
    Environment = "dev"
    Owner       = "Chetan"
    ManagedBy   = "terraform"
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "dynamodb" {
  source     = "../../modules/dynamodb"
  table_name = "support-tickets-dev"
  tags       = local.common_tags
}

module "iam" {
  source       = "../../modules/iam"
  role_name    = "support-lambda-role-dev"
  dynamodb_arn = module.dynamodb.table_arn
  tags       = local.common_tags
}

module "lambda" {
  source        = "../../modules/lambda"
  function_name = "support-create-ticket-dev"
  role_arn      = module.iam.role_arn
  tags       = local.common_tags

  environment_variables = {
    TABLE_NAME = module.dynamodb.table_name
  }
}

module "apigateway" {
  source               = "../../modules/apigateway"
  api_name             = "support-api-dev"
  lambda_invoke_arn    = module.lambda.invoke_arn
  lambda_function_name = module.lambda.function_name
  tags       = local.common_tags
}

output "api_url" {
  value = module.apigateway.api_url
}
