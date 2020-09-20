# Exportamos instance profile para el modulo de creación de la instancia/s EC2

output "ins_profile" {
  description = "INSTANCE PROFILE"
  value = aws_iam_instance_profile.instance_profile[0].name
}

