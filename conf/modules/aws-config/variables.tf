

variable "bucket_key_prefix" {
  default = "config"
}


variable "sns_topic_arn" {
  default = "" 
}

variable "bucket_name" {
  default = "awsss-config"
}


variable "delivery_frequency" {
  default = ""
}


variable "config_rules" {
  type        = map(any)
  description = "A list of config rules. By not specifying, a minimum set of recommended rules are applied"
  default     = {
    s3_bucket_logging_enabled = {
      name = "s3-bucket-logging-enabled"
      source = {
        owner             = "AWS"
        source_identifier = "S3_BUCKET_LOGGING_ENABLED"
      }
      scope = {
        compliance_resource_types = ["AWS::S3::Bucket"]
      }
    }
    ec2_instances_in_vpc = {
      name = "ec2-instances-in-vpc"
      source = {
        owner             = "AWS"
        source_identifier = "INSTANCES_IN_VPC"
      }
      scope = {
        compliance_resource_types = ["AWS::EC2::Instance"]
      }
    }
  } 
}






