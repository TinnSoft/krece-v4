<template>
  <div>
      <q-table dense :data="dtable" :columns="columns" :filter="filter" :pagination.sync="paginationControl" :loading="isProcessing">
          <template slot="top-left" slot-scope="props">
              <q-search
                  hide-underline
                  color="secondary"
                  v-model="filter"
                  class="col-6"
              />
          </template>
              <div slot="top-right" slot-scope="props" class="column">
                  <q-btn round color="light"  outline @click="openModal($refs, 'create',props)"
                      icon="person_add">
                  </q-btn>
              </div>
              <q-td slot="body-cell-actions" slot-scope="props" :props="props">
                  <kButton color="secondary" iconname="edit" tooltiplabel="Editar" @click="openModal($refs,'edit', props.row)"></kButton>
                  <!--<template v-if="kindOfContact!='seller'">
                    <kButton color="secondary" iconname="remove_red_eye" tooltiplabel="Ver" @click="show(props)"></kButton>
                  </template>-->
                  <kButton color="red" iconname="delete" tooltiplabel="Eliminar" @click="remove(props)"></kButton>
              </q-td>              
      </q-table>  
     <!-- <q-inner-loading :visible="isProcessing">
          <q-spinner-mat size="50px" color="teal-4" />Espere por favor...
      </q-inner-loading>-->
      <contactModal ref="_contact" @hide="closeContactModal"></contactModal>
      <sellerModal ref="_seller" @hide="closeSellerModal"></sellerModal>  
    </div>
</template>

<script>
import kButton from "../../../components/tables/cButton.vue";
import columnsIndex from "./index_cols.js";
import contactModal from "../modals/Contact.vue";
import sellerModal from "../modals/Seller.vue";
import kNotify from "../../../components/messages/Notify.js";

export default {
  props: {
    kindOfContact: {
      type: String,
      default: "client"
    },
    filterTo: {
      type: String,
      default: "c"
    }
  },
  components: {
    kButton,
    contactModal,
    sellerModal
  },
  created() {
    this.fetchData();
    this.columns = columnsIndex(this.kindOfContact);
  },
  data() {
    return {
      dtable: [],
      filter: "",
      path: "getContactlist",
      columns: [],
      paginationControl: { rowsPerPage: 10 }
    };
  },
  methods: {
    fetchData() {
      let vm = this;
      if (vm.filterTo) {
        vm.isProcessing = true;
        axios
          .get(`/api/${vm.path}/${vm.filterTo}`)
          .then(function(response) {
            vm.$set(vm, "dtable", response.data.records);
            vm.isProcessing = false;
          })
          .catch(function(error) {
            vm.isProcessing = false;
          });
      }
    },
    closeContactModal() {
      this.fetchData(this.customerType);
    },
    closeSellerModal() {
      this.fetchData("s");
    },
    openModal(refs, processType, cell) {
      if (this.kindOfContact != "seller") {
        refs._contact.open(this.kindOfContact, processType, cell.id);
      } else {
        refs._seller.open(processType, cell.id);
      }
    },
    remove(val) {
      let vm = this;
      vm.isProcessing = true;

      var path = "/api/contact/";
      if (vm.kindOfContact === "seller") {
        path = "/api/seller/";
      }
      axios
        .delete(path + val.row.id)
        .then(function(response) {
          if (response.data.deleted) {
            kNotify(
              vm,
              "El registro se eliminó satisfactoriamente",
              "positive"
            );
            vm.fetchData(vm.filterTo);
            vm.isProcessing = false;
          }
        })
        .catch(function(error) {
          kNotify(
            vm,
            "Ooops! No fue posible actualizar el registro actual, intente de nuevo.",
            "negative"
          );
          vm.isProcessing = false;
        });
    }
  }
};
</script>