#!/bin/bash
PATH="$PATH":/snap/bin
HOME=/home/jherreralizalde/
export BOTO_CONFIG="/home/jherreralizalde/.config/gcloud/legacy_credentials/jherreralizalde@gmail.com/.boto"
gcloud pubsub subscriptions pull demo-subscription  --project projecto-demo-337817" >> /tmp/log.txt
gsutil cp /tmp/log.txt gs://gcp_t2/