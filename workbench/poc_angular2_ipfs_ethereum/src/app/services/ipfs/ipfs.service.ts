import {Injectable} from '@angular/core';
import {Microservice} from "../../entities/microservice";
import * as concat from 'concat-stream';
declare var Ipfs: any;
declare var Multiaddr: any;


@Injectable()
export class IpfsService {

  private _node: any = null;

  constructor() {
  }

  get node(): any {
    return this._node;
  }

  /**
   * Puts the service metadata file to the IPFS deamon
   * @param microservice
   * @returns {Promise<T>}
   */
  putServiceMetadataToIpfs(microservice: Microservice): Promise<any> {
    var promise = new Promise((resolve, reject) => {
      if (this._node != null) {
        var jsonString = JSON.stringify(microservice);
        console.log(this._node);
        this._node.files.add(new Buffer(jsonString), (err, res) => {
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
        reject(new Error("You have to create an IPFS deamon first!"));
      }
    });
    return promise;
  }

  getServiceMetadataFromIpfs(hash: string): Promise<Microservice> {
    var promise = new Promise((resolve, reject) => {
      // buffer: true results in the returned result being a buffer rather than a stream
      this.node.files.cat(hash, function (err, res) {
        if (err || !res) {
          console.error('ipfs cat error', err, res);
          reject(err);
        }
        res.pipe(concat(data => {
          var string = IpfsService.Utf8ArrayToStr(data);
          resolve(string);
        }))
      })
    });
    return promise;
  }

  /**
   * Creates an IPFS deamon if not already done. If the deamon was already initialized,
   * we return the already initialized deamon.
   * @returns {Promise<TResult>|Promise<U>}
   */
  initIpfsDeamon(): Promise<any> {
    var promise = new Promise((resolve, reject) => {
      if (this.node == null) {
        // Create the IPFS node instance
        // for simplicity, we create a new repo everytime the node
        // is created, because you can't init already existing repos
        const repoPath = '' + Math.random();
        const node = new Ipfs(repoPath);

        // We need to init our repo, in this case the repo was empty
        // We are picking 2048 bits for the RSA key that will be our PeerId
        node.init({emptyRepo: true, bits: 2048}, err => {
          if (err) {
            reject(err);
          }
          node.load(err => {
            if (err) {
              reject(err);
            }
            node.goOnline(err => {
              if (err) {
                reject(err);
              }
              this._node = node;
              console.log('IPFS node is ready');
              resolve(node);
            });
          });
        });
      } else {
        resolve(this.node);
      }
    });
    return promise;
  }


  private static Utf8ArrayToStr(array):string {
    var out, i, len, c;
    var char2, char3;
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
