# Test private subnet
resource "aws_instance" "docker" {
  ami                  = "ami-0b5eea76982371e91"
  instance_type        = "t3.micro"
  iam_instance_profile = data.aws_iam_instance_profile.LabProfile.name
  tags = {
    Name = "${var.env}-docker-gitlab-runner"
  }
  user_data = base64encode(templatefile("./files/gitlabrunner_userdata.tftpl", {
      GITLAB_RUNNER_REGISTER_TOKEN = var.gitlab_runner_register_token
  }))
}