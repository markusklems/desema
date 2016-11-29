import { Component, OnInit} from '@angular/core';

@Component({
  selector: 'app-discover-service',
  templateUrl: './discover-service.component.html',
  styleUrls: ['./discover-service.component.css']
})

export class DiscoverServiceComponent implements OnInit {

    private baseUrl: string;
    private swaggerUrl: string;
    private url: string;

  constructor() { 
      this.baseUrl = "http://petstore.swagger.io/";
      this.swaggerUrl = "http://your-url-here.com";
      this.buildUrl();
  }

  updateUrl(){
      //this.swaggerUrl = "http://localhost:8080/ipfs/QmTVYom5k8Q1XnRaWGeHmwAAcnjFcoAA6Yju6RqqsrznUG";
      this.swaggerUrl = "http://petstore.swagger.io/v2/swagger.json";
      this.buildUrl();
  }

  buildUrl(){
      this.url = this.baseUrl + "?url=" + this.swaggerUrl;
  }

  ngOnInit() {
  }

}
