#!/bin/bash
apt-get install apt-transport-https ca-certificates gnupg
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
apt-get update
apt-get install cron -y
apt-get install google-cloud-sdk
systemctl enable cron
cat <<EOF > /script.sh
#!/bin/bash
PATH="$PATH":/snap/bin
HOME=/home/jherreralizalde/
export BOTO_CONFIG="/home/jherreralizalde/.config/gcloud/legacy_credentials/jherreralizalde@gmail.com/.boto"
<<<<<<< HEAD
gcloud pubsub subscriptions pull demo-subscription  --project miprimerproyecto-333317 >> /tmp/log.txt
gsutil mb gs://gcp_t2/
=======
gcloud pubsub subscriptions pull demo-subscription  --project projecto-demo-337817 >> /tmp/log.txt
>>>>>>> 4c55cf5d29c2de2482f9a596dbc5cbfd438ef5ff
gsutil cp /tmp/log.txt gs://gcp_t2/
EOF
chmod +x /script.sh 
echo "* * * * * /script.sh" > crontab_script
crontab crontab_script