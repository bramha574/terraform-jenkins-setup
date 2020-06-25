data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnet_ids" "default_public" {
  vpc_id = data.aws_vpc.default_vpc.id
}

data "aws_subnet" "public" {
  count = length(data.aws_subnet_ids.default_public.ids)
  id    = tolist(data.aws_subnet_ids.default_public.ids)[count.index]
}
