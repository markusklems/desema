import {Component, OnInit} from '@angular/core';
// unfortunately no typings available for web3 and ipfs
import * as web3 from 'web3';
import {IpfsService} from "../services/ipfs/ipfs.service";
import {Microservice} from "../entities/microservice";
declare var Ipfs: any;

@Component({
  selector: 'app-service-registration-component',
  templateUrl: './service-registration.component.html',
  styleUrls: ['./service-registration.component.css']
})
export class ServiceRegistrationComponent implements OnInit {

  private ipfsHash = "";
  private ipfsContent = "";
  private name: string;
  private description: string;

  constructor(private _ipfsService: IpfsService) {
  }

  ngOnInit() {
  }

  private addToIpfs() {
    var microservice: Microservice = new Microservice(this.name, this.description);
    this._ipfsService.putServiceMetadataToIpfs(microservice).then(file => this.storeSuccess(file));
  }

  private storeSuccess(file: any) {
    this.ipfsHash = file.hash;
    this._ipfsService.getServiceMetadataFromIpfs(this.ipfsHash).then(res => this.displayData(res));

  }

  private displayData(res) {
    this.ipfsContent = res;
  }
}
