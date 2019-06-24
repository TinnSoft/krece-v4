<template>
     <q-page padding>
        <kToolbar toolbarlabel="DETALLE DE FACTURA DE VENTA" :redirectTo="`/${model}`" @click="$router.push(`/${model}/create`)"
            :showDropdown="true" label2="NUEVA FACTURA" icon2="add"></kToolbar>  
      
      <q-card>       
        <kToolbarCustom :label="labelval"></kToolbarCustom>
        <q-card-section>
        
        <div class="doc-container">
            <div class="row ">
                <div class="col-sm-5">
                        <q-input dense  v-model="contactname" readonly label="Cliente" stack-label></q-input>
                        <q-input dense  v-model="seller" readonly label="Vendedor" stack-label></q-input>
                        <q-input  autogrow dense v-model="data.observations" type="textarea" stack-label readonly label="Observaciones"></q-input>
                        <q-input dense  v-model="listprice" readonly label="Lista de precios" stack-label></q-input>
                        <q-input dense  v-model="data.currency_code" readonly label="Moneda" stack-label></q-input>
                   
                </div>
                <div class="col-sm-1">
                </div>
                <div class="col-sm-5">
                        <q-input  dense v-model="data.date" readonly label="Fecha de creación" stack-label></q-input>
                        <q-input  dense v-model="data.due_date" readonly label="Fecha de vencimiento" stack-label></q-input>
                        <q-input  autogrow dense v-model="data.notes" type="textarea" readonly label="Notas" stack-label></q-input>

                        
                        <q-field dense readonly>
                          <template v-slot:control>
                            <kStatus :statusId="data.status_id"></kStatus>
                          </template>
                        </q-field>              

                        <br>
                        <q-btn flat class="within-iframe-hide" color="positive" @click="LoadFiles($refs)">
                            <q-icon size="1rem" name="attach_file"></q-icon>
                            <small style='text-decoration: underline'>Gestionar Documentos</small>
                        </q-btn>
                </div>
            </div>

        </div>
        <br>
        
        <q-tabs
          v-model="tabDefault"
          dense
          class="bg-grey-1 text-grey"
          active-color="primary"
          indicator-color="primary"
          align="left"
          narrow-indicator   
          no-caps
          inline-label
        >
          <q-tab name="detail" icon="details" label="DETALLE" ></q-tab>
          <q-tab name="payment" icon="attach_money" label="PAGOS ASOCIADOS" ></q-tab>
        </q-tabs>
        <q-tab-panels v-model="tabDefault">
            <q-tab-panel name="detail">
                <cTableShow 
                    :qdata="table" 
                    :subtotal="data.sub_total" 
                    :discounts="data.total_discounts" 
                    :taxes.sync="totalTaxes" 
                    :total="data.total"
                    :isTaxArray="true"
                ></cTableShow>         
            </q-tab-panel>
            <q-tab-panel name="payment" >
                 <cPaymentAssociated :qdata="payments"></cPaymentAssociated> 
            </q-tab-panel>
          </q-tab-panels>
        
         <kSendEmailForm ref="_sendEmail"></kSendEmailForm>
      
        <kAttachFiles ref="_attachfile"></kAttachFiles>

  <!--
       
       

        <q-page-sticky position="top-left" :offset="[16, 16]">
        <q-btn rounded   color="secondary">
          <q-icon name="menu" />

         
          <q-popover ref="popover">
            <q-list dense link class="scroll" style="min-width: 200px">
                <q-item   @click.native="pdf()">
                    <q-item-section inverted color="grey-6" left icon="print" />                    
                    <q-item-label>
                        <q-item-section label>Imprimir</q-item-section>
                    </q-item-label>
                </q-item>
                <q-item  @click.native="edit()">
                    <q-item-section inverted left icon="edit" color="grey-6" />
                    <q-item-label>
                        <q-item-section label>Editar</q-item-section>
                    </q-item-label>
                </q-item>
                <q-item  @click.native="clone()" >
                    <q-item-section inverted icon="content_copy" left color="grey-6" />
                    <q-item-label>
                        <q-item-section label>Clonar</q-item-section>
                    </q-item-label>
                </q-item>
                <q-item link >
                    <q-item-section inverted :icon="data.status_id === 1 ? 'lock_outline' : 'lock_open'"  color="grey-6" />
                    <q-item-label :label="data.status_id === 1 ? 'Anular' : 'Habilitar'" />
                    <q-item-section right >
                        <cToggle @blur="lockUnlock(data)" :id="data.status_id"></cToggle>
                    </q-item-section>  
                </q-item>
                <q-item  @click.native="email($refs)" >
                    <q-item-section inverted icon="mail" left color="grey-6" />
                    <q-item-label>
                        <q-item-section label>Enviar por Email</q-item-section>
                    </q-item-label>
                </q-item>
                <q-separator inset />
                <q-item>
                    <q-item-section icon="attach_money" inverted color="secondary" />
                    <q-item-label>
                        <q-item-section label>Agregar pago</q-item-section>
                        <q-item-section sublabel>Relaciona tus pagos recibidos</q-item-section>
                    </q-item-label>
                </q-item>  
            </q-list>
          </q-popover>
        </q-btn>
      </q-page-sticky>
 -->
        </q-card-section>
      </q-card>
     </q-page>
    
