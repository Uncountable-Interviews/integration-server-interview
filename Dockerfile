FROM public.ecr.aws/uncountable/uncountable/integrations/public/integration-server-base:1b2d73b6708

COPY ./pyproject.toml .
RUN python -m pip install .
COPY . .

ENV UNC_PROFILES_MODULE=jobs
ENV UNC_SQLITE_URI=sqlite:////data/sqlite.db
