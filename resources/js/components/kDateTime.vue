<template>
  <q-input dense hide-bottom-space filled v-model="date" :error="errorField" :label="stackLabel">
    <template v-slot:append>
      <q-icon name="event" class="cursor-pointer">
        <q-popup-proxy ref="qDateProxy" transition-show="scale" transition-hide="scale">
          <q-date first-day-of-week="1" mask="D/M/YYYY" v-model="date" @input="handleChange"></q-date>
        </q-popup-proxy>
      </q-icon>
    </template>
  </q-input>
</template>
<script type="text/javascript">
export default {
  name: "kDateTime",
  data() {
    return {
      date: "13/06/2019" //default value
    };
  },
  props: ["inputValue", "stackLabel", "errorField"],
  watch: {
    inputValue: function(inputVal) {
      this.$set(this.$data, "date", inputVal);
    }
  },
  methods: {
    handleChange(newVal) {
      this.$refs.qDateProxy.hide();
      this.$emit("inputValue", newVal);
    }
  }
};
</script>
