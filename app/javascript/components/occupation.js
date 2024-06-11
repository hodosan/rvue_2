import {getCsrfToken} from "./getCsrfToken"

export const Occupation = {
  inject: [
    // object
    'selectedRoom', 
    'occupation', 
    // parent methods
    'onFormSubmited', 
  ],
  template: `
  <form class="contents" @submit="setOccupation">

    <div class="my-5">
      <label for="calender_room_id">部屋</label>
      <p>{{selectedRoom.name}}</p>
    </div>

    <div class="my-5">
      <label for="calender_begin_time">開始時刻</label>
      <input class="frm_ln" type="datetime-local" v-model="occupation.time_s" id="calender_begin_time" disabled />
    </div>

    <div class="my-5">
      <label for="calender_close_time">終了時刻</label>
      <input class="frm_ln" type="datetime-local" v-model="occupation.time_e" id="calender_close_time" disabled />
    </div>

    <div class="inline">
      <input  type="submit" value="登録する" class="frm_btn bg-blue-600" />
    </div>
  </form>
  `,
  methods: {
    setOccupation(e) {
      e.preventDefault();

      fetch('/occupations.json',{
        method:  'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-TOKEN': getCsrfToken()
        },
        body: JSON.stringify({
          room_id:      this.occupation.room_id,
          user_id:      this.occupation.user_id,
          day:          this.occupation.day,
          time_s:       this.occupation.time_s,
          time_e:       this.occupation.time_e,
          reservation:  this.occupation.reservation,
          confirmed:    this.occupation.confirmed,
        })
      })
      .then(response => response.json())
      .then(() => {
        this.occupation.frmFlag = false;
        this.onFormSubmited();
      })
    },
  }
};