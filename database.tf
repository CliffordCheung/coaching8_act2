resource "aws_db_instance" "example" {
  db_name = "clifford_db"
  allocated_storage = 10
  engine = "mysql"
  instance_class = "db.t3.micro"
  username = "clifford"
  password = "testingtesting"
  skip_final_snapshot = true // required to destroy
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name = "clifford-db-subnet-group"
  subnet_ids = [data.aws_subnet.existing_ce9_pub_subnet1.id, data.aws_subnet.existing_ce9_pub_subnet2.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}