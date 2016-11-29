import {Injectable} from '@angular/core';
import {IpfsService} from "../ipfs/ipfs.service";
import {EthereumService} from "../ethereum/ethereum.service";
import {Microservice} from "../entities/microservice";

@Injectable()
export class ServiceRepositoryService {

  constructor(private _ipfsService: IpfsService, private _ethereumService: EthereumService) {
  }

  registerService(microservice: Microservice): Promise<any> {
    let promise = new Promise((resolve, reject) => {
      if (this._ipfsService.node != null && this._ethereumService.web3 != null) {
        // TODO:
        // 1. Add swaggerfile to IPFS and get a hash for it (lets call it saggerHash)
        // 2. Create a new Microservice(name, description, swaggerHash) entity and convert it to JSON
        // 3. Put that JSON to IPFS and get a hash for the metadata --> metadataHash
        // 4. Call the ethereum contract to register that metadataHash
        // 5. Done
        resolve("TODO");
      } else {
        reject(new Error("You have to connect to the IPFS and Ethereum networks first first!"));
      }
    });
    return promise;
  }

  getAllServices(): Promise<any> {
    let promise = new Promise((resolve, reject) => {
      if (this._ipfsService.node != null && this._ethereumService.web3 != null) {
        // TODO:
        // 1. Get all hashes from the Blockchain
        // 2. For every hash we got, we have to fetch the metadata from IPFS
        // 3. Done (delete the mocks below)


        let microservicesMocks: Microservice[] = [new Microservice("Word counter", "This service counts some words"),
          new Microservice("Image scale", "This service scales images for you", "http://petstore.swagger.io/v2/swagger.json"),
          new Microservice("Key value store", "This service is a simple key value store")];

        resolve(microservicesMocks);
      } else {
        reject(new Error("You have to connect to the IPFS and Ethereum networks first first!"));
      }
    });
    return promise;
  }

  getService(hash: string): Promise<any> {
    let promise = new Promise((resolve, reject) => {
      if (this._ipfsService.node != null && this._ethereumService.web3 != null) {
        // TODO:
        // 1. Fetch the service metadata from IPFS for the given hash
        // 2. Done
        resolve("TODO");
      } else {
        reject(new Error("You have to connect to the IPFS and Ethereum networks first first!"));
      }
    });
    return promise;
  }
}
