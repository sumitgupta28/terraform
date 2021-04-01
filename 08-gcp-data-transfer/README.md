# Terraform on GCP (Google Cloud Platform)

### [What is Transfer Service?](https://cloud.google.com/storage-transfer/docs/overview)

Storage Transfer Service is a product that enables you to:

- Move or backup data to a Cloud Storage bucket either from other cloud storage providers or from your on-premises storage.

- Move data from one Cloud Storage bucket to another, so that it is available to different groups of users or applications.

- Periodically move data as part of a data processing pipeline or analytical workflow.

Storage Transfer Service provides options that make data transfers and synchronization easier. For example, you can:

- Schedule one-time transfer operations or recurring transfer operations.

- Delete existing objects in the destination bucket if they don't have a corresponding object in the source.

- Delete data source objects after transferring them.

![gcp-transfer-service-concept](../images/gcp-transfer-service-concept.jpg)


Storage Transfer Service does the following by default:

- Storage Transfer Service copies a file from the data source if the file doesn't exist in the data sink or if it differs between the version in the source and the sink.

- Retains files in the source after the transfer operation.

- Uses TLS encryption for HTTPs connections. The only exception is if you specify an HTTP URL for a URL list transfer.


## lets Terraform the Transfer Service

### [Setup GCP Project and Service Account](../01-gcp-setup/README.md) 

### [Set AWS Credentials](../provide-aws-cred-input.md) 

### In this example first we will be creating AWS S3 Bucket

```sh

    ## Create S3 Bucket
    resource "aws_s3_bucket" "sumitgupta28-s3-bucket" {
    bucket = var.AWS_S3_BUCKET_NAME
    acl    = "private"

    tags = {
        Name        = "sumitgupta28-s3-backend"
        Environment = "Dev"
    }
    }

    ## upload few files on S3 bucket
    resource "aws_s3_bucket_object" "s3_bucket_upload" {
    for_each = fileset("images/", "*")
    bucket   = aws_s3_bucket.sumitgupta28-s3-bucket.id
    key      = each.value
    source   = "images/${each.value}"
    etag     = filemd5("images/${each.value}")
    }

```

### Then a GCP Bucket

```sh

    resource "google_storage_bucket" "s3-backup-bucket" {
    name                        = var.GCP_BUCKET_NAME
    storage_class               = "NEARLINE"
    location                    = "US" ## multi Region
    force_destroy               = true
    project                     = var.GCP_PROJECT_ID
    uniform_bucket_level_access = true

    }
```

### Permission for GCP bucket

```sh
    resource "google_storage_bucket_iam_member" "s3-backup-bucket" {
    bucket     = google_storage_bucket.s3-backup-bucket.name
    role       = "roles/storage.admin"
    member     = "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
    depends_on = [google_storage_bucket.s3-backup-bucket]
    }

```


### and Finnally a google_storage_transfer_job which does the transfer.

```sh

    resource "google_storage_transfer_job" "s3-bucket-transfer-job" {
    description = "Job to trasfer images from S3 bucket"
    project     = var.GCP_PROJECT_ID
    ## transfer specification
    transfer_spec {
        ## source Bucket
        aws_s3_data_source {
        bucket_name = var.AWS_S3_BUCKET_NAME
        aws_access_key {
            access_key_id     = var.AWS_ACCESS_KEY
            secret_access_key = var.AWS_SECRET_KEY

        }
        }
        transfer_options {
        delete_objects_unique_in_sink = false
        }

        ## Destination Bucket
        gcs_data_sink {
        bucket_name = google_storage_bucket.s3-backup-bucket.name
        }
    }

    schedule {
        schedule_start_date {
        year  = 2021
        month = 03
        day   = 31
        }
    }
    }


```



### terraform plan

