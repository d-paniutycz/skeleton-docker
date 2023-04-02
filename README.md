## Purpose
The purpose of this repository is to create a central Docker repository responsible for building images and deploying individual services as well as other project releases.

## Requirements
- Docker Compose >=2.17
- Docker Engine >=20.10
- Git

## Table of contents
1) [Images](doc/readme/images.md)
2) [Services](doc/readme/services.md)
3) [Deployment](doc/readme/deployment.md)

## Required
Repository environmental variables (secrets):

| variable name        | env name |
|----------------------|----------|
| APP_SECRET           | staging  |
| DMS_PG1_PRI_PASSWORD | staging  |
| DMS_PG1_REP_PASSWORD | staging  |
| SSH_USER             | staging  |
| SSH_HOST             | staging  |
| SSH_PRIVATE_KEY      | staging  |
