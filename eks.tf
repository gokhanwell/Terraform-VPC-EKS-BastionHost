resource "aws_eks_cluster" "Terraform-EKS-Cluster" {
  name     = "Terraform-EKS-Cluster"
  role_arn = aws_iam_role.Terraform-EKS-Cluster.arn

  vpc_config {
    subnet_ids = [aws_subnet.Terraform-Private-Subnet-1.id, aws_subnet.Terraform-Private-Subnet-2.id, aws_subnet.Terraform-Private-Subnet-3.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.Terraform-EKS-Cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.Terraform-EKS-Cluster-AmazonEKSVPCResourceController,
  ]
}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "Terraform-EKS-Cluster" {
  name               = "eks-cluster-Terraform-EKS-Cluster"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "Terraform-EKS-Cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.Terraform-EKS-Cluster.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "Terraform-EKS-Cluster-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.Terraform-EKS-Cluster.name
}




resource "aws_eks_node_group" "Terraform-EKS-Node-Group" {
  cluster_name    = aws_eks_cluster.Terraform-EKS-Cluster.name
  node_group_name = "Terraform-EKS-Node-Group"
  node_role_arn   = aws_iam_role.Terraform-EKS-Node-Group.arn
  subnet_ids      = [aws_subnet.Terraform-Private-Subnet-1.id, aws_subnet.Terraform-Private-Subnet-2.id, aws_subnet.Terraform-Private-Subnet-3.id]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  instance_types = ["t3.micro"]

  update_config {
    max_unavailable = 1
  }

  #   Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  #   Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.Terraform-EKS-Node-Group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.Terraform-EKS-Node-Group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.Terraform-EKS-Node-Group-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "Terraform-EKS-Node-Group" {
  name = "EKS-Terraform-EKS-Node-Group"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "Terraform-EKS-Node-Group-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.Terraform-EKS-Node-Group.name
}

resource "aws_iam_role_policy_attachment" "Terraform-EKS-Node-Group-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.Terraform-EKS-Node-Group.name
}

resource "aws_iam_role_policy_attachment" "Terraform-EKS-Node-Group-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.Terraform-EKS-Node-Group.name
}
