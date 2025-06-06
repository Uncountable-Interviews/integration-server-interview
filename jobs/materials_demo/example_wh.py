from dataclasses import dataclass
from uncountable.integration.job import CronJobArguments, WebhookJob, register_job
from uncountable.types import base_t, job_definition_t


@dataclass(kw_only=True)
class ExamplePayload:
    entity_id: base_t.ObjectId


@register_job
class MyCronJob(WebhookJob[ExamplePayload]):
    @property
    def webhook_payload_type(self) -> type[ExamplePayload]:
        return ExamplePayload

    def run(self, args: CronJobArguments, payload: ExamplePayload) -> job_definition_t.JobResult:
        print(f"Recieved webhook payload {payload}")
        return job_definition_t.JobResult(success=True)
