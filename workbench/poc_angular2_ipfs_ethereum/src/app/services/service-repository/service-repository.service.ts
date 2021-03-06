import {Injectable} from '@angular/core';
import {IpfsService} from "../ipfs/ipfs.service";
import {EthereumService} from "../ethereum/ethereum.service";
import {Microservice} from "../entities/microservice";
import {ContractProviderService} from "../contract-provider/contract-provider.service";

@Injectable()
export class ServiceRepositoryService {

  constructor(private _ipfsService: IpfsService, private _ethereumService: EthereumService) {
  }

  /**
   * This method registers a service to the marketplace by putting the metadata to IPFS and the
   * ownership information to the blockchain.
   * @param name The service name
   * @param description The service description
   * @param swaggerJson The swagger description as a json string
   * @returns {Promise<T>} Returns a promise that resolves the service hash as soon as all the steps
   * are done and the service is registered.
   */
  registerService(name: string, description: string, swaggerJson: string): Promise<any> {
    return new Promise((resolve, reject) => {
      if (this._ipfsService.node != null && this._ethereumService.web3 != null) {

        // 1. Add swaggerfile to IPFS and get a hash for it (lets call it saggerHash)
        this._ipfsService.putToIpfs(swaggerJson).then(ipfsSwaggerFile => {
          let swaggerHash = ipfsSwaggerFile.hash;
          console.log("Step 1 succeeded: IPFS swagger hash " + swaggerHash);

          // 2. Create a new Microservice(name, description, swaggerHash) entity and convert it to JSON
          let microserviceObject: Microservice = new Microservice(name, description, swaggerHash);
          console.log("Uploading microservice: " + microserviceObject);
          let serviceJsonString = JSON.stringify(microserviceObject);
          console.log("Uploading serviceJsonString: " + serviceJsonString);

          // 3. Put that JSON to IPFS and get a hash for the metadata --> serviceHash
          this._ipfsService.putToIpfs(serviceJsonString).then(ipfsServiceFile => {
            let serviceHash = ipfsServiceFile.hash;
            console.log("Step 2 succeeded: IPFS service hash " + serviceHash);

            // 4. Call the ethereum contract to register that metadataHash
            let registrationContract = this._ethereumService.web3.eth.contract(ContractProviderService.REGISTRY_CONTRACT_ABI)
              .at(ContractProviderService.REGISTRY_CONTRACT_ADDRESS);
            let result = registrationContract.Register(serviceHash);
            console.log("Step 3 succeeded: Ethereum transaction id " + result);

            // 5. Done
            resolve(serviceHash);

          }).catch(err => {
            reject(err);
          });
        }).catch(err => {
          reject(err);
        });
      } else {
        reject(new Error("You have to connect to the IPFS and Ethereum networks first!"));
      }
    });
  }

  /**
   * Returns all services that are registered at the marketplace
   * TODO
   * @returns {Promise<T>}
   */
  getAllServices(): Promise<any> {
    let promise = new Promise((resolve, reject) => {
      if (this._ipfsService.node != null && this._ethereumService.web3 != null) {
        /*
        let catalogueContract = this._ethereumService.web3.eth.contract(ContractProviderService.REGISTRY_CONTRACT_ABI)
        .at(ContractProviderService.REGISTRY_CONTRACT_ADDRESS);
        let serviceHashList = catalogueContract.services(); //?
        console.log("Succeeded getting service catalogue:" + serviceHashList);
        */
        // TODO:
        // 1. Get all hashes from the Blockchain
        
        let serviceHashList: string[] = ["Qmc33Sjp9xzRW5zbXPhUQCBfuFSqckuYkYN1nD7btSeYjq",
        "Qmem6Dv6pVjXLXcw8gKUqWHycSo8r63gLyeMVBxeGxBbYd"];

        let microservices: Microservice[] = [];
        for(let serviceHash of serviceHashList){
          this._ipfsService.getFromIpfs(serviceHash).then(ipfsServiceFile => {
            let serviceObj = JSON.parse(ipfsServiceFile);
            microservices.push(new Microservice(serviceObj._name, serviceObj._description, serviceObj._hashToSwaggerFile));
            console.log(serviceObj._name + ", " + serviceObj._description + ", " + serviceObj._hashToSwaggerFile);
          }).catch(err => {
            reject(err);
          });
        }

        resolve(microservices);
      } else {
        reject(new Error("You have to connect to the IPFS and Ethereum networks first first!"));
      }
    });
    return promise;
  }

  /**
   * Gets the service metadata and ownership information for one service specified by the given hash.
   * TODO
   * @param hash The hash of the service that we want to receive
   * @returns {Promise<T>}
   */
  getService(hash: string): Promise<any> {
    let promise = new Promise((resolve, reject) => {
      if (this._ipfsService.node != null && this._ethereumService.web3 != null) {
        // TODO:
        // 1. Fetch the service metadata from IPFS for the given hash
        // (maybe get the owner from the blockchain)
        // 2. Done
        resolve("TODO");
      } else {
        reject(new Error("You have to connect to the IPFS and Ethereum networks first first!"));
      }
    });
    return promise;
  }
}
