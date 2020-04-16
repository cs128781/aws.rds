
resource "aws_rds_cluster" "myprivcluster" {
  cluster_identifier      = "tformclusterone"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.0"
  db_subnet_group_name    = aws_db_subnet_group.rds_subgroup.id
  database_name           = var.rds_db_name
  master_username         = var.rds_username
  master_password         = var.rds_pwd
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot = true
  final_snapshot_identifier="fsnapid1"
  tags= {Name=var.key_name}
}

resource "aws_rds_cluster_instance" "cluster_instance_1" {
  count              = 1
  identifier         = "aurora-cluster-demo-1"
  cluster_identifier = aws_rds_cluster.myprivcluster.id
  instance_class     = "db.t2.medium"
  engine             = "aurora-mysql"
  db_subnet_group_name    = aws_db_subnet_group.rds_subgroup.id
  tags= {Name=var.key_name}
}
data "aws_db_instance" "database" {
  db_instance_identifier = aws_rds_cluster_instance.cluster_instance_1[0].id
  depends_on=[aws_rds_cluster_instance.cluster_instance_1]
}

output "dbsecgroup" {

    value = [data.aws_db_instance.database]
}

resource "aws_security_group_rule" "addrule1" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_db_instance.database.vpc_security_groups[0]
}