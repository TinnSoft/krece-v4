<template>
    <q-page padding >
        <kToolbar toolbarlabel="PAGOS RECIBIDOS" :showbackButton="false"  @click="$router.push(`/${modulename}/create`)"
        label2="NUEVO INGRESO" icon2="add"></kToolbar>     

        <kDatatable :path="path" :kmodule="modulename" :mwarning="warningmessage"
        :pathemaildata="pathEmailData" :pathToUpdateState="pathToUpdateState"></kDatatable>
    </q-page>
</template>

<script>
import kDatatable from "../../components/tables/Datatable-Index.vue";
import kToolbar from "../../components/cToolbar.vue";

export default {
  middleware: "auth",
  components: {
    kDatatable,
    kToolbar
  },
  data() {
    return {
      path: "getPaymentList",
      modulename: "payment-in",
      warningmessage: "Estas a punto de eliminar el pago # ",
      pathEmailData: "getTemplateEmailToCustomerPaymentIn",
      pathToUpdateState: "payment_in_update_state"
    };
  }
};
</script>
