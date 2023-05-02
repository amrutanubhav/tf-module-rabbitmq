locals {

  SSH_PASS         = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_PASSWORD"]
  SSH_USER         = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_USER"]
}