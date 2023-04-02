## Workflows
Services can be deployed in two ways: either by specifying the service path within this repository or by releasing from another repository based on a tag. The deployment chain is defined in `deploy-services.yaml` and can be triggered manually.

![](/doc/readme/img/manual-deploy.png)

### [Deploy services from path](../../.github/workflows/deploy-services-from-path.yaml)
Deploys a service directly from the specified path, where its configuration resides. Building a service has been discussed in the [services](services.md) chapter.

Example invocation in `deploy-services.yaml`:

```yaml
  deploy-be-dms:
    name: Deploy (be-dms)
    uses: ./.github/workflows/deploy-services-from-path.yaml
    with:
      environment: ${{ inputs.environment }}
      service_path: 'services/be/dms'
```

### [Deploy services from release](../../.github/workflows/deploy-services-from-release.yaml)
Deploys services directly based on a release from the specified repository, which contains artifacts with environment configurations.

Example invocation in `deploy-services.yaml`:

```yaml
  deploy-be-app:
    name: Deploy (be-app)
    uses: ./.github/workflows/deploy-services-from-release.yaml
    with:
      repository: ${{ inputs.be_app_repository }}
      environment: ${{ inputs.environment }}
      release_tag: ${{ inputs.be_app_release_tag }}
```

### Artifacts
Each release should have an artifact named `environment.tar.gz` that contains the service and environmental configurations used for the deployment.

Example content of `environment.tar.gz`:
```
.
├── docker-compose.yaml
├── docker-compose.<env>.yaml
└── env.<env>
```
