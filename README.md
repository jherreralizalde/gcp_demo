# gcp_demo
# Task 1

The goal for that part of the demo its capture Pub/Sub messajes ant keep it in a Cloud Storage file that with a cron working every 5 minutes.

# Pre requisites

- Enable the necesary GCP APIs
- Service account with the necesary privileges
- Terraform
- Github repo

# Terraform config

To create the infra necesary for that task, that files will be used:

- auth.tf
- backend.tf
- provider.tf
- versions.tf
- instance.tf
- pub-sub.tf
- startup.sh

Aditional that files will usesd for security and Jenkins code:

- .gitignore
- Jenkinsfile

To capture the Pub/Sub message i decided to use one file and add every 5 minutes a new message on it:

![image](https://user-images.githubusercontent.com/95724419/148980506-153ad5b8-eff2-4200-9b9a-febfce957fdc.png)

# Jenkins

Jenkins is used to integrate Terraform and can apply and destroy change, thats the view of the interface:

![image](https://user-images.githubusercontent.com/95724419/148981742-0d914f64-e732-40df-bfda-3d9e8ebe4177.png)
