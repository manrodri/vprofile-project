#### Instance profiles

resource "aws_iam_instance_profile" "jenkins" {

  lifecycle {
    create_before_destroy = false
  }

  name = "${terraform.workspace}_jenkins_profile"
  role = aws_iam_role.jenkins.name
}

#### Instance roles

resource "aws_iam_role" "jenkins" {
  name = "${terraform.workspace}_jenkins_role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
  EOF
}



#### S3 policies

resource "aws_iam_role_policy" "s3" {
  name = "${terraform.workspace}-vprofile-cicd-server-policy"
  role = aws_iam_role.jenkins.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "*"
        ],
        "Effect": "Allow",
        "Resource": [
                "*"
            ]
      }
    ]
  }
  EOF
}
