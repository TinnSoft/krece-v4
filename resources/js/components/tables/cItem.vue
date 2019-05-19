<template>
     <q-item dense v-close-overlay @click.native="handleClick" :disabled="isChecked">
           <q-item-section>
               <q-icon inverted :name="iconname" size="24px" :color="color"/>
               </q-item-section>
               <q-item-label>
               <q-item-section label>{{tooltiplabel}}</q-item-section>
           </q-item-label>
      </q-item>
</template>

<script>
export default {
  props: ["color", "statusID", "iconname", "tooltiplabel"],
  data() {
    return {
      styleButton: {
        border: 0,
        padding: 0
      }
    };
  },
  methods: {
    handleClick(newVal) {
      if (this.isChecked===false){
      this.$emit("click", newVal);
      }
    }
  },

  computed: {
    isChecked() {
      if (this.statusID === 2) {
        return true;
      }
      return false;
    }
  }
};
</script>
