<template>
  <q-select
    v-model="model"
    v-bind="$attrs"
    v-on="$listeners"
    ref="select"
    @filter="filterFunc"
    :options="opt"
  >
    <!-- :options="this.selfFilter ? this.options : this.$attrs.options" -->
    <!-- @filter="(v, f, c) => { this.selfFilter ? filterFn(v, f, c) : $emit('filter', v, f, c) }" -->
    <template v-slot:no-option>
      <q-item>
        <q-item-section class="text-grey">
          Sin Resultados
        </q-item-section>
      </q-item>
    </template>
  </q-select>
</template>
<script>

export default {
  inheritAttrs: false,
  props: {
    selfFilter: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      model: '',
      options: this.$attrs.options
    }
  },
  methods: {
    // use this default filter function
    filterFn (val, update) {
      if (!this.selfFilter) {
        return
      }

      update(() => {
        const needle = val.toLowerCase()
        this.options = this.$attrs.options.filter(v => v.label.toLowerCase().includes(needle))
      })
    },
    filterFunc (v, u, a) {
      this.selfFilter ? this.filterFn(v, u) : this.$emit('filter', v, u, a)
    }
  },
  computed: {
    opt () {
      return this.selfFilter ? this.options : this.$attrs.options
    }
  }
}
</script>

<style>
</style>
