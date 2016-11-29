import { Component, OnInit } from '@angular/core';
import {ServiceRepositoryService} from "../services/service-repository/service-repository.service";
import {Microservice} from "../services/entities/microservice";

@Component({
  selector: 'app-service-catalogue',
  templateUrl: './service-catalogue.component.html',
  styleUrls: ['./service-catalogue.component.css']
})
export class ServiceCatalogueComponent implements OnInit {

  private services:Microservice[];

  constructor(private _serviceRepositoryService:ServiceRepositoryService) { }

  ngOnInit() {
    this._serviceRepositoryService.getAllServices().then(services => this.requestAllServicesSuccess(services)).catch(err => this.requestAllServicesError(err));
  }

  private requestAllServicesSuccess(services:Microservice[]) {
    this.services = services;
  }

  private requestAllServicesError(err:any) {
    alert(err);
    console.log(err);
  }

}
