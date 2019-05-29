<template>
    <!--<q-date :color="color" monday-first  @change="handleChange"
        :value="value" :clear-label="clearLabel" :ok-label="okLabel" 
        :cancel-label="cancelLabel" :month-names="monthNames" 
        :day-names="dayNames" :float-label="stackLabel"
        :default-selection="value">
    </q-date>
    -->

    <q-input dense filled v-model="date" mask="date" :rules="['date']" @change="handleChange">
        <template v-slot:append>
          <q-icon name="event" class="cursor-pointer">
            <q-popup-proxy ref="qDateProxy" transition-show="scale" transition-hide="scale">
              <q-date monday-first v-model="date" @input="() => $refs.qDateProxy.hide()" ></q-date>
            </q-popup-proxy>
          </q-icon>
        </template>
      </q-input>

</template>
<script type="text/javascript">


export default {
    data() {
        return {           
            date: '2019/05/01'
        }
    },
    props: ['value', 'stackLabel'],
    methods: {
        handleChange(newVal) {
            this.$emit('input', newVal)
        }
    }
}
</script>
