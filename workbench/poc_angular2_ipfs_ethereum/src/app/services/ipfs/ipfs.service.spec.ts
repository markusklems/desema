/* tslint:disable:no-unused-variable */

import {TestBed, async, inject} from '@angular/core/testing';
import {IpfsService} from './ipfs.service';

describe('IpfsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [IpfsService]
    });
  });

  it('should connect to the locally running IPFS daemon with address /ip4/127.0.0.1/tcp/5001',
    inject([IpfsService], (service: IpfsService) => {
      service.connectIpfsDeamon("/ip4/127.0.0.1/tcp/5001").then(
        value => expect(value).toBeTruthy()
      );
    }));
});
