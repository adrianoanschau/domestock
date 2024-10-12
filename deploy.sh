#!/bin/bash

mv .env .env-backup
cp .env.production .env

gcloud builds submit -t gcr.io/ds-domestock/domestock:app
gcloud run deploy domestock --image gcr.io/ds-domestock/domestock:app --allow-unauthenticated --region us-central1 --set-secrets /config/.env=production_settings:latest
gcloud beta run jobs execute migrate

mv .env-backup .env
