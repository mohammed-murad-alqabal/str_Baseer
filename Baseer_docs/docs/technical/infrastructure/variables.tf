# =================================================================
# Terraform Variables - Baseer Project
# =================================================================

# =================================================================
# General Configuration
# =================================================================

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "baseer"
}

variable "environment" {
  description = "Environment name (staging, production)"
  type        = string
  default     = "staging"
  
  validation {
    condition     = contains(["staging", "production"], var.environment)
    error_message = "Environment must be either 'staging' or 'production'."
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "me-south-1"
}

# =================================================================
# Networking Configuration
# =================================================================

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

# =================================================================
# EKS Configuration
# =================================================================

variable "kubernetes_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  default     = "1.28"
}

variable "node_instance_types" {
  description = "Instance types for EKS worker nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_group_min_size" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
  default     = 10
}

variable "node_group_desired_size" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
  default     = 3
}

# =================================================================
# RDS Configuration
# =================================================================

variable "postgresql_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "15.4"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "Initial allocated storage for RDS (GB)"
  type        = number
  default     = 20
}

variable "rds_max_allocated_storage" {
  description = "Maximum allocated storage for RDS (GB)"
  type        = number
  default     = 100
}

variable "rds_backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "database_name" {
  description = "Name of the database"
  type        = string
  default     = "baseer"
}

variable "database_username" {
  description = "Database master username"
  type        = string
  default     = "baseer_admin"
}

variable "database_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
  default     = "ChangeMeInProduction123!"
  
  validation {
    condition     = length(var.database_password) >= 8
    error_message = "Database password must be at least 8 characters long."
  }
}

# =================================================================
# Redis Configuration
# =================================================================

variable "redis_node_type" {
  description = "Redis node type"
  type        = string
  default     = "cache.t3.micro"
}

variable "redis_num_cache_nodes" {
  description = "Number of cache nodes in the Redis cluster"
  type        = number
  default     = 1
}

# =================================================================
# Application Configuration
# =================================================================

variable "jwt_access_secret" {
  description = "JWT access token secret"
  type        = string
  sensitive   = true
  default     = "your-super-secret-jwt-access-key-change-in-production"
}

variable "jwt_refresh_secret" {
  description = "JWT refresh token secret"
  type        = string
  sensitive   = true
  default     = "your-super-secret-jwt-refresh-key-change-in-production"
}

# =================================================================
# Monitoring Configuration
# =================================================================

variable "enable_monitoring" {
  description = "Enable monitoring stack (Prometheus, Grafana)"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable centralized logging (ELK stack)"
  type        = bool
  default     = true
}

# =================================================================
# Backup Configuration
# =================================================================

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 30
}

# =================================================================
# Security Configuration
# =================================================================

variable "enable_waf" {
  description = "Enable AWS WAF for additional security"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the cluster"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# =================================================================
# Cost Optimization
# =================================================================

variable "enable_spot_instances" {
  description = "Enable spot instances for cost optimization"
  type        = bool
  default     = false
}

variable "auto_scaling_enabled" {
  description = "Enable auto scaling for EKS nodes"
  type        = bool
  default     = true
}

# =================================================================
# Feature Flags
# =================================================================

variable "enable_elasticsearch" {
  description = "Enable Elasticsearch for search and analytics"
  type        = bool
  default     = false
}

variable "enable_cdn" {
  description = "Enable CloudFront CDN"
  type        = bool
  default     = true
}

variable "enable_ssl_certificate" {
  description = "Enable SSL certificate management"
  type        = bool
  default     = false
}

# =================================================================
# Environment Specific Overrides
# =================================================================

variable "environment_config" {
  description = "Environment specific configuration overrides"
  type = object({
    node_instance_types = optional(list(string))
    rds_instance_class  = optional(string)
    redis_node_type     = optional(string)
    backup_retention    = optional(number)
  })
  default = {}
}

# =================================================================
# Tags
# =================================================================

variable "additional_tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}