* # AWS Batch CSV Processor

  Demonstration of AWS Batch infrastructure for processing CSV files from S3 to bypass the 15 minute AWS Lambda maximum.

  AWS Batch is a container-based solution that alleviates some of these concerns. EC2 spot can be used to lower the cost of the solution.

  ## Infrastructure

  * `AWS Batch Compute Cluster` will use a spot fleet at a significant cost reduction than that of the on-demand computing price
  * `AWS Batch Job` will run the python script to process the CSV in a streaming fashion 
  * `AWS CodeBuild` will build the Docker image and push it to the ECR repository
  * `AWS CodeCommit repository` for the code repository to build the images
  * `AWS EC2 Container Registry` to store the Docker image that is called by the AWS Batch job.

  Terraform is used to describe the infrastructure.

  ## Setup

  * Create a file for the terraform variables (deploy/terraform.tfvars)

  ```bash
  region = "us-east-1"
  vpc_id = "vpc-57b7xxxx"
  security_group_ids = [
    "sg-5e55xxxx"
  ]
  bucket_name          = "my-s3-bucket-name-goes-here"
  object_path_and_name = "path/in/bucket/to/object.csv"
  ```

  * Use Terraform to setup the infrastructure

  ```bash
  cd deploy
  terrform init
  terraform validate
  terraform plan -out=tfplan
  terraform apply tfplan
  ```

  * Push the code to your newly created CodeCommit repository

  ```bash
  git remote add codecommit <SSH_URL>
  git push codecommit master
  ```

  * Submit a build

  ```bash
  aws codebuild start-build --project-name aws_batch_csv_processor
  ```

  * Once the build completes, a Batch job can be submitted

  ```bash
  aws batch submit-job --job-name "first_run" --job-queue "batch_job_queue" --job-definition batch_csv_processor:1
  ```

  * Once the job is complete, it may take up to 15 minutes for the logs will show up in CloudWatch logs depending upon activity in your region.

  ## Customization

  The CSV processor in the repository is quite simple (it just counts the columns and rows). But you
  can customize the script to do whatever you need to with the CSV.

  The code is located in `aws_batch_csv_processor/__main__.py`. Most of the code is dedicated to reading
  the CSV file from S3 by streaming the contents.

  The parameters to the batch job are the S3 bucket and key for the file:

  * _bucket_ is the S3 bucket parameter
  * _path_ is the path to the S3 object to read

  
