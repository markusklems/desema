import {Injectable} from '@angular/core';

@Injectable()
export class ContractProviderService {

  private static _REGISTRY_CONTRACT_ADDRESS = "0x9ace9c9ab7069d90097e9cb5a4252a0aa4c00682";
  private static _REGISTRY_CONTRACT_ABI = [{
      constant: true,
      inputs: [],
      name: "ServicesCount",
      outputs: [{...}],
      payable: false,
      type: "function"
  }, {
      constant: false,
      inputs: [{...}],
      name: "Register",
      outputs: [],
      payable: false,
      type: "function"
  }, {
      constant: false,
      inputs: [],
      name: "Kill",
      outputs: [],
      payable: false,
      type: "function"
  }, {
      constant: true,
      inputs: [{...}],
      name: "services",
      outputs: [{...}],
      payable: false,
      type: "function"
  }, {
      constant: false,
      inputs: [{...}, {...}],
      name: "ChangeOwnership",
      outputs: [],
      payable: false,
      type: "function"
  }, {
      constant: true,
      inputs: [{...}],
      name: "owners",
      outputs: [{...}],
      payable: false,
      type: "function"
  }, {
      inputs: [],
      payable: true,
      type: "constructor"
  }, {
      anonymous: false,
      inputs: [{...}],
      name: "NewService",
      type: "event"
  }]

