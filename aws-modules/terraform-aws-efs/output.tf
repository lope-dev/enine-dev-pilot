output "access_point_id" {
  description = "The ID of the 'conf'EFS access point"
  value = aws_efs_access_point.access_point.id
}

output "filesystem_id" {
  description = "The ID of the EFS writeable file system"
  value = aws_efs_file_system.fs.id
}



//output "apigw_public_domain_name_id" {
//  description = "API Gateway Domain Name ID"
//  value       = aws_api_gateway_domain_name.api_domain.id
//}
//
//output "apigw_public_domain_name" {
//  description = "API Gateway Domain Name"
//  value       = aws_api_gateway_domain_name.api_domain.domain_name
//}
//



