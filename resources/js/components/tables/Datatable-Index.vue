<template>
     <div class="q-pa-md">

        <q-table      
            dense
            ref="mainTable" 
            :data="table" 
            :columns="columns" 
            :visible-columns="visibleColumns" row-key="id" 
            :loading="loading"
            :pagination.sync="paginationControl"
            :filter="filter"
            >

            <template v-slot:top="props">
              <q-input borderless dense debounce="300" v-model="filter" placeholder="Buscar">
                <template v-slot:append>
                  <q-icon name="search" ></q-icon>
                </template>
              </q-input>
             <q-space ></q-space>
              <q-select
                v-model="visibleColumns"
                multiple
                borderless
                dense
                options-dense
                :display-value="$q.lang.table.columns"
                emit-value
                map-options
                :options="columns"
                option-value="name"
                style="min-width: 150px"
              ></q-select>
      
              <q-btn
                flat round dense
                :icon="props.inFullscreen ? 'fullscreen_exit' : 'fullscreen'"
                @click="props.toggleFullscreen"
                class="q-ml-md"
              ><q-tooltip>Ver en pantalla completa</q-tooltip></q-btn>
            </template>
     
          <q-tr slot="body" slot-scope="props" :props="props" class="cursor-pointer">
            <q-td auto-width v-for="col in props.cols" :key="col.name" :props="props">             
              <template v-if="col.name==='status_id'">
                <rowStatus  :statusId="props.row.status_id" :processType="kmodule"></rowStatus>
              </template>
              <template v-else-if="col.name==='public_id'">
                <u @click="show(props)">{{props.row.public_id}}</u>
              </template>
              <template v-else-if="col.name==='actions'">
                  <template v-if="hasLockedBtn===true">
                    <cToggle @blur="lockUnlock(props.row, $refs)" :id="props.row.status_id"></cToggle>
                  </template>
                    
                  <q-btn-dropdown
                      icon="view_list"
                      size="sm"
                      color="primary"
                      flat
                      rounded
                    >
                      <q-list dense link>                  
                      <cItem color="secondary" iconname="remove_red_eye" tooltiplabel="Ver" @click="show(props)"></cItem>                    
                        <cItem color="tertiary" :statusID="props.row.status_id" iconname="edit" tooltiplabel="Editar" @click="edit(props)"></cItem>
                        <cItem color="red" :statusID="props.row.status_id" iconname="delete" tooltiplabel="Eliminar" @click="deleteRow(props)"></cItem>
                        
                        <q-separator spaced ></q-separator>
                        <q-item-label header>Otros</q-item-label>
                      
                        <cItem color="secondary" v-if="showEmailBtn===true" iconname="email" tooltiplabel="Enviar por email" @click="email($refs, props)"></cItem>
                        <cItem color="secondary" iconname="print" tooltiplabel="Imprimir" @click="pdf(props)"></cItem>
                        <cItem color="secondary" v-if="showPaymentBtn===true" :statusID="props.row.status_id" iconname="attach_money" tooltiplabel="Agregar pago" @click="edit(props)"></cItem>

                      </q-list>                   
                </q-btn-dropdown>
                
              </template>
              <template v-else>
                {{ col.value }} 
              </template>              
              
            </q-td>
          </q-tr>
        </q-table>
        <cSendEmail ref="_sendEmail"></cSendEmail>
     
    </div>
</template>
<script type="text/javascript">
import rowStatus from "../../components/status/cStatus.vue";
import cToggle from "../tables/cToggle.vue";
import cItem from "../tables/cItem.vue";
import cSendEmail from "../../components/modals/SendEmailForm.vue";
import columnsIndex from "../../components/tables/columns/colIndex";

export default {
  components: { rowStatus, cToggle, cItem, cSendEmail },
  props: [
    "path",
    "kmodule",
    "mwarning",
    "pathemaildata",
    "model",
    "pathToUpdateState"
  ],
  methods: {
    lockUnlock(cell, ref) {
      if (cell.status_id === 2) {
        this.updateStatus(cell.public_id, 1, ref);
      } else {
        this.updateStatus(cell.public_id, 2, ref);
      }
    },
    email(refs, cell) {
      refs._sendEmail.open(
        cell.row.public_id,
        this.pathemaildata,
        this.kmodule
      );
    },
    show(cell) {
      this.$router.push(`/${this.kmodule}/${cell.row.public_id}`);
    },
    edit(cell) {
      this.$router.push(`/${this.kmodule}/${cell.row.public_id}/edit`);
    },
    pdf(cell) {
      window.open(
        "/api/" + this.kmodule + "/" + cell.row.public_id + "/pdf",
        "_blank"
      );
    },
    deleteRow(cell) {
      let vm = this;
      vm.loading = true;
      vm.$q.dialog({
          title: "Tenga Cuidado!",
          message: vm.mwarning + cell.row.public_id + ", desea continuar?",
          ok: "SI, Eliminar!",
          cancel: "NO, Cancelar",
          color: "secondary"
        })
        .then(() => {
          axios.delete(`api/${this.kmodule}/${cell.row.public_id}`)
            .then(function(response) {
              vm.table.splice(cell.row.__index, 1);
              vm.loading = false;
              vm.$q.notify({
                message: `Se ha eliminado correctamente el registro #  + ${cell.row.public_id}`,
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
    },
    fetchData() {
      var vm = this;
      vm.$set(vm, "returnData", true);
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
      vm.$set(vm, "returnData", false);
    },

    updateStatus(itemID, status, ref) {
      let vm = this;
      var xstatus = { status_id: status };
      vm.loading = true;
      axios
        .put(`/api/${vm.pathToUpdateState}/${itemID}`, xstatus)
        .then(function(response) {
          if (response.data.updated) {
            vm.fetchData();
          }
          vm.loading = false;
        })
        .catch(function(error) {
          vm.loading = false;
        });
    }
  },
  data() {
    return {
      returnData: true,
      hasLockedBtn: false,
      hasStatus: false,
      table: [],
      columns: {},
      showEmailBtn: true,
      showPaymentBtn: false,
      filter: "",
      visibleColumns: [
        "public_id",
        "contact_id",
        "contact_name",
        "due_date",
        "pending_to_pay",
        "status_id",
        "total",
        "actions",
        'contact',
        'IsCategory',
        'bank_account_name',
        'date'
      ],
      separator: "horizontal",
      paginationControl: { rowsPerPage: 10, page: 1 },
      loading: false
    };
  },
  created() {
    this.columns = columnsIndex(this.kmodule);

    if (this.kmodule == "remision") {
      this.hasLockedBtn = true;
      this.hasStatus = true;
    } else if (this.kmodule == "invoice") {
      this.hasLockedBtn = true;
      this.hasStatus = true;
      this.showPaymentBtn = true;
    } else if (this.kmodule == "bill") {
      this.hasLockedBtn = true;
      this.hasStatus = true;
      this.showEmailBtn = false;
      this.showPaymentBtn = true;
    } else if (this.kmodule == "debit-note") {
      this.showEmailBtn = false;
    } else if (this.kmodule == "payment-in") {
      this.hasLockedBtn = true;
      this.hasStatus = true;
    } else if (this.kmodule == "payment-out") {
      this.hasLockedBtn = true;
      this.hasStatus = true;
    }

    this.fetchData();
  }
};
</script>
