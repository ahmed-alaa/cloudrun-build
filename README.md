# Symfony on CloudRun

It's basic symfony application that runs on CloudRun.

## How to deploy on CloudRun

1. Build the image

```shell script
gcloud builds submit --tag gcr.io/PROJECT-ID/cloudrun
```

2. Deploy the image

```shell script
gcloud run deploy --image gcr.io/PROJECT-ID/cloudrun --platform managed
```

## Resources
1. [Build & Deploy][1]

[1]: <https://cloud.google.com/run/docs/quickstarts/build-and-deploy>
