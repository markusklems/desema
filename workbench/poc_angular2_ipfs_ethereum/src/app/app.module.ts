import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {FormsModule} from '@angular/forms';
import {HttpModule} from '@angular/http';

import {AppComponent} from './app.component';
import {ServiceRegistrationComponent} from './service-registration-component/service-registration.component';
import {Routes, RouterModule} from "@angular/router";
import {HomeComponent} from './home-component/home.component';
import {IpfsService} from "./services/ipfs/ipfs.service";
import {DiscoverServiceComponent} from './discover-service-component/discover-service.component';
import {EthereumService} from "./services/ethereum/ethereum.service";


const appRoutes: Routes = [
  {path: 'register', component: ServiceRegistrationComponent},
  {path: 'discover', component: DiscoverServiceComponent},
  {path: 'home', component: HomeComponent},
  {path: '', redirectTo: '/home', pathMatch: 'full'},
];

@NgModule({
  declarations: [
    AppComponent,
    ServiceRegistrationComponent,
    HomeComponent,
    DiscoverServiceComponent,
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    RouterModule.forRoot(appRoutes)
  ],
  providers: [IpfsService, EthereumService],
  bootstrap: [AppComponent]
})
export class AppModule {
}
