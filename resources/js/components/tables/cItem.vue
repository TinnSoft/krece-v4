<template>
     <q-item dense clickable v-close-popup @click.native="handleClick" :disabled="isChecked">
           <q-item-section avatar>
            <q-icon color="primary" :name="iconname" size="24px" ></q-icon>
          </q-item-section>
          <q-item-section>{{tooltiplabel}}</q-item-section>
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
