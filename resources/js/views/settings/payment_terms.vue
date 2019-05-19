<template>
    <q-page padding>
        <q-btn color="green" icon="add_circle_outline" label="NUEVO TERMINO DE PAGO" small @click="openModal($refs)">            
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
        <termsModal ref="_terms" @hide="closeModal"></termsModal>
    </q-page>
</template>

<script>
import kButton from "../../components/tables/cButton.vue";
import store from "../../store";
import termsModal from "./modals/mPaymentTerms.vue";
import kNotify from "../../components/messages/Notify.js";

export default {
  components: {
    kButton,
    termsModal
  },
  created() {
    this.fetchData();
  },
  data() {
    return {
      isProcessing: false,
      path: `getPaymentTermsList`,
      modulename: "payterms",
      table: [],
      columns: [
        {
          label: "Nombre",
          name: "name",
          field: "name",
          width: "100px",
          sort: true,
          type: "string"
        },
        {
          label: "Días",
          field: "days",
          name: "days",
          width: "50px"
        },
        {
          label: "Acciones",
          field: "actions",
          name: "actions",
          type: "string",
          width: "70px"
        }
      ]
    };
  },
  computed: {},
  methods: {
    remove(val) {
      let vm = this;

      vm.$q
        .dialog({
          title: "Tenga Cuidado!",
          message: "Está eliminando un registro importante, desea continuar?",
          ok: "SI, Eliminar!",
          cancel: "NO, Cancelar",
          color: "secondary"
        })
        .then(() => {
          vm.isProcessing = true;

          axios
            .delete("/api/payterms/" + val.row.id)
            .then(function(response) {
              if (response.data.deleted) {
                kNotify(
                  vm,
                  "El registro se eliminó satisfactoriamente",
                  "positive"
                );
                vm.fetchData();
                vm.isProcessing = false;
              }
            })
            .catch(function(error) {
              kNotify(vm, "No se ha podido eliminar el registro", "negative");
              vm.isProcessing = false;
            });
        })
        .catch(() => {
          vm.isProcessing = false;
        });
    },
    openModal(refs, processType, id) {
      refs._terms.open(processType, id);
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
  }
};
</script>