</template>

<script>
import cTableShow from "../../components/tables/Datatable-Show.vue";
import cPaymentAssociated from "./payment_associated.vue";
import cToggle from "../../components/tables/cToggle.vue";

export default {
  middleware: "auth",
  components: {
    cTableShow,
    cPaymentAssociated,
    cToggle
  },
  created() {
    this.fetchData();
  },
  data() {
    return {
      tabDefault: 'detail',
      state: "ABIERTA",
      model: "invoice",
      path: `invoice/${this.$route.params.id}`,
      labelval:`Factura # ${this.$route.params.id}`,
      data: {},
      listprice: "",
      contactname: "",
      seller: "",
      totalTaxes: 0,
      table: [],
      pathEmailData: "getTemplateEmailToCustomerInvoice",
      payments: [],
      pathToUpdateState:'invoice_update_state'
    };
  },
  watch: {
    $route: "fetchData"
  },
  computed: {
    public_id() {
      return this.$route.params.id;
    }
  },
  methods: {
    LoadFiles(refs) {
      refs._attachfile.open(this.$route.params.id, this.model);
    },
    email(refs) {
      refs._sendEmail.open(
        this.$route.params.id,
        this.pathEmailData,
        this.model
      );
    },
    edit() {
      this.$router.push(`/${this.path}/edit`);
    },
    clone() {
      this.$router.push(`/${this.path}/clone`);
    },
    pdf() {
      window.open(`/api/${this.model}/${this.public_id} /pdf`, "_blank");
    },
    fetchData() {
      var vm = this;

      axios
        .get(`/api/${vm.path}`)
        .then(function(response) {
          vm.$set(vm, "data", response.data.model);
          vm.$set(vm, "totalTaxes", response.data.totalTaxes);

          if (vm.data.list_price) {
            vm.$set(vm, "listprice", vm.data.list_price.name);
          }
          if (vm.data.contact) {
            vm.$set(vm, "contactname", vm.data.contact.name);
          }
          if (vm.data.seller) {
            vm.$set(vm, "seller", vm.data.seller.name);
          }

          if (response.data.payments) {
            vm.$set(vm, "payments", response.data.payments);
          }
          vm.$set(vm, "table", vm.data.detail);
        })
        .catch(function(error) {});
    },
    lockUnlock(val) {
      if (val.status_id === 2) {
        this.updateStatus(val.public_id, 1);
      } else {
        this.updateStatus(val.public_id, 2);
      }
    },
    updateStatus(itemID, status) {
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
  }
};
</script>
