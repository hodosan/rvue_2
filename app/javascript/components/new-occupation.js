import * as Vue from "vue"
import {SelectTime}    from "components/select-time"
import {Occupation}    from "components/occupation"
import {getCsrfToken}  from "components/getCsrfToken"

const NewOccupation = {
  components: {
    'selectTime': SelectTime,
    'occupation': Occupation,
  },
  props: [
    'tday', 
    'mns',
    'mnscale',
    'current'
  ],
  template: `
    <div class="flex justify-between items-center mb-5">
      <div class="text-2xl">日付 {{tday}}</div>
      <button v-show="!showSelectFlag && !occupation.frmFlag" 
                    @click="selectAgain" 
                    class="frm_btn bg-blue-300">部屋再選択</button>
    </div>

    <div v-show="showAllFlag">
      <div v-for="room of rooms">
        <label for="room.id">{{room.name}}：</label>
        <input type="radio" :id="room.id" v-model="selected" @change="onchange" :value="room.id" />
        <div class="mt-2 flex">
          <template v-for="item of reservedList[room.id.toString()]">
            <span v-if="isReserved(item.uid) === 2" 
                    :name="item.mn" 
                    class="border-none py-3 flex-1 bg-green-600"></span>
            <span v-else-if="isReserved(item.uid) === 1" 
                    :value="item.oid"
                    :name="item.mn"
                    @click.self="deleteOwn($event)" 
                    class="cursor-pointer border-none py-3 flex-1 bg-red-200"></span>
            <span v-else 
                    :name="item.mn" 
                    class="border-none py-3 flex-1 bg-green-200"></span>
          </template>
        </div> 
        <div class="mb-2 flex">
          <template v-for="(mn, i) of mns">
            <span   :name="mn" 
                    class="border-l py-1 flex-1 text-gray-400 text-xs">
                    {{mn.slice(3,5) === '00' ? mn.slice(0, 2) : '' }}</span>
          </template>
        </div> 
      </div>
    </div>
    <div v-show="!showAllFlag">
      <selectTime v-if="selectFlag"></selectTime>
      <occupation v-if="occupation.frmFlag"></occupation>
  </div>
  `,
  data(){
    return {
      rooms:                [],
      selected:             0,
      showSelectFlag:       true,
      showAllFlag:          true,
      selectFlag:           false,
      selectedRoom:         {},
      reservedList:         {},
      selectedList:    {
              sid:          '',
              mary:         [],
      },
      occupation: {
              room_id:       '',
              user_id:       '',
              day:           '',
              time_s:        '',
              time_e:        '',
              reservation:   false,
              confirmed:     false,
              frmFlag:       false,
      }
    }
  },
  provide() {
    return {
      // from props
      tday:           this.tday,
      mns:            this.mns,
      mnscale:        this.mnscale,
      // object
      selectedRoom:   this.selectedRoom,
      selectedList:   this.selectedList,
      occupation:     this.occupation,
      // methods
      getOccupations: this.getOccupations,
      isReserved:     this.isReserved,
      onFormSubmited: this.onFormSubmited,
   }
  },
  created: function(){
    this.getRooms();
    this.getOccupations();
  },
  methods: {
    getRooms() {
      fetch('/rooms.json')
        .then(response => response.json())
        .then(data => {
          this.rooms = data;
        })
    },
    getOccupations() {
      fetch(`/occupations/of_tday.json?day=${this.tday}`)
        .then(response => response.json())
        .then(data => {
          this.reservedList = data.reserved_list;
        });
    },
    selectAgain() {
      this.selected       = 0;
      this.showAllFlag    = true;
      this.showSelectFlag = true;
    },
    onchange() {
      const result = this.rooms.find(({id}) => id === this.selected);
      let sid      = result.id.toString();
      this.selectedRoom.id       = result.id;
      this.selectedRoom.name     = result.name;
      this.selectedRoom.profile  = result.profile;
      this.selectedList['sid']   = sid;
      this.selectedList['mary']  = this.reservedList[sid];
      this.showAllFlag           = false;
      this.showSelectFlag        = false;
      this.selectFlag            = true;
    },
    isReserved(uid) {
      let flg = 0;
      if (uid === 0) {
        flg = 0;
      } else {
        if (uid === this.current) {
          flg = 1;
        } else {
          flg = 2;
        }
      }
      return flg;
    },
    onFormSubmited(){
      this.getOccupations();
      this.showAllFlag    = true;
      this.selected       = 0;
      this.selectFlag     = false;
      this.showSelectFlag = true;
    },
    deleteOwn(ev) {
      const oid = ev.target.getAttribute('value')
      const res = window.confirm("削除してよろしいですか？");
      if (!res) {
        return
      };

      fetch(`/occupations/${oid}.json`,{
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-TOKEN': getCsrfToken()
        }
      })
      .then(() => {
        this.onFormSubmited();
      })
    },

  }

};

const app = Vue.createApp({
  components: {
    'new-occupation': NewOccupation,
    'selectTime':   SelectTime,
    'occupation':   Occupation,
  },
});

app.mount('#new-occupation');