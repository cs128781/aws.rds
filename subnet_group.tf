resource "aws_db_subnet_group" "rds_subgroup" {
  name       = var.key_name
  subnet_ids = [lookup({1=local.lsubA,
                       0=var.Rsubnet1},var.is_local,""),
                lookup({1=local.lsubB,
                       0=var.Rsubnet2},var.is_local,"") ]
  tags= {Name=var.key_name}
}

