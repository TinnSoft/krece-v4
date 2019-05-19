<template>
 
    <q-table
        dense
      :data="qdata"
      :columns="columns"
      row-key="name"
      color="secondary"
    >
     <q-tr slot="bottom-row" slot-scope="props" style="text-align: right" >  
        <td class colspan="100%" align="right">    
            <cTotals :subtotal="subtotal" :discounts="discounts" :taxes="taxes" :total="total" :isTaxArray="true"></cTotals>
        </td>
      </q-tr> 
    </q-table>
    
</template>
<script type='text/javascript'>
import cTotals from '../../components/tables/cTotal.vue';

import columnsShow from '../../components/tables/columns/colShow';

export default {
  props: {
    qdata: {},
    module: "",
    subtotal: {},
    discounts: {},
    taxes: {},
    total: {},
    isTaxArray: {
      type: Boolean,
      default: false
    }
  },
  components: {
    cTotals
  },
  data() {
    return {
      estimate: {},
      columns: []
    };
  },
  created() {
    this.columns = columnsShow(this.module);
  },
  methods: {
    currencyFormat: function(val) {
      return accounting.formatMoney(val);
    }
  }
};


</script>
