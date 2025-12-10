provider "aws"{
    region = "eu-west-2"
}
 
variable "bucket_name" {
    default = "shivakumar-tfstate-bucket"
    description = "Name of S3 bucket storing the tfstate file"
}
 
variable "dynamodb_table"{
    default = "shivakumar_tf_locks"
    description = "Name of Dynamo DB table, storing the tfstate locks"
}
 
#1st Create S3 bucket
resource "aws_s3_bucket" "tf_state" {
    bucket = var.bucket_name
}
 
#2nd Enable bucket versioning
resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.tf_state.id          #id of the created bucket
    versioning_configuration {
        status = "Enabled"
    }
}
 
#3rd Block public access for S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
    bucket = aws_s3_bucket.tf_state.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}
 
 
#Dynamo DB table for state locks
resource "aws_dynamodb_table" "tf_lock" {
    name = var.dynamodb_table
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockId"
    attribute {
        name = "LockId"
        type = "S"
    }
}
 
output "s3_bucket_name" {  
    value = aws_s3_bucket.tf_state.bucket
}
 
output "dynamodb_table_name" {
    value = aws_dynamodb_table.tf_lock.name
}