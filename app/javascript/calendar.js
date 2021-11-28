import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('turbolinks:load', function() {
  const calendarPathname = location.pathname.split('/');

  const babyId = calendarPathname[2];

  const calendarEl = document.getElementById('calendar');

  const calendar = new Calendar(calendarEl, {
    dayCellContent: function(e) {
      e.dayNumberText = e.dayNumberText.replace('日', '');
    },
    plugins: [ dayGridPlugin, interactionPlugin ],

    locale: 'ja',
    timeZone: 'Asia/Tokyo',
    events: '/babies/' + babyId + '/vaccination_lists.json',

  });

  calendar.render();
});
