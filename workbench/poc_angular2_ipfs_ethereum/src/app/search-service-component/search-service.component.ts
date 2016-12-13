import { Component, OnInit} from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-search-service',
  templateUrl: 'search-service.component.html',
  styleUrls: ['search-service.component.css']
})

export class SearchServiceComponent implements OnInit {

    private baseUrl: string;
    private swaggerHash: string;
    private url: string;
    private sub: any;

  constructor(private route: ActivatedRoute) {
      this.baseUrl = "http://petstore.swagger.io/";
      this.swaggerHash = "http://your-url-here.com";
      this.buildUrl();
  }

  updateUrl(){
      //this.swaggerHash = "http://localhost:8080/ipfs/QmTVYom5k8Q1XnRaWGeHmwAAcnjFcoAA6Yju6RqqsrznUG";
      this.swaggerHash = "http://petstore.swagger.io/v2/swagger.json";
      this.buildUrl();
  }

  buildUrl(){
      this.url = this.baseUrl + "?url=" + this.swaggerHash;
  }

  ngOnInit() {
    this.sub = this.route.params.subscribe(params => {
      console.log(params);
      this.swaggerHash = "https://ipfs.io/ipfs/" + params["hash"]; // (+) converts string 'id' to a number
      this.buildUrl();
    });
  }

}
