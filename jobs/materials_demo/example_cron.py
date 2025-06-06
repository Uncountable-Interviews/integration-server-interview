from uncountable.integration.job import CronJob, CronJobArguments, register_job
from uncountable.types import job_definition_t


@register_job
class MyCronJob(CronJob):
    def run(self, args: CronJobArguments) -> job_definition_t.JobResult:
        print("Running MyCronJob")
        return job_definition_t.JobResult(success=True)
