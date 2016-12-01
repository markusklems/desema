/* tslint:disable:no-unused-variable */

import { TestBed, async, inject } from '@angular/core/testing';
import { ContractProviderService } from './contract-provider.service';

describe('ContractProviderService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [ContractProviderService]
    });
  });

  it('should ...', inject([ContractProviderService], (service: ContractProviderService) => {
    expect(service).toBeTruthy();
  }));
});
