<template>
        <q-page padding>

        <kToolbar toolbarlabel="GESTIÓN DE BANCOS" :showbackButton="false" 
        @click="openBankModal($refs, 'create')" label2="NUEVO BANCO" icon2="add"></kToolbar>        

          <q-table ref="mainTable" 
              :data="table" 
              :columns="columns" 
              row-key="id" 
              :loading="loading"
              :filter="filter"
              :pagination.sync="paginationControl"
              dense
              >

              <template v-slot:top="props">
                <q-input borderless dense debounce="300" v-model="filter" placeholder="Buscar">
                  <template v-slot:append>
                    <q-icon name="search" ></q-icon>
                  </template>
                </q-input>
              <q-space ></q-space>
                <q-btn
                  flat round dense
                  :icon="props.inFullscreen ? 'fullscreen_exit' : 'fullscreen'"
                  @click="props.toggleFullscreen"
                  class="q-ml-md"
                ><q-tooltip>Ver en pantalla completa</q-tooltip></q-btn>
              </template>
          
            
              <q-td slot="body-cell-actions" slot-scope="props" :props="props">
                  <cButton iconname="edit" tooltiplabel="Editar" @click="editBankModal($refs,props)"></cButton>
                  <cButton iconname="remove_red_eye" tooltiplabel="Ver" @click="show(props)"></cButton>
                  <cButton iconname="delete" tooltiplabel="Eliminar" @click="remove(props)"></cButton>
              </q-td>
          </q-table>
     
        <cBankModal ref="_bank" @hide="closedBankModal"></cBankModal>
    </q-page>
</template>

<script>
import cButton from "../../components/tables/cButton.vue";
import cBankModal from "./cBankModal.vue";

export default {
  middleware: "auth",
  components: {
    cButton,
    cBankModal,
  },
  methods: {
    show(cell) {
      this.$router.push(`/${this.model}/${cell.row.public_id}`);
    },
    closedBankModal() {
      this.fetchData();
    },
    editBankModal(ref, cell) {
      this.openBankModal(ref, "edit", cell.row.id);
    },
    openBankModal(ref, processType, bankid) {
      ref._bank.open(processType, bankid);
    },
    fetchData() {
      let vm = this;
      vm.loading = true;
      axios
        .get(`/api/${vm.path}`)
        .then(function(response) {
          vm.$set(vm, "table", response.data.records);
          vm.loading = false;
        })
        .catch(function(error) {
          vm.loading = false;
        });
    },
    remove(cell) {
      let vm = this;
      vm.loading = true;

      vm.$q
        .dialog({
          title: "Tenga Cuidado!",
          message: "Está eliminando un registro importante, desea continuar?",
          ok: "SI, Eliminar!",
          cancel: "NO, Cancelar",
          color: "secondary"
        })
        .then(() => {
          axios
            .delete(`/api/bank/${cell.row.id}`)
            .then(function(response) {
              vm.table.splice(cell.row.__index, 1);
              vm.loading = false;
              vm.$q.notify({
                message: `Se ha eliminado correctamente el registro #  + ${
                  cell.row.public_id
                }`,
                type: "positive",
                timeout: 3000
              });
            })
            .catch(function(error) {
              vm.loading = false;
              vm.$q.notify({
                message: "No fue posible eliminar el registro seleccionado",
                type: "warning",
                timeout: 3000
              });
            });
        })
        .catch(() => {
          vm.loading = false;
        });
    }
  },
  created() {
    this.fetchData();
    this.columns = bankColumns();
  },
  data() {
    return {
      model: "bank",
      table: [],
      columns: [],
      path: "getBankAccountlist",
      loading: false,
      filter: "",
      paginationControl: { rowsPerPage: 10, page: 1 }
    };
  }
};

function bankColumns() {
  return [
    {
      name: "bank_account_name",
      label: "Nombre de la cuenta",
      field: "bank_account_name",
      width: "100px",
      sortable: true,
      type: "string",
      align: "left"
    },
    {
      name: "bank_account_number",
      label: "Número de cuenta",
      field: "bank_account_number",
      sortable: true,
      width: "70px"
    },
    {
      name: "bank_account",
      label: "Descripción",
      field: "bank_account",
      sortable: true,
      format(value) {
        return value.description;
      },
      width: "70px"
    },
    {
      name: "initial_balance",
      label: "Saldo",
      field: "initial_balance",
      sortable: true,
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string",
      width: "70px"
    },
    {
      label: "Acciones",
      field: "actions",
      name: "actions",
      type: "string",
      width: "60px"
    }
  ];
}
</script>

