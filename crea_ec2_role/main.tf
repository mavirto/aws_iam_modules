# Generamos documento JSON en base a las variables pol_actions y pol_resources string(list)

data "aws_iam_policy_document" "crea_doc_policy" {
  count = var.crea_policy ? 1 : 0

  statement {
    effect    = "Allow"

    resources = [for res in var.pol_resources : "${res}"]

    actions = [for act in var.pol_actions : "${act}"]
  }
}


# Generamos policy en base al JSON del datasource aws_iam_policy_document

resource "aws_iam_policy" "pol_mipol" {
  count = var.crea_policy ? 1 : 0

  name = var.pol_nombre

  policy = data.aws_iam_policy_document.crea_doc_policy[0].json
}


# Generamos role para instancia EC2

resource "aws_iam_role" "role" {
  count = var.crea_policy ? 1 : 0

  name               = var.role_name
 
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
            "Sid": "1"
        }
    ]
  }
EOF
}

# Attachamos policy al EC2 Role

resource "aws_iam_role_policy_attachment" "pol_attach" {
  count 	= var.crea_policy ? 1 : 0

  role       	= aws_iam_role.role[0].name
  policy_arn 	= aws_iam_policy.pol_mipol[0].arn
}


# Generamos instance profile para la instancia EC2 (esto lo exportará el módulo para pasarlo al recurso aws_instance que creará las instancias EC2)

resource "aws_iam_instance_profile" "instance_profile" {
  count = var.crea_policy ? 1 : 0

  name  = var.role_name
  role  = aws_iam_role.role[0].name
}
