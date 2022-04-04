-To successfully deploy the S3 bucket, comment out block of code on line 2 - 10 and then deploy infrastructure.  
-Once infrastrucure has been applied, uncomment the block of code and deploy again, you will then have s3 bucket deployed with dynamoDB with locking. 

-Important -  terraform AWS Provider is upgraded to version 4.0.0 which is published on 10 February 2022.
-----Major changes in the release include:
-----Version 4.0.0 of the AWS Provider introduces significant changes to the aws_s3_bucket resource.
-----Version 4.0.0 of the AWS Provider will be the last major version to support EC2-Classic resources as AWS plans to fully retire EC2-Classic Networking. See the AWS News Blog for additional details.
-----Version 4.0.0 and 4.x.x versions of the AWS Provider will be the last versions compatible with Terraform 0.12-0.15.

Because of the above changes we will need to run on version 3.74. I have included code in the main file which will freeze provider. 
