/* tslint:disable:no-unused-variable */

import { TestBed, async, inject } from '@angular/core/testing';
import { RepositoryServicesService } from './service-repository.service';

describe('RepositoryServicesService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [RepositoryServicesService]
    });
  });

  it('should ...', inject([RepositoryServicesService], (service: RepositoryServicesService) => {
    expect(service).toBeTruthy();
  }));
});
