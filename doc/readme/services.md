## Services
This functionality allows defining individual services or groups of services that are not strictly associated with a single project repository. These services will be deployed and available for use by other services in external repositories.

## Environment
Each service has a main configuration file named `docker-compose.yaml` defined in its root folder. Environment-specific configurations are handled through the `.env.<env>` and `docker-compose.<env>.yaml` files stored in the configuration folder. The complete service environment is a combination of these files.

`<env> = docker-compose.yaml + docker-compose.<env>.yaml + .env.<env>`

## Template
All services should adhere to the following structure, which will be used in later stages of deployments from service path.

```
.
├── ...
├── services
│   └── <group>
│       └── <service>
│           ├── etc
│           │   └── config
│           │       ├── compose
│           │       │   └── docker-compose.<env>.yaml
│           │       └── dotenv
│           │           └── env.<env>
│           └── docker-compose.yaml
└── ...
```

Service path: `./services/<group>/<service>`

## Secrets
During deployment, all secret placeholders for environment variables from the `.env.<env>` file will be automatically replaced with their corresponding environment-specific values, directly from the [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets).

