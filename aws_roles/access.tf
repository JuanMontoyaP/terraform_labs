resource "aws_iam_openid_connect_provider" "gh-actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["7560D6F40FA55195F740EE2B1B7C0B4836CBE103"]
}
