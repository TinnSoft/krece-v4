<template>
     <div>
            
            <q-chip tag  dense v-if="statusId ===1  && processType!='purchase-order'" small color="secondary">Abierta</q-chip>
            <q-chip tag dense  v-else-if="statusId === 2" small color="orange">Anulada</q-chip>
            <q-chip dense v-else-if="statusId === 3 && processType!='purchase-order'" small color="green">Cerrada</q-chip>
            <q-chip dense v-else-if="statusId === 6 && processType!='purchase-order'" small color="green">Cerrada</q-chip>
            <q-chip dense v-else-if="statusId === 1 && processType==='purchase-order'" small color="secondary">Borrador</q-chip>
            <q-chip dense v-else-if="statusId === 6 && processType==='purchase-order'" small color="green">Facturada</q-chip>         
     </div>
</template>
<script type="text/javascript">
export default {
  props: ["statusId","processType"],
};
</script>