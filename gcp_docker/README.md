# GCP deploy with docker

## Tl;Dr: [lighthouse_report](gcp_docker_report.pdf)

I was able to complete this one in a 25 minute pomadoro session.

Based on this tutorial:

- [Deploy a Dockerized FastAPI App to Google Cloud Platform](https://towardsdatascience.com/deploy-a-dockerized-fastapi-app-to-google-cloud-platform-24f72266c7ef) up until database steps.

The only issue I ran into was needing to link a billing account to my project. Once that was done I had no need to even enter the GCP console.

One thing that I found that was really nice for gcps terminal utility is that it will automatically prompt me to run services and items that I am missing:

```bash
➜  fastAPIStaticSite git:(main) ✗ gcloud run deploy --image gcr.io/frankenstein5199/fastapi2 --platform managed
Service name (fastapi2):  
API [run.googleapis.com] not enabled on project [REDACTED]. Would 
you like to enable and retry (this will take a few minutes)? (y/N)?  y

Enabling service [run.googleapis.com] on project [REDACTED]...
Operation "operations/acf.p2-REDACTED-fb8a74b8-f394-4200-9e20-0010aaad1afe" finished successfully.
Please specify a region:
 [1] asia-east1
 [2] asia-east2
...
 [17] southamerica-east1
 [18] us-central1

Please enter your numeric choice:  18

To make this the default region, run `gcloud config set run/region us-central1`.

Allow unauthenticated invocations to [fastapi2] (y/N)?  y

Deploying container to Cloud Run service [fastapi2] in project [frankenstein5199] region [us-central1]
✓ Deploying new service... Done.                                                                                                        
  ✓ Creating Revision... Initializing project for the current region.                                                                   
  ✓ Routing traffic...                                                                                                                  
  ✓ Setting IAM Policy...                                                                                                               
Done.                                                                                                                                   
Service [fastapi2] revision [fastapi2-00001-fib] has been deployed and is serving 100 percent of traffic.
Service URL: REDACTED

```

In 1 command, I am able to enable the necessary api, select a region, and finish my deployment. 

Post deployment I was a little confused as to where I had just deployed my app. A quick perusal of the very well written [gcp docs](https://cloud.google.com/sdk/gcloud/reference/run/deploy) for the `gcloud run deploy` command lead me to learn that I had just deployed to [GCP Cloud Run](https://cloud.google.com/run) in the us-central1 region. Essentially, Cloud Run sounds very much like Fargate.



### Lighthouse report

As with the nginx site, I ran the [lighthouse_report](gcp_docker_report.pdf) report against the `redoc` endpoint as `/` produces json and is therefore NOT an auditable mime type for lighthouse.

## Comparison with nginx lighthouse report

#### [nginx_report](https://github.com/aloutfi/fastAPIStaticSite/blob/main/nginx/nginx_report.pdf)

#### [gcp_docker_report](https://github.com/aloutfi/fastAPIStaticSite/blob/main/gcp_docker/gcp_docker_report.pdf)

### Insights:

All statistics were the same unless otherwise noted.

#### Performance 

The gcp and docker website scored a 97 while the nginx site scored a 98. The docker lighthouse report had a suggestion to remove unused javascript. I therefore think we can safely disregard this discrepancy 

#### Best Practices

The nginx site scored a 93 while the gcp and docker website scored 100! The nginx lighthouse report had a warning that the site did not use https to load content. I had noticed that the site had an https endpoint when I navigated to it! This is another great pro of the docker deploy: Cloud Run was able to automatically take care of preliminary security concerns.



## Conclusion

Being able to use docker as a separation of concerns piece was helpful as it allowed for separation of concerns. No need to ssh into a remote server. The service is deployed to GCP without needing to configure or deal with the caveats that I ran into while deploying nginx to an AWS ec2 instance.

The taking care of https alone is enough for me to disregard the (trivial) performance hit that probably isn’t even docker related. 

