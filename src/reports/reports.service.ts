import { Injectable } from '@nestjs/common';
import { CreateReportDto } from './dto/create-report.dto';
import { UpdateReportDto } from './dto/update-report.dto';
import { IOutput, IQueue } from 'src/_helpers/default-interfaces';
import { PrismaService } from 'src/prisma/prisma.service';
import { BigdatacorpService } from '@app/bigdatacorp';
import { MakePdfService } from 'src/_services/make-pdf/make-pdf.service';
import { GetPdfReportDto } from './dto/get-pdf-report.dto';
import { InjectQueue } from '@nestjs/bull';
import { Queue } from 'bull';


@Injectable()
export class ReportsService {

  constructor(
    private prisma: PrismaService,
    private bigdata: BigdatacorpService,
    private makePdf: MakePdfService,
    @InjectQueue('reports') private reportsQueue: Queue
  ) {

  }

  create(createReportDto: CreateReportDto) {
    return 'This action adds a new report';
  }

  findAll() {
    return `This action returns all reports`;
  }

  findOne(id: number) {
    return `This action returns a #${id} report`;
  }

  update(id: number, updateReportDto: UpdateReportDto) {
    return `This action updates a #${id} report`;
  }

  remove(id: number) {
    return `This action removes a #${id} report`;
  }

  async getPdfReport(userID: number, params: GetPdfReportDto) {
    let output: IOutput = {success: false, message: ""};
    let queueData: IQueue = {
      message: "teste",
      data: "DATA"
    };
    this.reportsQueue.add('generateReport', queueData);
    // try {

    //   // billing amount
    //   let valueCharge: number = 0.0;

    //   // Get users finance data
    //   const financeData = await this.prisma.finances.findUnique({
    //     where: {
    //       userId: userID
    //     },
    //     select: {
    //       balance: true,
    //       debit: true
    //     }
    //   });
    //   if (!financeData) {
    //     throw new Error("User cannot issue reports");
    //   }

    //   //check if the user has the category registered
    //   const isExistingCategory = await this.prisma.usersOnCategories.findFirstOrThrow({
    //     where: {
    //       categoryId: Number(params.categoryID),
    //       userId: userID
    //     }
    //   }).catch((error) => {
    //     throw new Error("Usuário não possui essa categoria!");
    //   });


    //   const categoryData = await this.prisma.categories.findFirstOrThrow({
    //     where: {
    //       id: Number(params.categoryID)
    //     },
    //     select: {
    //       id: true,
    //       name: true,
    //       description: true,
    //       custom_value: true,
    //       created_at: true,
    //       updated_at: true,
    //       CategoriesOnModules: {
    //         orderBy: {
    //           order: 'asc'
    //         },
    //         select: {
    //           Modules: {
    //             select: {
    //               id: true,
    //               name: true,
    //               path_make_function: true,
    //               description: true,
    //               value: true,
    //               created_at: true,
    //               updated_at: true,
    //               ResourcesOnModules: {
    //                 select: {
    //                   Resources: {
    //                     select: {
    //                       id: true,
    //                       name: true,
    //                       description: true,
    //                       library: true,
    //                       value: true,
    //                       created_at: true,
    //                       updated_at: true,
    //                       path: true
    //                     }
    //                   }
    //                 }
    //               },
    //             }
    //           },
    //         }
    //       }
    //     }
    //   }).catch(error => { throw new Error(`${error.code ?? ''} Categoria não foi encontrado`) });

    //   let infoData: any = {};
    //   let htmlContent: string = "";
    //   await Promise.all(categoryData.CategoriesOnModules.map(async (module) => {
    //     console.log(module.Modules.name)

    //     // Update billing amount
    //     valueCharge = valueCharge + module.Modules.value;

    //     await Promise.all(module.Modules.ResourcesOnModules.map(async (resource: any) => {

    //       //GET PATH FUNCTION OF GET INFORMATIONS
    //       let pathFunction: keyof typeof BigdatacorpService = resource.Resources.path as keyof typeof BigdatacorpService;

    //       // CHECK IF EXISTS AND GET INFORMATIONS
    //       if (this.bigdata && typeof this.bigdata[pathFunction] === 'function') {
    //         const returnBigData = await this.bigdata[pathFunction]({
    //           doc: params.doc
    //         });
    //         infoData[`${resource.Resources.path}`] = returnBigData;
    //       } else {
    //         console.error(`Método ${pathFunction} não encontrado em this.bigdata`);
    //       }
    //       // console.log(infoData)
    //     }));
    //     let newHtml = await this.makePdf[module.Modules.path_make_function](infoData);
    //     if (!newHtml.success) {
    //       throw new Error(newHtml.message)
    //     }
    //     htmlContent = `${htmlContent}${newHtml.data}`

    //   }));

    //   const pdfData = await this.makePdf.makePdf({
    //     content: htmlContent,
    //   });

    //   //Updating users billing amount
    //   await this.prisma.$transaction([
    //     this.prisma.finances.update({
    //       where: {
    //         userId: userID
    //       },
    //       data: {
    //         debit: financeData.debit + valueCharge
    //       }
    //     })
    //   ]);

    //   // ADDING TO FINANCIAL HISTORY 
    //   this.prisma.finance_history.create({
    //     data: {
    //       action: "REPORT",
    //       value: valueCharge,
    //       userId: userID
    //     }
    //   }).catch((error) => { console.log(error) });

    //   // ADDING TO REPORT HISTORY 
    //   this.prisma.report_history.create({
    //     data: {
    //       report: "-",
    //       value: valueCharge,
    //       userId: userID
    //     }
    //   });


    //   output = {
    //     success: true,
    //     message: "",
    //     data: pdfData.data
    //   }
    // } catch (error) {
    //   output = {
    //     success: false,
    //     message: error.message
    //   }
    // }
    // console.log(output)
    return output;
  }
}
