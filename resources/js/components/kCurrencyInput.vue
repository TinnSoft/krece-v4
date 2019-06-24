<template>
  <q-input
    hide-bottom-space
    v-model="localVal"
    prefix="$"
    ref="priceField"
    @input="formatCurrency"
    @blur="val => { formatCurrency(val.target.value, 'blur')}"
    v-bind="$attrs"
  >
    <template
      v-for="(_, slot) of $scopedSlots"
      v-slot:[slot]="scope"
    >
      <slot
        :name="slot"
        v-bind="scope"
      />
    </template>
  </q-input>
</template>

<script>
/* eslint-disable */
export default {
  name: 'kCurrencyInput',
  inheritAttrs: false,
  props: {
    value: {}
  },
  data() {
    return {
      localVal: ''
    }
  },
  methods: {
    formatCurrency(val, blur) {
      if (val === null) return
      const input = this.$refs.priceField
      let inputVal = val
      // don't validate empty input
      // get inner child reference
      let inner = input.$children.length > 0 ? input.$children[0].$refs.input : input.$refs.input
      // original length
      let originalLen = inputVal.length
      // initial caret position
      let caretPos = inner.selectionStart
      // check for decimal
      if (inputVal.indexOf('.') >= 0) {
        // get position of first decimal
        // this prevents multiple decimals from
        // being entered
        let decimalPos = inputVal.indexOf('.')
        // split number by decimal point
        let leftSide = inputVal.substring(0, decimalPos)
        let rightSide = inputVal.substring(decimalPos)
        // add commas to left side of number
        leftSide = this.formatNumber(leftSide)
        // validate right side
        rightSide = this.formatNumber(rightSide)
        // On blur make sure 2 numbers after decimal
        if (blur === 'blur') {
          rightSide += '00'
        }
        // Limit decimal to only 2 digits
        rightSide = rightSide.substring(0, 2)
        // join number by .
        inputVal = leftSide + '.' + rightSide
      } else {
        // no decimal entered
        // add commas to number
        // remove all non-digits
        inputVal = this.formatNumber(inputVal)
        // final formatting
        if (blur === 'blur' && inputVal.length > 0) {
          inputVal += '.00'
        }
      }
      // send updated string to input
      // put caret back in the right position
      let updatedLen = inputVal.length
      caretPos = updatedLen - originalLen + caretPos
      // set updated caret pos
      this.$nextTick(() => { inner.setSelectionRange(caretPos, caretPos) })
      // set component display value
      this.localVal = inputVal
      // set the v-model value back to number format else empty string
      this.$emit('input', parseFloat(this.localVal.replace(/[^\d.]/g, '')) || inputVal)
    },
    formatNumber(n) {
      // format number 1000000 to 1,234,567
      return n.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',')
    }
  }
}
</script>
