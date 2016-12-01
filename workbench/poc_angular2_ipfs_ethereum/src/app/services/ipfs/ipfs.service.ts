import {Injectable} from '@angular/core';
import * as concat from 'concat-stream';
declare var IpfsApi: any;

@Injectable()
export class IpfsService {

  // The connection to the IPFS daemon
  private _node: any = null;

  constructor() {
  }

  get node(): any {
    return this._node;
  }

  /**
   * Connects to a locally running IPFS daemon if not already done. If the connection to the daemon was already initialized,
   * we return the already initialized connection.
   * @returns {Promise<TResult>|Promise<U>} A promise that resolves as soon as we are connected to IPFS
   */
  public connectIpfsDeamon(multiaddr: string): Promise<any> {
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
   * Puts a string to IPFS and returns the IPFS file
   * @param val The string value, that you want to put to IPFS
   * @returns {Promise<T>} A promise, which resolves the IPFS file as soon as the string is put to IPFS
   */
  public putToIpfs(val: string): Promise<any> {
    let promise = new Promise((resolve, reject) => {
      if (this._node != null) {
        this._node.add(new Buffer(val), (err, res) => {
          if (err || !res) {
            reject(new Error("ipfs add error" + err + res));
          }
          if (res.length == 1) {
            let ipfsFile = res[0];
            resolve(ipfsFile);
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

  /**
   * Gets an IPFS file as string for a given hash
   * @param hash The hash which is the address for your file
   * @returns {Promise<T>} A promise that resolves the file as a string as soon as we got it from IPFS
   */
  public getFromIpfs(hash: string): Promise<string> {
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


  /*
   *************************************************
   * Helper
   * ***********************************************
   */
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
