# terraform-jenkins-setup

Terraform scripts to setup a jenkins server in an AWS's ec2 instance. 

Prereqs:

Create S3 bucket to store the terraform state .

Create bucket named "jenkins-terraform-setup-state".
Enable versioning.


Create Dynamo DB table to use for locking.

Create table called "jenkins-state-locks" with partition key "LockID" (case sensitive).
