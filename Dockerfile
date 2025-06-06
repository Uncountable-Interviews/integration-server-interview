FROM 502071203139.dkr.ecr.us-west-2.amazonaws.com/uncountable/integrations/integration-server-base:73c9ea80b8d

COPY ./pyproject.toml .
RUN python -m pip install .
COPY . .

ENV UNC_PROFILES_MODULE=jobs
ENV UNC_SQLITE_URI=sqlite:////data/sqlite.db