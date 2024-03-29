data "github_repository" "guessingAverage_repository" {
  name = var.github_credentials["github_repository"]
}

resource "github_repository_webhook" "api_gateway_github_webhook" {
  repository = data.github_repository.guessingAverage_repository.name

  configuration {
    url          = "${aws_apigatewayv2_api.github_webhook_api_gateway.api_endpoint}/${var.github_webhook_route}"
    content_type = "json"
    insecure_ssl = "0"
    secret       = random_password.webhook_secret.result
  }

  events = ["workflow_run"]
}