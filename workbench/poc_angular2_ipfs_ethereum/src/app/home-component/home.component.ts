import {Component, OnInit} from '@angular/core';
import {IpfsService} from "../services/ipfs/ipfs.service";
import {EthereumService} from "../services/ethereum/ethereum.service";


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  private ipfsNode: any = null;
  private agentVersion: string = null;
  private protocolVersion: string = null;
  private daemonId: string = null;
  private ipfsDaemonStarted: boolean = false;
  private web3Version: string = null;
  private ethereumClientVersion: string = null;
  private ethereumNetworkProtocolVersion: string = null;
  private ethereumVersion:string = null;
  private ethereumProvider: string = "http://localhost:8545";


  constructor(private _ipfsService: IpfsService, private _ethereumService: EthereumService) {
  }

  ngOnInit() {
    this._ipfsService.initIpfsDeamon().then(node => {
      this.ipfsDaemonStarted = true;
      this.ipfsNode = node;
      node.version().then(version => {
        this.agentVersion = "js-ipfs/" + version.version;
      });
      node.id().then(id => {
        this.daemonId = id.id;
        this.protocolVersion = id.protocolVersion;
      });
    });
  }


  private onEthereumConnectClick() {
    this._ethereumService.initWeb3(this.ethereumProvider).then(web3Ethereum => {
      this.web3Version = web3Ethereum.version.api;
      this.ethereumClientVersion = web3Ethereum.version.node;
      this.ethereumNetworkProtocolVersion =web3Ethereum.version.network;
      this.ethereumVersion = web3Ethereum.version.ethereum;
    });
  }
}
