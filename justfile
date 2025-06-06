set export

python := env_var_or_default('PYTHON_CMD', 'python3.12')
api_id := env_var_or_default("UNC_PROFILE_MATERIALS_DEMO_API_ID", "dummy")
api_secret := env_var_or_default("UNC_PROFILE_MATERIALS_DEMO_API_SECRET_KEY", "dummy")

get-name:
  #!/usr/bin/env bash
  set -a
  source .repoenv
  set +a
  echo $REPO_NAME

get-image-tag:
  git rev-parse --short=11 HEAD

get-full-image-name:
  echo 502071203139.dkr.ecr.us-west-2.amazonaws.com/uncountable/integrations/$(just get-name):$(just get-image-tag)

docker-login:
  aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 502071203139.dkr.ecr.us-west-2.amazonaws.com

push:
  docker push $(just get-full-image-name)

build:
  docker build -t $(just get-full-image-name) .

mk-data-dir:
  mkdir -p mnt/data

run: mk-data-dir
  docker run -e UNC_PROFILE_MATERIALS_DEMO_API_ID=$api_id -e UNC_PROFILE_MATERIALS_DEMO_API_SECRET_KEY=$api_secret --mount source=./mnt/data,destination=/data,type=bind $(just get-full-image-name)

run-shell: mk-data-dir
  just mk-data-dir
  docker run --network host --mount source=./mnt/data,destination=/data,type=bind -it --entrypoint bash $(just get-full-image-name)

validate-repo:
  ruff check --config pyproject.toml
  mypy .

# Confirm continue prompt
_confirm message="Continue?":
    #!/usr/bin/env bash
    set -euo pipefail
    read -p "{{message}} [Yes,No] " result
    case "$result" in
        Yes|Y|y) exit 0;;
        *) exit 1;;
    esac

_collect-input message:
    #!/usr/bin/env bash
    set -euo pipefail
    read -p "{{message}}" result
    echo "$result"

setup-repo:
  #!/usr/bin/env bash
  echo "This will reset existing settings on the repo."
  just _confirm
  REPO_NAME=$(just _collect-input "name for repo (i.e. integration-server-mycompany): ")
  rm .repoenv 2>/dev/null || true 
  touch .repoenv
  echo "REPO_NAME=$REPO_NAME" >> .repoenv

  sed -i '/# begin_project_name/,/# end_project_name/{/# begin_project_name/{p; a\
  # DO NOT MODIFY\
  name = "'"$REPO_NAME"'"\n# end_project_name
  }; d}' pyproject.toml


  echo "Wrote repository settings to .repoenv file:"
  cat .repoenv

enqueue-job *args:
  {{python}} -m uncountable.integration.cli run {{args}}

setup:
  #!/usr/bin/env bash
  {{ python }} -m venv .venv
  source .venv/bin/activate
  {{ python }} -m pip install .
  echo "To activate virtual env: source .venv/bin/activate"

run-integration-server:
  mkdir -p
  UWSGI_INI=local_dev/uwsgi.ini PYTHONPATH=./ UNC_INTEGRATION_ENVS=local UNC_PROFILES_MODULE=jobs UNC_CRON_SQLITE_URI=sqlite:///data/sqlite.db UNC_RUNNER_SQLITE_URI=sqlite:///data/sqlite_runner.db GRPC_ENABLE_FORK_SUPPORT=false {{ python }} -m uncountable.integration.scheduler
