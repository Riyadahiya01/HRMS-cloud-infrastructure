resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

 lifecycle {
    prevent_destroy = true
  }
  
  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-igw"
    }
  )
}