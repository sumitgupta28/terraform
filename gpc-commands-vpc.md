
## gcloud - compute networks


### gcloud - compute -- networks create

```sh
    $ gcloud compute networks create test-vpc-network \
    --project=gcp-learning-project-312006 \
    --description=test-vpc-network \
    --subnet-mode=custom \
    --mtu=1460 \
    --bgp-routing-mode=regional
```

### gcloud - compute -- subnets create
```sh
    $ gcloud compute networks subnets create us-west-1-subnet \
    --project=gcp-learning-project-312006 \
    --description=us-west-1-subnet \
    --range=10.0.0.0/12 \
    --network=test-vpc-network \
    --region=us-west1 \
    --secondary-range=RANGE_NAME=IP_RANGE \
    --enable-private-ip-google-access
```