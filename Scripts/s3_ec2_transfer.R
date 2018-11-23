#transfer data from S3 to EBS

library(aws.s3)
library(aws.ec2metadata)

#set credentials ----

#list IAM roles in instance
metadata$iam_role_names()

#get specified rolename (if only 1 leave at 1)
cred.role <- metadata$iam_role_names()[1]

#this works if running R from within an EC2 instance
Sys.setenv("AWS_ACCESS_KEY_ID" = metadata$iam_role(role = cred.role)$AccessKeyId,
           "AWS_SECRET_ACCESS_KEY" = metadata$iam_role(role = cred.role)$SecretAccessKey,
           "AWS_DEFAULT_REGION" = "eu-west-2",
           "AWS_SESSION_TOKEN" = metadata$iam_role(role = cred.role)$Token)

#download ----

#list contents of a bucket
aws.s3::get_bucket(bucket = "ne-stats-data")$Contents
#dataframe of contents of a bucket
aws.s3::get_bucket_df(bucket = "ne-stats-data")

#save a file from S3 to project
save_object("enPeatDepthModel/scratch.Rmd", file = "scripts/scratch_cp.Rmd", bucket = "ne-stats-data")

#load into R ----

#load an object
get_object()

#upload ----
aws.s3::s3save()