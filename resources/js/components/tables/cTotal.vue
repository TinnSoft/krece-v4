<template>
    <div>
        <q-td>
            <br>
            <strong style="color: green;">SUB-TOTAL:</strong>
            <br>
            <strong style="color: gray;">DESCUENTOS:</strong>               
            <template v-if="isTaxArray==false">
                <br><strong style="color: gray;">IMPUESTOS:</strong>
            </template>
            <template v-if="isTaxArray==true" >
                <strong v-for="tax in taxes" :key="tax.name">
                    <br><strong style="color: gray;">{{tax.name}}:</strong>
                </strong>
            </template>                
            <br><strong style="color: green;">TOTAL:</strong>
        </q-td> 
        <q-td>
            <br>
            <strong style="color: green;">{{currencyFormat(subtotal)}}</strong>
            <br>
            <strong style="color: gray;">{{currencyFormat(discounts)}}</strong>
            <template v-if="isTaxArray==false">
                <br><strong style="color: gray;">{{currencyFormat(taxes)}}</strong>
            </template>
            <template v-if="isTaxArray==true">
                <strong v-for="tax in taxes" :key="tax.name">
                    <br>
                    <strong style="color: gray;">{{currencyFormat(tax.total)}}
                    </strong>
                </strong>                    
            </template>
            <br>
            <strong style="color: green;">{{currencyFormat(total)}}
            </strong>
        </q-td> 
    </div>
</template>

<script>
export default {
  props: {
    subtotal: {},
    discounts: {},
    taxes: {},
    total: {},
    isTaxArray: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    currencyFormat: function(val) {
      return accounting.formatMoney(val);
    }
  }
};
</script>