import { Process, Processor } from '@nestjs/bull';
import { Job } from 'bull';
import { IQueue } from 'src/_helpers/default-interfaces';

@Processor('reports')
export class ReportsConsumer {
    @Process('generateReport')
    async transcode(job: Job<IQueue>) {
        let progress = 0;
        console.log(job)
        for (let i = 0; i < 3; i++) {
            console.log(job.data.message);
            console.log(job.data.data);
        }
        return {};
    }
}