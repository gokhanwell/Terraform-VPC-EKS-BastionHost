output "puclic_dns" {
  value = aws_instance.Terraform-Bastion-Host.public_ip
}

output "endpoint" {
  value = aws_eks_cluster.Terraform-EKS-Cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.Terraform-EKS-Cluster.certificate_authority[0].data
}
