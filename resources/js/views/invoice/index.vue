<template>
    <q-page padding >
        <kToolbar toolbarlabel="FACTURAS DE VENTA" :showbackButton="false"  @click="$router.push(`/${modulename}/create`)"
        label2="NUEVA FACTURA" icon2="add"></kToolbar>

        <cDatatable :path="path" :kmodule="modulename" :mwarning="warningmessage"
        :pathemaildata="pathEmailData" :pathToUpdateState="pathToUpdateState"></cDatatable>
    </q-page>
</template>

<script>
import cDatatable from "../../components/tables/Datatable-Index.vue";

export default {
  middleware: "auth",
  components: {
    cDatatable
  },
  data() {
    return {
      path: "getInvoiceList",
      modulename: "invoice",
      warningmessage: "Estas a punto de eliminar la Factura de venta # ",
      pathEmailData: "getTemplateEmailToCustomerInvoice",
      pathToUpdateState: "invoice_update_state"
    };
  }
};
</script>
