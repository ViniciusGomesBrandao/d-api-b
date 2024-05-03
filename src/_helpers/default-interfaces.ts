export interface IOutput {
  success: boolean;
  message: string;
  data?: any;
}

export interface IQueue {
  message?: string,
  data: any
}