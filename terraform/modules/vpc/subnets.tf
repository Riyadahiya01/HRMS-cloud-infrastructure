resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-${each.key}"
      Tier = "Public"
    }
  )
}






resource "aws_subnet" "private_app" {
  for_each = var.private_app_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-${each.key}"
      Tier = "Private-App"
    }
  )
}





resource "aws_subnet" "private_db" {
  for_each = var.private_db_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  lifecycle {
    prevent_destroy = true
  }
  
  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-${each.key}"
      Tier = "Private-DB"
    }
  )
}