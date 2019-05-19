<template>
    <q-page padding>
            <kToolbar toolbarlabel="MIS CONTACTOS" :showbackButton="false" :showsaveButton="false" 
              icon2="add_circle_outline" ></kToolbar>    
  
        <q-tabs  color="grey-1" text-color="positive" swipeable>
            <q-tab default slot="title" name="tab-1" label="Clientes"  ></q-tab>
            <q-tab slot="title" name="tab-2" label="Proveedores" ></q-tab>
            <q-tab slot="title" name="tab-3" label="Vendedores"></q-tab>
            <q-tab-pane name="tab-1">
                <indexTable  kindOfContact="client" filterTo='c'></indexTable>
            </q-tab-pane>
            <q-tab-pane name="tab-2">
                <indexTable kindOfContact="provider" filterTo='p'></indexTable>
            </q-tab-pane>
            <q-tab-pane name="tab-3">
                <!--<q-btn color="secondary" flat @click="openSellerModal($refs,'create')" icon="add_circle_outline" label="NUEVO VENDEDOR">
                </q-btn>
                <q-table dense :data="table" :columns="columns" :filter="filter" :pagination.sync="paginationControl">
                    <template slot="top-left" slot-scope="props">
                    <q-search
                      hide-underline
                      color="secondary"
                      v-model="filter"
                      class="col-6"
                    />
                  </template>
                    <q-td slot="body-cell-actions" slot-scope="props" :props="props">
                        <kButton color="secondary" iconname="edit" tooltiplabel="Editar" @click="editSellerModal($refs,'edit',cell.row)"></kButton>
                        <kButton color="red" iconname="delete" tooltiplabel="Eliminar" @click="deleteRow(cell)"></kButton>
                   </q-td>
                </q-table>-->
                <indexTable  kindOfContact="seller" filterTo='s'></indexTable>
            </q-tab-pane>
            
        </q-tabs>
        
    </q-page>
</template>

<script>
import kToolbar from "../../components/cToolbar.vue";
import indexTable from "./tables/index_table.vue";

export default {
  middleware: "auth",
  components: {
    kToolbar,
    indexTable
  },
  methods: {
    show(cell) {
      this.$router.push(`/${this.model}/${cell.row.public_id}`);
    },
  },
  created() {
  },
  data() {
    return {
      model: "contact",
      columns: [],
      paginationControl: { rowsPerPage: 10 }
    };
  }
};
</script>