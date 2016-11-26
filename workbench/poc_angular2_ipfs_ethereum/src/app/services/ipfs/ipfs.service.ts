import {Injectable} from '@angular/core';
import {Microservice} from "../../entities/microservice";
import * as concat from 'concat-stream';
declare var IpfsApi: any;

@Injectable()
export class IpfsService {

  private _node: any = null;

  constructor() {
  }

  get node(): any {
    return this._node;
  }

  /**
   * Connects to a locally running IPFS daemon if not already done. If the connection to the deamon was already initialized,
   * we return the already initialized connection.
   * @returns {Promise<TResult>|Promise<U>}
   */
  connectIpfsDeamon(multiaddr: string): Promise<any> {
    return new Promise((resolve, reject) => {
      if (this.node == null) {
        // Create the IPFS node instance
        // for simplicity, we create a new repo everytime the node
        // is created, because you can't init already existing repos
        const node = new IpfsApi(multiaddr);

        node.id()
          .then((id) => {
            console.log('My IPFS node id is: ', JSON.stringify(id));
            this._node = node;
            resolve(node);
          })
          .catch((err) => {
            console.log('Fail: ', err);
            reject(err);
          });
      } else {
        resolve(this.node);
      }
    });
  }


  /**
   * Puts the service metadata file to the IPFS deamon
   * @param microservice
   * @returns {Promise<T>}
   */
  putServiceMetadataToIpfs(microservice: Microservice): Promise<any> {

    let promise = new Promise((resolve, reject) => {
      if (this._node != null) {
        let jsonString = JSON.stringify(microservice);

        this._node.add(new Buffer(jsonString), (err, res) => {
          if (err || !res) {
            reject(new Error("ipfs add error" + err + res));
          }
          if (res.length == 1) {
            resolve(res[0]);
            console.log('successfully stored', res[0].hash);
          } else {
            reject(new Error("Something went wrong"));
          }
        });
      } else {
        reject(new Error("You have to connect to an IPFS deamon first!"));
      }
    });
    return promise;
  }

  getServiceMetadataFromIpfs(hash: string): Promise<Microservice> {
    let promise = new Promise((resolve, reject) => {
      // buffer: true results in the returned result being a buffer rather than a stream
      this.node.cat(hash, function (err, res) {
        if (err || !res) {
          console.error('ipfs cat error', err, res);
          reject(err);
        }
        res.pipe(concat(data => {
          let string = IpfsService.Utf8ArrayToStr(data);
          resolve(string);
        }))
      })
    });
    return promise;
  }


  private static Utf8ArrayToStr(array): string {
    let out, i, len, c;
    let char2, char3;
    out = "";
    len = array.length;
    i = 0;
    while (i < len) {
      c = array[i++];
      switch (c >> 4) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
          // 0xxxxxxx
          out += String.fromCharCode(c);
          break;
        case 12:
        case 13:
          // 110x xxxx   10xx xxxx
          char2 = array[i++];
          out += String.fromCharCode(((c & 0x1F) << 6) | (char2 & 0x3F));
          break;
        case 14:
          // 1110 xxxx  10xx xxxx  10xx xxxx
          char2 = array[i++];
          char3 = array[i++];
          out += String.fromCharCode(((c & 0x0F) << 12) |
            ((char2 & 0x3F) << 6) |
            ((char3 & 0x3F) << 0));
          break;
      }
    }
    return out;
  }
}
