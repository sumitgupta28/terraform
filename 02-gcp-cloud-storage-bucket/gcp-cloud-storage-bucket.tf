## Create a storage bucket
resource "google_storage_bucket" "test-bucket" {
  name          = "sumitgupta28-testbucket-xxx"
  location      = "US" ## multi Region
  force_destroy = true

  uniform_bucket_level_access = true

 ## Delete it after 3 revisions   
 lifecycle_rule {
    condition {
      num_newer_versions = 3
    }
   action {
     type = "Delete"
   }
 }
## Move to NearLine post 30 days
 lifecycle_rule {
   condition {
     age = 30
   }
   action {
     type = "SetStorageClass"
     storage_class = "NEARLINE"
   }
 }
## Move to Coldline post 90 days
lifecycle_rule {
   condition {
     age = 90
   }
   action {
     type = "SetStorageClass"
     storage_class = "COLDLINE"
   }
 }

## Move to Archive post 360 days

 lifecycle_rule {
   condition {
     age = 360
   }
   action {
     type = "SetStorageClass"
     storage_class = "ARCHIVE"
   }
 }
   

}