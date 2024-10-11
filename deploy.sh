#!/bin/bash

mv .env .env-backup
cp .env.production .env

gcloud builds submit -t gcr.io/ds-domestock/domestock:app
gcloud run deploy domestock --image gcr.io/ds-domestock/domestock:app --allow-unauthenticated --region us-central1

mv .env-backup .env
