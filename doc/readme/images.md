## Images
This functionality helps in automatic building and versioning images that can be used in services or other project repositories.

## Workflows
The repository contains two interrelated workflows that operate on entities named `SCOPE`. A `SCOPE` is a folder containing a [Dockerfile](https://docs.docker.com/engine/reference/builder) at its base level. Nesting of `SCOPE` is allowed, but each entity is treated separately. The `SCOPE_NAME` is the relative path to the `SCOPE` excluding the `SCOPE_ROOT` value (by default: _images_).

<details>
  <summary>Example of building paths</summary>

| `SCOPE_ROOT` | `SCOPE_NAME`   | `SCOPE_PATH`           |                  image URI                   |
|--------------|----------------|------------------------|:--------------------------------------------:|
| images       | scope1         | images/scope1          | `{REGISTRY}/{REPOSITORY}/{SCOPE_NAME}:{TAG}` |
| images       | scope1/scope1a | images/scope1/scope1a  |                      ↓                       |
| images       | scope2         | images/scope2          |                      ↓                       |

</details>

### [Docker build test push](../../.github/workflows/docker-build-test-push.yaml)
This workflow is responsible for building a single image within the `SCOPE`. It is automatically triggered by the [On scope root changes](#on-scope-root-changes) workflow or can be manually started in actions, where each run can be further parameterized. The workflow consists of two independent jobs: `docker-build-test` tests the image build and `docker-build-push` publishes the built image to a [registry](https://docs.docker.com/registry) (by default: _ghcr.io_).

<details>
  <summary>Build jobs specification</summary>

|             event             |      job name       | from cache | push to registry |        architectures        |            tags             |
|:-----------------------------:|:-------------------:|:----------:|:----------------:|:---------------------------:|:---------------------------:|
| pull_request<br/>push (≠main) | `docker-build-test` |     ✓      |        -         |         linux/amd64         | latest<br/>(image URI test) |
|         push (=main)          | `docker-build-push` |     ✓      |        ✓         | linux/amd64<br/>linux/arm64 |       latest<br/>1.x        |

</details>

### [On scope root changes](../../.github/workflows/on-scope-root-changes.yaml)
This workflow triggers the [Docker build push test](#docker-build-test-push) based on the event, according to the build job specification. The workflow consists of three sequentially executed jobs: `detect-scope-changes` detects changes within `SCOPE_ROOT`, `matrix-build` performs parallel image builds within the `SCOPE`, and `matrix-build-check` verifies that the entire process has completed successfully.

<details>
  <summary>Example of change detection</summary>

| file                             | modified | `SCOPE_NAME`   | rebuild |
|----------------------------------|:--------:|----------------|:-------:|
| images/scope1/Dockerfile         |    -     | scope1         |    -    |
| images/scope1/scope1a/Dockerfile |    ✓     | scope1/scope1a |    ✓    |
| images/scope2/Dockerfile         |    -     | scope2         |    ✓    |
| images/scope2/bin/script.sh      |    ✓     | scope2         |    ✓    |
| images/scope2/scope2a/Dockerfile |    -     | scope2/scope2a |    -    |
| out/of/scope/root/Dockerfile     |    ✓     | -              |    -    |

</details>

## Usage
1) Create a `SCOPE` in the `SCOPE_ROOT` containing Dockerfile.
2) Push it to the main or other branch with pull request.
3) Check the actions, depending on the previous step, the published image should be in the packages.

<details>
  <summary>Workflows limitations</summary>

- Due to the parallel building of images, it is not possible to build dependent images in a single run. This is because at the time of building, these images are not yet present in the registry.
- Changes in `SCOPE_ROOT` are detected using _git diff_. Therefore, force pushes that modify the history below the base commit can result in errors in detecting changes.

</details>
