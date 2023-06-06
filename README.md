- variable.tf dosyasında bastion hosta SSH ile erişim için key_name değeri girilmelidir.

- bastion.sh dosyasında aws cli configure için gerekli aws_access_key ve aws_secret_access_key bilgileri girilmelidir.

        terraform init
        terraform plan
        terraform apply

![alt text](https://github.com/gokhanwell/Terraform-VPC-EKS-BastionHost/blob/main/Terraform-VPC-EKS-Bastion.png)
