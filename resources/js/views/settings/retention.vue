<template>
    <q-page padding>

        <q-btn color="green" icon="add_circle_outline" label="NUEVA RETENCIÓN" small @click="openModal($refs)">          
        </q-btn>
        <br>
        <br>
        <q-table dense :data="table" :columns="columns">
            <q-td slot="body-cell-actions" slot-scope="props" :props="props">          
                <kButton color="secondary" iconname="edit" tooltiplabel="Editar" @click="editModal($refs, props.row)"></kButton>
                <kButton color="red" iconname="delete" tooltiplabel="Eliminar" @click="remove(props)"></kButton>
            </q-td>            
        </q-table>
        <br>
        <q-inner-loading :visible="isProcessing">
                <q-spinner-mat size="50px" color="teal-4" />Espere por favor...
            </q-inner-loading>
        <retentionModal ref="_retention" @hide="closeModal"></retentionModal>
    </q-page>
</template>

<script>
import kButton from "../../components/tables/cButton.vue";
import store from "../../store";
import retentionModal from "./modals/mRetention.vue";
import kNotify from "../../components/messages/Notify.js";

export default {
  components: {
    kButton,
    retentionModal
  },
  created() {
    this.fetchData();
  },
  data() {
    return {
      isProcessing: false,
      path: `getRetentionList`,
      modulename: "retention",     
      table: [],
      columns: [
        {
          label: "Nombre",
          field: "name",
          name: "name",
          width: "100px",
          sort: true,
          type: "string"
        },
        {
          label: "Porcentaje",
          field: "value",
          name: "value",
          width: "50px"
        },
        {
          label: "Tipo",
          field: "retention_type",
          name: "retention_type",
          format(value) {
            return value.name;
          },
          width: "70px"
        },
        {
          label: "Descripción",
          field: "description",
          name: "description",
          width: "80px"
        },
        {
          label: "Acciones",
          field: "actions",
          name: "actions",
          type: "string",
          width: "50px"
        }
      ],
    };
  },
  computed: {},
  methods: {
    remove(val) {
      var vm = this;
      vm.isProcessing = true;
      axios
        .delete("/api/retention/" + val.row.id)
        .then(function(response) {
          if (response.data.deleted) {
            kNotify(
              vm,
              "Se eliminó el registro satisfactoriamente",
              "positive"
            );
            vm.fetchData();
            vm.isProcessing = false;
          }
        })
        .catch(function(error) {
          kNotify(
            vm,
            "No fue posible eliminar el registro seleccionado, intente de nuevo.",
            "positive"
          );
          vm.isProcessing = false;
        });
    },
    openModal(refs, processType, id) {
      refs._retention.open(processType, id);
    },
    closeModal() {
      this.fetchData();
    },

    editModal(refs, cell) {
      this.openModal(refs, "edit", cell.id);
    },
    fetchData() {
      var vm = this;
      vm.isProcessing = true;
      axios
        .get(`/api/${vm.path}`)
        .then(function(response) {
          vm.$set(vm.$data, "table", response.data.form);
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
        });
    }
  },
};
</script>
