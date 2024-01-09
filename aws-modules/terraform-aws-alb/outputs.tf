// Outputs

/*
// AWS Security Group Outputs

output "aws_security_group_id" {
  value = aws_security_group.gh.id
}

output "aws_security_group_arn" {
  value = aws_security_group.gh.arn
}

output "aws_security_group_vpc_id" {
  value = aws_security_group.gh.vpc_id
}

output "aws_security_group_owner_id" {
  value = aws_security_group.gh.owner_id
}

output "aws_security_group_name" {
  value = aws_security_group.gh.name
}

output "aws_security_group_description" {
  value = aws_security_group.gh.description
}

output "aws_security_group_ingress" {
  value = aws_security_group.gh.ingress
}

output "aws_security_group_egress" {
  value = aws_security_group.gh.egress
}

*/

// AWS Application Load-Balancer Outputs

output "aws_lb_id" {
  value = aws_lb.gh.id
}

output "aws_lb_arn" {
  value = aws_lb.gh.arn
}

output "aws_lb_arn_suffix" {
  value = aws_lb.gh.arn_suffix
}

output "aws_lb_dns_name" {
  value = aws_lb.gh.dns_name
}

output "aws_lb_zone_id" {
  value = aws_lb.gh.zone_id
}


// AWS Application Load Balancer Target Group Outputs

output "aws_lb_target_group_id" {
  value = aws_lb_target_group.gh.id
}

output "aws_lb_target_group_arn" {
  value = aws_lb_target_group.gh.arn
}

output "aws_lb_target_group_arn_suffix" {
  value = aws_lb_target_group.gh.arn_suffix
}

output "aws_lb_target_group_name" {
  value = aws_lb_target_group.gh.name
}

// AWS Application Load Balancer Listener Outputs

output "aws_lb_listener_id" {
  value = aws_lb_listener.gh.id
}

output "aws_lb_listener_arn" {
  value = aws_lb_listener.gh.arn
}
