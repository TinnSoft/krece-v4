<template>
    <q-page padding>
         <kToolbar toolbarlabel="Mi Inventario" :showbackButton="false" :showsaveButton="false" 
        icon2="add_circle_outline"></kToolbar>     

                <q-table 
                    :data="table" 
                    :columns="columns" 
                    :filter="filter"
                    dense
                    :loading="loading"
                    color="secondary">
                  
                    <div slot="top-right" slot-scope="props" class="column">
                      <q-btn size="md"  flat label="Nuevo Item" dense color="light" icon="add" @click="openProductModal($refs,'create')" class="q-mr-sm" >
                        <q-tooltip >
                          <div>Agregar <strong>nuevo producto o servicio</strong></div>
                        </q-tooltip>
                      </q-btn>                     
                    </div>

                    <template slot="top-left" slot-scope="props">
                      <q-search
                        hide-underline
                        v-model="filter"
                        class="col-6"
                      />
                    </template>  
  
                    <q-td slot="body-cell-actions" slot-scope="props" :props="props">
                        <kButton color="secondary" iconname="edit" tooltiplabel="Editar" @click="editProductModal($refs, props.row)"></kButton>
                        <kButton color="secondary" iconname="remove_red_eye" tooltiplabel="Ver" @click="show(props)"></kButton>
                        <kButton color="red" iconname="delete" tooltiplabel="Eliminar" @click="remove(props)"></kButton>                  
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
      width: "100px",
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
      width: "70px"
    },
    {
      label: "Precio",
      field: "sale_price",
      name: "sale_price",
      width: "70px",
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
      width: "80px"
    },
    {
      label: "Acciones",
      field: "actions",
      name: "actions",
      type: "string",
      width: "70px"
    }
  ];
}
</script>
