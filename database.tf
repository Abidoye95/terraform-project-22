#security group for launch_template
#allow http and ssh

resource "aws_db_subnet_group" "subnet_group" {
  name       = "subnet_group"
  subnet_ids = [aws_subnet.private_subnet2.id, aws_subnet.private_subnet1.id]

  tags = {
    Name = "My Database subnet group"
  }
}


resource "aws_db_instance" "instance_db" {
  allocated_storage      = 10
  db_name                = "instance_db"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = "" #insert your desired password
  password               = "" #insert your desired username
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  availability_zone      = data.aws_availability_zones.available_az.names[0]
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.id
  port                   = "3306"

}

#security group for launch_template
#allowing http and ssh
resource "aws_security_group" "web_server_sg" {
  name        = "web_server_sg"
  description = "Allow traffic"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "database_sg" {
  name        = "mydatabase_sg"
  description = "Allow traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    security_groups = [aws_security_group.web_server_sg.id]



  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

  