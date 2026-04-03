data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = var.source_path
  output_path = "${path.module}/${var.name}.zip"
}

resource "aws_lambda_function" "this" {
  function_name = var.name
  runtime       = var.runtime
  handler       = var.handler

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  role = var.role_arn
}

output "function_name" {
  value = aws_lambda_function.this.function_name
}
