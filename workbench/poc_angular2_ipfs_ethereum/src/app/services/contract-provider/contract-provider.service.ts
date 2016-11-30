import {Injectable} from '@angular/core';

@Injectable()
export class ContractProviderService {

  private static _REGISTRY_CONTRACT_ADDRESS = "0x708a3351be2c3e78292c74a6124f618c411ca406";
  private static _REGISTRY_CONTRACT_ABI = [{
    "constant": true,
    "inputs": [],
    "name": "ServicesCount",
    "outputs": [{"name": "", "type": "uint256"}],
    "payable": false,
    "type": "function"
  }, {
    "constant": false,
    "inputs": [{"name": "serviceHash", "type": "bytes32"}],
    "name": "Register",
    "outputs": [{"name": "", "type": "bool"}],
    "payable": false,
    "type": "function"
  }, {
    "constant": false,
    "inputs": [],
    "name": "Kill",
    "outputs": [],
    "payable": false,
    "type": "function"
  }, {
    "constant": true,
    "inputs": [{"name": "", "type": "uint256"}],
    "name": "services",
    "outputs": [{"name": "", "type": "bytes32"}],
    "payable": false,
    "type": "function"
  }, {
    "constant": false,
    "inputs": [{"name": "add", "type": "address"}, {"name": "serviceHash", "type": "bytes32"}],
    "name": "ChangeOwnership",
    "outputs": [{"name": "", "type": "bool"}],
    "payable": false,
    "type": "function"
  }, {
    "constant": true,
    "inputs": [{"name": "", "type": "bytes32"}],
    "name": "owners",
    "outputs": [{"name": "", "type": "address"}],
    "payable": false,
    "type": "function"
  }, {"inputs": [], "payable": false, "type": "constructor"}, {
    "anonymous": false,
    "inputs": [{"indexed": true, "name": "_services", "type": "bytes32"}],
    "name": "NewService",
    "type": "event"
  }];

  static get REGISTRY_CONTRACT_ADDRESS(): string {
    return this._REGISTRY_CONTRACT_ADDRESS;
  }

  static get REGISTRY_CONTRACT_ABI(): any{
    return this._REGISTRY_CONTRACT_ABI;
  }
}
