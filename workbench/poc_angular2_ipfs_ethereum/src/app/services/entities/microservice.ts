export class Microservice {

  private _name:string;
  private _description:string;
  private _hashToSwaggerFile:string;

  constructor(name: string, description: string, hashToSwaggerFile?:string) {
    this._name = name;
    this._description = description;
    this._hashToSwaggerFile = hashToSwaggerFile;
  }


  get name(): string {
    return this._name;
  }

  get description(): string {
    return this._description;
  }

  get hashToSwaggerFile(): string {
    return this._hashToSwaggerFile;
  }

  set name(name: string){
    this._name = name;
  }

  set description(description: string){
    this._description = description;
  }
  
  set hashToSwaggerFile(hashToSwaggerFile: string){
    this._hashToSwaggerFile = hashToSwaggerFile;
  }
}
