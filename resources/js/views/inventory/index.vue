<template>
    <q-page padding>
         <kToolbar toolbarlabel="Mi Inventario" :showbackButton="false" :showsaveButton="false" 
        icon2="add_circle_outline"></kToolbar>     


        <q-table ref="mainTable" 
            :data="table" 
            :columns="columns" 
             row-key="id" 
            :loading="loading"
            :filter="filter"
            dense
            >
            
          <template v-slot:top="props">
              <q-input borderless dense debounce="300" v-model="filter" placeholder="Buscar">
                <template v-slot:append>
                  <q-icon name="search" ></q-icon>
                </template>
              </q-input>
             <q-space ></q-space>
             <q-btn flat dense color="primary" :disable="loading" label="Agregar Item" @click="openProductModal($refs,'create')" />
              <q-btn
                flat round dense
                :icon="props.inFullscreen ? 'fullscreen_exit' : 'fullscreen'"
                @click="props.toggleFullscreen"
                class="q-ml-md"
              ><q-tooltip>Ver en pantalla completa</q-tooltip></q-btn>
            </template>
         
           
            <q-td slot="body-cell-actions" slot-scope="props" :props="props">
                <kButton color="grey" iconname="edit" tooltiplabel="Editar" @click="editProductModal($refs, props.row)"></kButton>
                <kButton color="grey" iconname="remove_red_eye" tooltiplabel="Ver" @click="show(props)"></kButton>
                <kButton color="grey" iconname="delete" tooltiplabel="Eliminar" @click="remove(props)"></kButton>
            </q-td>
        </q-table>
          

      <productModal ref="_contact" @hide="closeProductModal"></productModal>
    </q-page>
</template>

<script>
import kButton from "../../components/tables/cButton.vue";
import kToolbar from "../../components/cToolbar.vue";
import productModal from "./modals/Product.vue";
import kNotify from "../../components/messages/Notify.js";

export default {
  middleware: "auth",
  components: {
    kButton,
    productModal,
    kToolbar
  },
  methods: {
    show(cell) {
      this.$router.push(`/${this.model}/${cell.row.public_id}`);
    },
    //Evento disparado al cerrar el modal de producto
    closeProductModal() {
      this.fetchData();
    },
    editProductModal(refs, cell) {
      this.openProductModal(refs, "edit", cell.id);
    },
    openProductModal(refs, processType, itemId) {
      refs._contact.open(processType, itemId);
    },
    setProductColumn(filter) {
      this.fetchData();
      this.columns = productColumns();
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
    remove(val, filter) {
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
            .delete("/api/inventory/" + val.row.id)
            .then(function(response) {
              if (response.data.deleted) {
                kNotify(
                  vm,
                  "Se eliminó el registro satisfactoriamente",
                  "positive"
                );
                vm.fetchData();
                vm.loading = false;
              }
            })
            .catch(function(error) {
              kNotify(
                vm,
                "No fue posible eliminar el registro seleccionado, intente de nuevo.",
                "negative"
              );
              vm.loading = false;
            });
        })
        .catch(() => {
          vm.loading = false;
        });
    }
  },
  created() {
    this.fetchData();
    this.columns = productColumns();
  },
  data() {
    return {
      model: "inventory",
      filter: "",
      loading: false,
      table: [],
      columns: [],
      path: "getInventorylist"
    };
  }
};

function productColumns() {
  return [
    {
      label: "Nombre",
      field: "name",
      name: "name",
      sortable: true,
      filter: true,
      type: "string"
    },
    {
      label: "Referencia",
      field: "reference",
      name: "reference",
      sortable: true,
      filter: true,
    },
    {
      label: "Precio",
      field: "sale_price",
      name: "sale_price",
      sortable: true,
      filter: true,
      format(value) {
        return accounting.formatMoney(value);
      }
    },
    {
      label: "Descripción",
      field: "description",
      name: "description",
      sortable: true,
      filter: true,
      type: "string",
    },
    {
      label: "Acciones",
      field: "actions",
      name: "actions",
      type: "string",
    }
  ];
}
</script>
