import { Component, OnInit } from '@angular/core';
import { Http } from '@angular/http';
// import { EventSearchPipe } from './event-search-pipe'

@Component({
  selector: 'app-event-list',
  templateUrl: './event-list.component.html',
  styleUrls: ['./event-list.component.css']
})

export class EventListComponent implements OnInit {
  events: Array<any>;

  constructor(private http: Http) { }

  ngOnInit() {
    this.load();
  }

  load() {
    this.http.get('/api/admin/events.json')
      .subscribe(response => this.events = response.json().events);
  }

  delete(id: number) {
    if(confirm('Confirm deletion of event ' + id + '?')) {
      this.http.delete('/api/admin/events/' + id + '.json')
        .subscribe(
          data => alert('The event ' + id + ' was deleted.'),
          err => console.log(err),
          () => this.load()
        );
    }
  }

}
