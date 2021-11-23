import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('turbolinks:load', function() {
  var calendarPathname = location.pathname.split('/');

  var babyId = calendarPathname[2];

  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin ],

    locale: 'ja',
    timeZone: 'Asia/Tokyo',
    events: '/babies/' + babyId + '/vaccination_lists.json',

  });

  calendar.render();
});
