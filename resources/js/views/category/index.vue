<template>
  <q-page padding>
        <kToolbar toolbarlabel="CONFIGURACIÓN DE CATEGORIAS" :showbackButton="false" :showsaveButton="false"></kToolbar>
      <treetable
        :route="path"
      />      

  </q-page>
</template>

<script>
import treetable from "../../components/treeTable/TreeTable.vue";
import kToolbar from "../../components/cToolbar.vue";

export default {
   middleware: "auth",
  components: {
    treetable,
    kToolbar
  },
  data() {
    return {
      path: "getCategoryAll"
    };
  }
};
</script>
