<template>
    <q-table
        :data="qdata"
        dense
        :columns="columns"
        row-key="name"   
        table-header-class="bg-light-blue-1"
        flat     
        bordered
      >  
        <template v-slot:bottom>
           <cTotals :subtotal="subtotal" :discounts="discounts" :taxes="taxes" :total="total" :isTaxArray="true"></cTotals>
        </template>
  
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
