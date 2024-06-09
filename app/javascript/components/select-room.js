import * as Vue from "vue"


const SelectRoom = {
  template: `
    <form v-if="selected === 0">
      <div v-for="room in rooms">
        <label :for="room.id">{{room.name}}：</label>
        <input type="radio" :id="room.id" v-model="selected" @change="onchange" :value="room.id" />
      </div>
    </form>
    <div  v-if="selected > 0">選択したRoomID:{{selected}}　ルームprofile:{{room.profile}}</div><br />
    <button @click="selectAgain" class="frm_btn bg-red-300">Select again</button>

  `,
  data(){
    return {
      rooms: [],
      selected:      0,
      room: {}
    }
  },
  created: function(){
    this.getRooms();
  },
  methods: {
    getRooms() {
      fetch('/rooms.json')
        .then(response => response.json())
        .then(data => {
          this.rooms = data,
          console.log(data)
        })
    },
    onchange() {
      console.log(`selected ${this.selected}`);
      const room = this.rooms.find(({id}) => id === this.selected);
      this.room.id      = room.id;
      this.room.name    = room.name;
      this.room.profile = room.profile;
      console.log(`roob object ${JSON.stringify(this.room)}`);
    },
    selectAgain() {
      this.selected = 0;
    },
  }

};

const app = Vue.createApp({
  components: {
    'select-room': SelectRoom,
  },
});


app.mount('#select-room');