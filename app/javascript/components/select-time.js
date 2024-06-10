export const SelectTime = {
  inject: [
    // from parent props
    'tday',
    'mns', 
    'mnscale',
    // object
    'selectedRoom',
    'selectedList',
    'occupation',
    // parent methods
    'getOccupations',
    'isReserved',
  ],
  template: `
    <div>選択したRoom : {{selectedRoom.name}} </div>
    <div class="mt-2 flex">
      <template v-for="item of selectedList.mary">
        <span v-if="isReserved(item.uid) === 2" 
                :name="item.mn" 
                class="border-none py-3 flex-1 bg-green-600"></span>
        <span v-else-if="isReserved(item.uid) === 1" 
                :name="item.mn" 
                class="border-none py-3 flex-1 bg-red-200"></span>
        <span v-else 
                :ref="item.mn"  
                @mouseenter.self="menter($event)" 
                @mouseleave.self="mleave($event)"
                @click.self="onClick(item.mn, $event)"
                class="border-none py-3 flex-1 bg-green-200" ></span>
      </template>
    </div>
    <div class="mb-2 flex">
      <template v-for="(mn, i) of mns">
        <span   :name="mn" 
                class="border-l py-1 flex-1 text-gray-400 text-xs">
                {{mn.slice(3,5) === '00' ? mn.slice(0, 2) : '' }}</span>
      </template>
    </div> 
  <div v-if="buttonFlg">
    <button @click="selectAgain" class="frm_btn bg-red-300 mt-10">時刻選択やり直し</button>
  </div>
  `,
  data(){
    return {
      buttonFlg:          false,
      start:              -1,
      end:                -1,
    }
  },
  methods: {
    menter(ev) {
      if (ev.target.classList.contains('bg-green-200')){
        ev.target.classList.remove('bg-green-200');
        ev.target.classList.add('bg-green-400');
      }
    },
    mleave(ev) {
      if (ev.target.classList.contains('bg-green-400')){
        ev.target.classList.remove('bg-green-400');
        ev.target.classList.add('bg-green-200');
      }
    },
    onClick(mn, ev) {
      const point = this.mnscale[mn];
      if (this.start >= 0 && this.end > this.start) {
        return;
      }
      if (this.start === -1) {
        const range = this.availableMnlist(point);
        this.possibleRange = range;
        this.start = this.possibleRange.startValue;

        ev.target.classList.add('bg-blue-400');
        ev.target.classList.remove('bg-green-400');
        this.occupation.room_id = this.selectedRoom.id;
        this.occupation.day     = this.tday;
        this.occupation.time_s  = this.tday + 'T' + mn;
        return;
      } else {
        if (point < this.possibleRange.startValue || point > this.possibleRange.endValue) {
          return
        } else {
          this.end = point;
          this.buttonFlg = true;
          this.occupation.frmFlag = true;
          this.occupation.time_e  = this.tday + 'T' + mn;
          this.checkBetweenMn(this.start, this.end, this.buttonFlg);
        }
      }
    },
    availableMnlist(point) {
      const arylist     = Object.values(this.mnscale);
      const occupied    = this.selectedList.mary.map((obj, inx) => {
        if ( obj.oid !== 0 ) {
          return inx;
        }
      } );
      const available   = arylist.filter( val => occupied.indexOf(val) === -1)
      let startValue  = point;
      let endValue    = point;
      let incremented = point;
      while (available.includes(incremented)) {
        endValue      = incremented;
        incremented   = incremented + 1;
      }
      const res = {
        startValue, 
        endValue,
      };

      return res;
    },
    checkBetweenMn(start, end, touch) {
      let paintStart = start;
      if (touch) {
        paintStart = start + 1;
      } 
      for (let inx = paintStart; inx <= end; inx++) {
        let mn = this.getKeyByValue(this.mnscale, inx);
        if (touch) {
          this.$refs[mn][0].classList.add('bg-blue-400');
          if (this.$refs[mn][0].classList.contains('bg-green-200')){
            this.$refs[mn][0].classList.remove('bg-green-200');
          }
          if (this.$refs[mn][0].classList.contains('bg-green-400')){
            this.$refs[mn][0].classList.remove('bg-green-400');
          }
        } else {
          this.$refs[mn][0].classList.remove('bg-blue-400');
          this.$refs[mn][0].classList.add('bg-green-200');
        } 
      }        
    },
    getKeyByValue(object, value) {
      return Object.keys(object).find(key => object[key] === value);
    },
    selectAgain() {
      this.occupation.frmFlag = false;
      this.buttonFlg = false;
      this.checkBetweenMn(this.start, this.end, this.buttonFlg);
      this.start = -1;
      this.end   = -1;
    },
  }
};