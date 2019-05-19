<template>
    <div class="layout-padding">

        <kToolbar toolbarlabel="MIS REMISIONES" @click="$router.push(`/${modulename}/create`)" label2="NUEVA REMISION" icon2="add_circle_outline" :showbackButton="false"></kToolbar>

        <kDatatable :path="path" :kmodule="modulename" :mwarning="warningmessage" :pathemaildata="pathEmailData" :pathToUpdateState="pathToUpdateState"></kDatatable>
    </div>
</template>

<script>
import kDatatable from "../../components/tables/Datatable-Index.vue";
import kToolbar from "../../components/Toolbar.vue";

export default {
  components: {
    kDatatable,
    kToolbar
  },
  methods: {},

  data() {
    return {
      path: "getRemisionList",
      modulename: "remision",
      warningmessage: "Estas a punto de eliminar la remision # ",
      pathEmailData: "remision_EmailToCustomer",
      pathToUpdateState: "remision_update_state"
    };
  }
};
</script>
