# Uncountable Integration Server Demo

This repository contains an example integration server project. It comes with a
Dockerfile that can be used to build a deployable image for the integration
server.

## Development

### Profiles

Profiles are identities that jobs run as. A profile is configured with a name
and details for authenticating to a given Uncountable instance. In the
integration server repository, profiles are the folders inside the `jobs/`
folder. For example, this repository has `jobs/materials_demo`, with
`materials_demo` being the named of the profile. In addition to living in the
`jobs` folder, profiles must also contain a `profile.yaml` file. See
`jobs/materials_demo/profile.yaml` as an example.

### Environments

Jobs can be targetted against multiple environments. In your profile definition, specify environments like so:
(see `jobs/materials_demo/profile.yaml` for a full example)

```yaml
environments:
  local:
    base_url: http://localhost:5000
    auth_retrieval:
      type: basic
      api_id_secret:
        type: env
        env_key: API_ID
      api_key_secret:
        type: env
        env_key: API_SECRET_KEY
```

### Authentication

Profiles require an `auth_retrieval` mechanism, as specified in their
`profile.yaml` configuration. This config should return credentials for the
integration server to connect to the Uncountable instance via API.

Example:
Load a secret from AWS:
```yaml
auth_retrieval:
  type: basic
  api_id_secret:
    type: aws
    secret_name: integrations/materials_npm/api
    sub_key: apiId
    region: us-west-2
  api_key_secret:
    type: aws
    secret_name: integrations/materials_npm/api
    sub_key: apiSecretKey
    region: us-west-2
```

### Jobs

All jobs must run using a single profile, and must live inside that profile's
folder. As an example, see `jobs/materials_demo/example_cron.py`. This job is
configured to run every minute in `jobs/materials_demo/profile.yaml`. It is
being referenced by the `executor` property in
`jobs/materials_demo/profile.yaml`. When the integration server is started, it
will automatically discover the job and load the profile.


### Running Locally

Use the just command `just setup` to set up the repo. This initializes the virtual environment and installs dependencies. Any time you update dependencies in `pyproject.toml` you can rerun this command to update your dependencies. 

After setting up your virtual environment, do `source .venv/bin/activate` to activate it.

To run the integration server, simply do `just run-integration-server`. This will start the server with `UNC_INTEGRATION_ENVS=local`. See [Environments](#environments) for more details on configuring your local environment.

Now in another terminal, you can enqueue a job manually via `just enqueue-job {job_ref_name}`. This will enqueue the job to your locally-running integration server.

You can also trigger a webhook job by defining a webhook locally in your application using a webhook URL of the form: http://localhost:5001/materials_auto/example_wh (using the example from `jobs/materials_demo/profile.yaml`).

## Deployment

### Requirements

The integration server must be built using the provided Dockerfile (`just
build`). The Docker image can then be deployed on a server or cloud location.
The integration server expects the following:

- Networking access to the Uncountable instance(s) that jobs are configured for
- Persistent storage (At least 256GB) mounted at `/data` in the running
  container
