import { Injectable } from '@angular/core';
import Web3 from "web3";


@Injectable()
export class EthereumService {


  private _web3: any = null;

  constructor() { }

  get web3(): any {
    return this._web3;
  }

  /**
   * Initializes the web3 connection to the given ethereum provider.
   * @returns {Promise<TResult>|Promise<U>}
   */
  initWeb3(provider:string): Promise<any> {
    var promise = new Promise((resolve, reject) => {
      if (this._web3 == null) {
        var httpProvider = new (<any>Web3).providers.HttpProvider(provider);
        this._web3 = new Web3(httpProvider);
        resolve(this._web3);
      } else {
        resolve(this._web3);
      }
    });
    return promise;
  }
}
