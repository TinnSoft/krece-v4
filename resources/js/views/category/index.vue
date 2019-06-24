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

export default {
   middleware: "auth",
  components: {
    treetable,
  },
  data() {
    return {
      path: "getCategoryAll"
    };
  }
};
</script>
