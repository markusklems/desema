import {Component, OnInit} from '@angular/core';
import * as $ from 'jquery';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {


  constructor() {
  }


  ngOnInit(): void {
    this.initViewNavigation();
  }

  private initViewNavigation():void {
    $(document).ready(function(){
      $('[data-toggle="offcanvas"]').click(function(){
        $("#navigation").toggleClass("hidden-xs");
      });
    });
  }
}
