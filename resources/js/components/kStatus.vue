<template>
     <div>            
            <q-chip tag  dense v-if="statusId ===1  && processType!='purchase-order'"  color="primary" text-color="white" small >Abierta</q-chip>
            <q-chip tag dense  v-else-if="statusId === 2" small >Anulada</q-chip>
            <q-chip dense v-else-if="statusId === 3 && processType!='purchase-order'"  color="primary" text-color="white" small >Cerrada</q-chip>
            <q-chip dense v-else-if="statusId === 6 && processType!='purchase-order'"  color="primary" text-color="white" small >Cerrada</q-chip>
            <q-chip dense v-else-if="statusId === 1 && processType==='purchase-order'"  color="primary" text-color="white" small >Borrador</q-chip>
            <q-chip dense v-else-if="statusId === 6 && processType==='purchase-order'"  color="primary" text-color="white" small>Facturada</q-chip>         
     </div>
</template>
<script type="text/javascript">
export default {
  name:'kStatus',
  props: ["statusId","processType"],
};
</script>