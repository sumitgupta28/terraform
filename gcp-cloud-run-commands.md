## gcloud - Cloud Run

### Cloud run specific Configuration 

```

    $ gcloud config set run/platform managed
    $ gcloud config set run/region us-central1

    $ gcloud config list
    [component_manager]
    disable_update_check = True
    [compute]
    gce_metadata_read_timeout_sec = 30
    region = us-central1
    [core]
    account = sumitgupta28@gmail.com
    disable_usage_reporting = True
    project = weighty-wonder-308406
    [metrics]
    environment = devshell
    [run]
    platform = managed
    region = us-central1

```




### Deploy a Service

```sh

    $ gcloud run deploy sample-service --image us.gcr.io/weighty-wonder-308406/docker-sample-app@sha256:8fab095903e760793211d7d6676408dc4594c1021b236a0db4ea67aa221d5091 --revision-suffix v1 --platform managed --region us-central1
    Allow unauthenticated invocations to [sample-service] (y/N)?  y

    Deploying container to Cloud Run service [sample-service] in project [weighty-wonder-308406] region [us-central1]
    ✓ Deploying new service... Done.                                                           
    ✓ Creating Revision... Revision deployment finished. Waiting for health check to begin.
    ✓ Routing traffic...
    ✓ Setting IAM Policy...
    Done.
    Service [sample-service] revision [sample-service-v1] has been deployed and is serving 100 percent of traffic.
    Service URL: https://sample-service-rw3qaxgcaq-uc.a.run.app

```

### List Service 

```sh
    $ gcloud run services list --platform=managed
        SERVICE         REGION       URL                                             LAST DEPLOYED BY        LAST DEPLOYED AT
    ✔  sample-service  us-central1  https://sample-service-rw3qaxgcaq-uc.a.run.app  sumitgupta28@gmail.com  2021-04-18T02:35:06.339879Z
    ✔  test            us-central1  https://test-rw3qaxgcaq-uc.a.run.app            sumitgupta28@gmail.com  2021-04-18T02:34:28.016761Z
```


### List Revisions

```sh
    $ gcloud run revisions list --platform=managed --region=us-central1
        REVISION           ACTIVE  SERVICE         DEPLOYED                 DEPLOYED BY
    ✔  sample-service-v1  yes     sample-service  2021-04-18 02:34:47 UTC  sumitgupta28@gmail.com
    ✔  test-00001-mov     yes     test            2021-04-18 02:34:09 UTC  sumitgupta28@gmail.com

```


### List regions where cloud run the available 

```sh
    $ gcloud run regions list
    NAME
    asia-east1
    asia-east2
    asia-northeast1
    asia-northeast2
    asia-northeast3
    asia-south1
    asia-southeast1
    asia-southeast2
    australia-southeast1
    europe-central2
    europe-north1
    europe-west1
    europe-west2
    europe-west3
    europe-west4
    europe-west6
    northamerica-northeast1
    southamerica-east1
    us-central1
    us-east1
    us-east4
    us-west1
    us-west2
    us-west3
    us-west4
```

### Delete the Services

```sh
    $ gcloud run services delete sample-service --platform managed --region us-central1
    Service [sample-service] will be deleted.

    Do you want to continue (Y/n)?  y

    Deleting [sample-service]...done.                     
    Deleted service [sample-service].
    $ gcloud run services delete test --platform managed --region us-central1
    Service [test] will be deleted.

    Do you want to continue (Y/n)?  y

    Deleting [test]...done.                     
    Deleted service [test].
    $ gcloud run services list --platform=managed
    Listed 0 items.

```

### Manage Traffic between 2 revisions 

#### creation sample-service-v1

```
    $ gcloud run deploy sample-service --image us.gcr.io/weighty-wonder-308406/docker-sample-app@sha256:8fab095903e760793211d7d6676408dc4594c1021b236a0db4ea67aa221d5091 --revision-suffix v1 --platform managed --region us-central1
    Allow unauthenticated invocations to [sample-service] (y/N)?  y

    Deploying container to Cloud Run service [sample-service] in project [weighty-wonder-308406] region [us-central1]
    ✓ Deploying new service... Done.                                                           
    ✓ Creating Revision... Revision deployment finished. Waiting for health check to begin.
    ✓ Routing traffic...
    ✓ Setting IAM Policy...
    Done.
    Service [sample-service] revision [sample-service-v1] has been deployed and is serving 100 percent of traffic.
    Service URL: https://sample-service-rw3qaxgcaq-uc.a.run.app
```


#### creation sample-service-v2

```sh
    $ gcloud run deploy sample-service --image us.gcr.io/weighty-wonder-308406/docker-sample-app@sha256:8fab095903e760793211d7d6676408dc4594c1021b236a0db4ea67aa221d5091 --revision-suffix v2 --platform managed --region us-central1
    Deploying container to Cloud Run service [sample-service] in project [weighty-wonder-308406] region [us-central1]
    ✓ Deploying... Done.                                                           
    ✓ Creating Revision...
    ✓ Routing traffic...
    Done.
    Service [sample-service] revision [sample-service-v2] has been deployed and is serving 100 percent of traffic.
    Service URL: https://sample-service-rw3qaxgcaq-uc.a.run.app
```

#### List Service and Revisions 

```sh
    $ gcloud run services list --platform=managed --region=us-central1
    SERVICE         REGION       URL                                             LAST DEPLOYED BY        LAST DEPLOYED AT
    ✔  sample-service  us-central1  https://sample-service-rw3qaxgcaq-uc.a.run.app  sumitgupta28@gmail.com  2021-04-18T03:27:43.331408Z

    $ gcloud run revisions  list --platform=managed --region=us-central1
    REVISION           ACTIVE  SERVICE         DEPLOYED                 DEPLOYED BY
    ✔  sample-service-v2  yes     sample-service  2021-04-18 03:24:36 UTC  sumitgupta28@gmail.com
    ✔  sample-service-v1  yes     sample-service  2021-04-18 03:24:06 UTC  sumitgupta28@gmail.com
```

#### Now lets setup traffic as 50-50 % between sample-service-v1 and sample-service-v2

```
    $ gcloud run services update-traffic sample-service --to-revisions=sample-service-v2=50,sample-service-v1=50 --region us-central1 --platform managed
    ✓ Updating traffic... Done.                                         
    ✓ Routing traffic...
    Done.
    URL: https://sample-service-rw3qaxgcaq-uc.a.run.app
    Traffic:
    50% sample-service-v1
    50% sample-service-v2
```

![Revisions_Traffic_split.JPG](./images/Revisions_Traffic_split.JPG)


#### Delete Service 
```sh
    $ gcloud run services delete sample-service
    Service [sample-service] will be deleted.

    Do you want to continue (Y/n)?  Y

    Deleting [sample-service]...done.                     
    Deleted service [sample-service].
```
