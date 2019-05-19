<template>
    <q-page padding>

        <kToolbar toolbarlabel="MOVIMIENTOS DEL BANCO" :redirectTo="`/${model}`" 
        @click="openBankModal($refs, 'create')" label2="NUEVO BANCO" icon2="add"></kToolbar>

        <div class="row justify-left">
            <div class="col-12 col-md-auto">
            
                <q-card inline >
                    <q-chip square pointing="down" color="secondary" style="min-width: 300px">
                         <q-btn-dropdown
                          split
                          dense
                          push
                          flat
                          label="Acciones"
                          icon="more_vert"
                        >
                          <q-list link>
                            <q-item dense >
                              <q-item-section icon="attach_money" inverted color="secondary" />
                              <q-item-label>
                                <q-item-section label>Agregar Dinero</q-item-section>
                              </q-item-label>
                            </q-item>
                            <q-item dense >
                              <q-item-section icon="money_off" inverted color="secondary" />
                              <q-item-label>
                                <q-item-section label>Quitar Dinero</q-item-section>
                              </q-item-label>
                            </q-item>
                            <q-item dense >
                              <q-item-section icon="swap_horiz" inverted color="secondary" />
                              <q-item-label>
                                <q-item-section label>Transferir Dinero</q-item-section>
                              </q-item-label>
                            </q-item>
                          </q-list>
                        </q-btn-dropdown>

                    </q-chip>
                
                    <q-card style="height: 50px">
                        
                         <q-field
                         icon-color="secondary"
                          icon="monetization_on"
                        >
                         
                         <div class="q-subheading">{{totalAmmount}}</div>
                        </q-field> 
                    </q-card>
                    <q-card-separator />
                     <div slot="right" class="row items-center">
                      <q-icon name="place" /> 250 ft
                    </div>
                    <q-card-section style="height: 50px">    
                        <span slot="right" class="row items-center">     
                          SALDO ACUMULADO               
                        </span>
                    </q-card-section>
                </q-card>
            

                <q-card inline >
                    <q-chip square pointing="down" color="green" style="min-width: 300px"> BANCO
                        <!--<kButton  iconname="edit" tooltiplabel="Editar Banco" @click="editBankModal($refs)"></kButton>-->
                        <!--<kButton iconname="lock_outline" tooltiplabel="Desactivar Banco" @click="show(props)"></kButton>-->
                    </q-chip>
                
                    <q-card style="height: 50px">
                        <q-field
                          icon="account_balance"
                          icon-color="green"
                        >
                          <q-select clearable filter autofocus-filter filter-placeholder="" 
                          color="green"
                              v-model="bankSelected"
                              float-label="Seleccione un Banco"
                              :options="bankList"
                              @input="updateBank"
                          />     
                        </q-field>                 
                    </q-card>
                
                    <q-card-section style="height: 50px">    
                        <span slot="right" class="row items-center">                          
                        </span>
                    </q-card-section>
                </q-card>

            </div>
        </div>
        <br>
        <q-table :data="table" :columns="columns" :loading="loading">
            <!-- <template slot="col-actions" slot-scope="cell">
               <kButton color="secondary" iconname="edit" tooltiplabel="Editar" @click="editBankModal($refs, cell.row)"></kButton>
                <kButton color="secondary" iconname="remove_red_eye" tooltiplabel="Ver" @click="show(cell)"></kButton>
                <kButton color="red" iconname="delete" tooltiplabel="Eliminar" @click="remove(cell)"></kButton>
            </template>-->

          <q-tr slot="header" slot-scope="props">
            <q-th auto-width v-for="col in props.cols" :key="col.name" :props="props">
              {{ col.label }}
            </q-th>
          </q-tr>

          <q-tr slot="body" slot-scope="props" :props="props" class="cursor-pointer">
            <q-td auto-width v-for="col in props.cols" :key="col.name" :props="props">   
              <template v-if="col.name==='status_id'">
                <cStatus  :statusId="props.row.status_id" processType="bank"></cStatus>
              </template>
               <template v-else>
                {{ col.value }} 
              </template>   
            </q-td>
            </q-tr>
        </q-table>

       <cBankModal ref="_bank" @hide="closeBankModal"></cBankModal>

    </q-page>
</template>

<script>
//import kButton from "../../components/tables/cButton.vue";
import cardTotal from "../../components/cCard.vue";

import cBankModal from "./cBankModal.vue";
import cStatus from "../../components/status/cStatus.vue";

import kToolbar from "../../components/cToolbar.vue";

export default {
  middleware: "auth",
  components: {
    cBankModal,
    kToolbar,
    cStatus,
    cardTotal
  },
  methods: {
    updateBank(val) {
      this.$router.push(`/${this.model}/${val}`);
      this.fetchData(val);
    },
    show(cell) {
      this.$router.push(`/${this.model}/${cell.row.public_id}`);
    },
    closeBankModal() {
      this.fetchData(this.$route.params.id);
    },
    editBankModal(refs) {
      this.openBankModal(refs, "edit", this.$route.params.id);
    },
    openBankModal(refs, processType, bankid) {
      refs._bank.open(processType, bankid);
    },
    fetchData(bankID) {
      let vm = this;
      vm.loading = true;
      axios
        .get(`/api/${vm.path}/${bankID}`)
        .then(function(response) {
          vm.$set(vm, "table", response.data.history);
          vm.$set(vm, "bankList", response.data.bankaccountlist);
          //vm.bankSelected = vm.$route.params.id;
          vm.loading = false;
        })
        .catch(function(error) {
          vm.loading = false;
        });
    },
    remove(val) {
      var vm = this;
      vm.loading = true;
      axios
        .delete("/api/bank/" + val.row.id)
        .then(function(response) {
          if (response.data.deleted) {
            Toast.create.positive("Se eliminó el registro satisfactoriamente");
            vm.fetchData(vm.$route.params.id);
            vm.loading = false;
          }
        })
        .catch(function(error) {
          Toast.create.negative(
            "No fue posible eliminar el registro seleccionado, intente de nuevo."
          );
          vm.loading = false;
        });
    }
  },
  computed: {
    totalAmmount() {
      return accounting.formatMoney(this.amountTotal);
    }
  },
  created() {
    let vm = this;
    vm.fetchData(vm.$route.params.id);
    vm.columns = bankColumns();
    vm.bankSelected = vm.$route.params.id;
  },
  data() {
    return {
      amountTotal: 0,
      bankSelected: null,
      bankList: [],
      model: "bank",
      table: [],
      columns: {},
      path: "getbank_transaction_history"
    };
  }
};

function bankColumns() {
  return [
    {
      label: "Fecha",
      name: "date",
      field: "date",
      width: "70px",
      sort: true,
      type: "string"
    },
    {
      label: "Beneficiario",
      name: "contact_name",
      field: "contact_name",
      width: "70px",
      sort: true,
      filter: true
    },
    {
      label: "Categoría",
      name: "detail",
      field: "detail",
      width: "90px",
      filter: true,
      sort: true
    },
    {
      label: "Estado",
      name: "status_id",
      field: "status_id",
      width: "50px",
      filter: true,
      sort: true
    },
    {
      label: "Salida",
      name: "total_outcome",
      field: "total_outcome",
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string",
      width: "70px"
    },
    {
      label: "Entrada",
      name: "total_income",
      field: "total_income",
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string",
      width: "70px"
    },
    {
      label: "Acciones",
      name: "actions",
      field: "actions",
      type: "string",
      width: "60px"
    }
  ];
}
</script>

