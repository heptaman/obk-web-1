import {
  Component,
  OnInit,
  Output,
  EventEmitter } from '@angular/core';
import {Http} from "@angular/http";
import { Router } from '@angular/router';
declare var $: any;

@Component({
  selector: 'app-event-new',
  templateUrl: './event-new.component.html',
  styleUrls: ['./event-new.component.css']
})
export class EventNewComponent implements OnInit {
  // @Output() createEvent = new EventEmitter();

  newEvent = {
    id: null,
    title: "",
    description: "",
    start: "",
    finish: "",
    min_volunteers: 0,
    max_volunteers: 0
  };

  constructor(private http: Http, private router: Router) { }

  ngOnInit() {
  }

  ngAfterViewInit() {
    $('.datepicker').datepicker({ format: 'dd/mm/yyyy' });
  }

  createEvent() {
    const { title, description, start, finish, min_volunteers, max_volunteers } = this.newEvent;

    if (title && description && start && finish && min_volunteers && max_volunteers) {
      this.http.post("/api/admin/events", this.newEvent)
        //.map(res => res.json())
        .subscribe(
          data => console.log(data),
          err => console.log(err),
          () => this.router.navigate(['/events'])
        );
      // this.reset();
    } else {
      alert("Fill the form");
    }
  }

  reset() {
    this.newEvent = {
      id: null,
      title: "",
      description: "",
      start: "",
      finish: "",
      min_volunteers: 0,
      max_volunteers: 0
    };
  }

}