```sh
    $ terraform plan

    An execution plan has been generated and is shown below.  
    Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

    # aws_s3_bucket.sumitgupta28-s3-bucket will be created
    + resource "aws_s3_bucket" "sumitgupta28-s3-bucket" { 
        + acceleration_status         = (known after apply)
        + acl                         = "private"
        + arn                         = (known after apply)
        + bucket                      = "sumitgupta28-s3-bucket"
        + bucket_domain_name          = (known after apply)
        + bucket_regional_domain_name = (known after apply)
        + force_destroy               = false
        + hosted_zone_id              = (known after apply)
        + id                          = (known after apply)
        + region                      = (known after apply)
        + request_payer               = (known after apply)
        + tags                        = {
            + "Environment" = "Dev"
            + "Name"        = "sumitgupta28-s3-backend"
            }
        + website_domain              = (known after apply)
        + website_endpoint            = (known after apply)

        + versioning {
            + enabled    = (known after apply)
            + mfa_delete = (known after apply)
            }
        }

    # aws_s3_bucket_object.s3_bucket_upload["cdid5.png"] will be created
    + resource "aws_s3_bucket_object" "s3_bucket_upload" {
        + acl                    = "private"
        + bucket                 = (known after apply)
        + content_type           = (known after apply)
        + etag                   = "5dc0731b75295d7b4ad2f63505a69b79"
        + force_destroy          = false
        + id                     = (known after apply)
        + key                    = "cdid5.png"
        + server_side_encryption = (known after apply)
        + source                 = "images/cdid5.png"
        + storage_class          = (known after apply)
        + version_id             = (known after apply)
        }

    # aws_s3_bucket_object.s3_bucket_upload["cicd6.jpg"] will be created
    + resource "aws_s3_bucket_object" "s3_bucket_upload" {
        + acl                    = "private"
        + bucket                 = (known after apply)
        + content_type           = (known after apply)
        + etag                   = "58f5b3c382003e6e2b27fe46ec2500b2"
        + force_destroy          = false
        + id                     = (known after apply)
        + key                    = "cicd6.jpg"
        + server_side_encryption = (known after apply)
        + source                 = "images/cicd6.jpg"
        + storage_class          = (known after apply)
        + version_id             = (known after apply)
        }

    # google_storage_bucket.s3-backup-bucket will be created
    + resource "google_storage_bucket" "s3-backup-bucket" {
        + bucket_policy_only          = (known after apply)
        + force_destroy               = true
        + id                          = (known after apply)
        + location                    = "US"
        + name                        = "sumitgupta28-awss3-backup-bucket"
        + project                     = "weighty-wonder-308406"
        + self_link                   = (known after apply)
        + storage_class               = "NEARLINE"
        + uniform_bucket_level_access = true
        + url                         = (known after apply)
        }

    # google_storage_bucket_iam_member.s3-backup-bucket will be created
    + resource "google_storage_bucket_iam_member" "s3-backup-bucket" {
        + bucket = "sumitgupta28-awss3-backup-bucket"
        + etag   = (known after apply)
        + id     = (known after apply)
        + member = "serviceAccount:project-234356343826@storage-transfer-service.iam.gserviceaccount.com"
        + role   = "roles/storage.admin"
        }

    # google_storage_transfer_job.s3-bucket-transfer-job will be created
    + resource "google_storage_transfer_job" "s3-bucket-transfer-job" {
        + creation_time          = (known after apply)
        + deletion_time          = (known after apply)
        + description            = "Job to trasfer images from S3 bucket"
        + id                     = (known after apply)
        + last_modification_time = (known after apply)
        + name                   = (known after apply)
        + project                = "weighty-wonder-308406"
        + status                 = "ENABLED"

        + schedule {

            + schedule_start_date {
                + day   = 31
                + month = 3
                + year  = 2021
                }
            }

        + transfer_spec {
            + aws_s3_data_source {
                + bucket_name = "sumitgupta28-s3-bucket"

                + aws_access_key {
                    + access_key_id     = (sensitive value)
                    + secret_access_key = (sensitive value)
                    }
                }

            + gcs_data_sink {
                + bucket_name = "sumitgupta28-awss3-backup-bucket"
                }

            + transfer_options {
                + delete_objects_unique_in_sink = false
                }
            }
        }

    Plan: 6 to add, 0 to change, 0 to destroy.

    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.

```


### terraform apply

```sh
    $ terraform apply -auto-approve
    google_storage_bucket.s3-backup-bucket: Creating...
    google_storage_bucket.s3-backup-bucket: Creation complete after 2s [id=sumitgupta28-awss3-backup-bucket]
    google_storage_bucket_iam_member.s3-backup-bucket: Creating...
    aws_s3_bucket.sumitgupta28-s3-bucket: Creating...
    google_storage_bucket_iam_member.s3-backup-bucket: Creation complete after 6s [id=b/sumitgupta28-awss3-backup-bucket/roles/storage.admin/serviceaccount:project-234356343826@storage-transfer-service.iam.gserviceaccount.com]
    aws_s3_bucket.sumitgupta28-s3-bucket: Creation complete after 7s [id=sumitgupta28-s3-bucket]
    aws_s3_bucket_object.s3_bucket_upload["cdid5.png"]: Creating...
    aws_s3_bucket_object.s3_bucket_upload["cicd6.jpg"]: Creating...
    aws_s3_bucket_object.s3_bucket_upload["cicd6.jpg"]: Creation complete after 2s [id=cicd6.jpg]
    aws_s3_bucket_object.s3_bucket_upload["cdid5.png"]: Creation complete after 2s [id=cdid5.png]
    google_storage_transfer_job.s3-bucket-transfer-job: Creating...
    google_storage_transfer_job.s3-bucket-transfer-job: Creation complete after 2s [id=weighty-wonder-308406/5495505653004594035]

    Outputs:

    aws-bucket = "arn:aws:s3:::sumitgupta28-s3-bucket"
    gpc-bucket = "gs://sumitgupta28-awss3-backup-bucket"

```

### finally lets validate the S3 bucket and GCP Bucket 

```sh

    $ aws s3 ls s3://sumitgupta28-s3-bucket
    2021-04-01 01:36:19      70894 cdid5.png
    2021-04-01 01:36:19      39137 cicd6.jpg


    $ gsutil ls -l gs://sumitgupta28-awss3-backup-bucket
    70894  2021-04-01T05:36:41Z  gs://sumitgupta28-awss3-backup-bucket/cdid5.png
    39137  2021-04-01T05:36:41Z  gs://sumitgupta28-awss3-backup-bucket/cicd6.jpg
    TOTAL: 2 objects, 110031 bytes (107.45 KiB)

```


### Cleanup

```sh
    $ terraform destroy -auto-approve
    google_storage_bucket_iam_member.s3-backup-bucket: Destroying... [id=b/sumitgupta28-awss3-backup-bucket/roles/storage.admin/serviceaccount:project-234356343826@storage-transfer-service.iam.gserviceaccount.com]
    google_storage_transfer_job.s3-bucket-transfer-job: Destroying... [id=weighty-wonder-308406/5495505653004594035]
    google_storage_transfer_job.s3-bucket-transfer-job: Destruction complete after 1s
    aws_s3_bucket_object.s3_bucket_upload["cdid5.png"]: Destroying... [id=cdid5.png]
    aws_s3_bucket_object.s3_bucket_upload["cicd6.jpg"]: Destroying... [id=cicd6.jpg]
    aws_s3_bucket_object.s3_bucket_upload["cdid5.png"]: Destruction complete after 0s
    aws_s3_bucket_object.s3_bucket_upload["cicd6.jpg"]: Destruction complete after 0s
    aws_s3_bucket.sumitgupta28-s3-bucket: Destroying... [id=sumitgupta28-s3-bucket]
    aws_s3_bucket.sumitgupta28-s3-bucket: Destruction complete after 0s
    google_storage_bucket_iam_member.s3-backup-bucket: Destruction complete after 7s
    google_storage_bucket.s3-backup-bucket: Destroying... [id=sumitgupta28-awss3-backup-bucket]
    google_storage_bucket.s3-backup-bucket: Destruction complete after 2s
```