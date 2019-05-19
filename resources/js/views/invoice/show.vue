<template>
     <q-page padding>

    <cToolbar toolbarlabel="FACTURA DE VENTA #: " :documentId="public_id" :redirectTo="`/${model}`" @click="$router.push(`/${model}/create`)"
        label2="NUEVA FACTURA" icon2="add"></cToolbar>  

        <div class="doc-container">
            <div class="row ">
                <div class="col-sm-5">
                    <q-list style="border: 0;padding: 0">
                        <q-input v-model="contactname" disable stack-label="Cliente" />
                        <q-input v-model="seller" disable stack-label="Vendedor" />
                        <q-input v-model="data.observations" type="textarea" disable stack-label="Observaciones" />
                        <q-input v-model="listprice" disable stack-label="Lista de precios" />
                        <q-input v-model="data.currency_code" disable stack-label="Moneda" />
                    </q-list>
                </div>
                <div class="col-sm-1">
                </div>
                <div class="col-sm-5">
                    <q-list style="border: 0;padding: 0">
                        <q-input v-model="data.date" disable stack-label="Fecha de creación" />
                        <q-input v-model="data.due_date" disable stack-label="Fecha de vencimiento" />
                        <q-input v-model="data.notes" type="textarea" disable stack-label="Notas" />
                        <q-field label="Estado: " :label-width="2">
                            <cStatus :statusId="data.status_id"></cStatus>
                        </q-field>
                        <q-separator></q-separator>
                        <q-btn flat class="within-iframe-hide" color="positive" @click="LoadFiles($refs)">
                            <q-icon size="1rem" name="attach_file" />
                            <small style='text-decoration: underline'>Gestionar Documentos</small>
                        </q-btn>
                    </q-list>
                </div>
            </div>

        </div>
        <br>
        <q-tabs color="grey-1" text-color="positive">
            <q-tab default slot="title" name="tab-1" label="Detalle"/>
            <q-tab slot="title" name="tab-2"  label="Pagos asociados"/>
            <q-tab-pane name="tab-1">
                <cTableShow 
                    :qdata="table" 
                    :subtotal="data.sub_total" 
                    :discounts="data.total_discounts" 
                    :taxes.sync="totalTaxes" 
                    :total="data.total"
                    :isTaxArray="true"
                ></cTableShow>
         
            </q-tab-pane>
            <q-tab-pane name="tab-2">
                 <cPaymentAssociated :qdata="payments"></cPaymentAssociated> 
            </q-tab-pane>
        </q-tabs>

        <cSendEmail ref="_sendEmail"></cSendEmail>
        <cAttachFiles ref="_attachfile"></cAttachFiles>

        <q-page-sticky position="top-left" :offset="[16, 16]">
        <q-btn rounded   color="secondary">
          <q-icon name="menu" />

          <!-- with Vue reference -->
          <q-popover ref="popover">
            <q-list dense link class="scroll" style="min-width: 200px">
                <q-item v-close-overlay  @click.native="pdf()">
                    <q-item-section inverted color="grey-6" left icon="print" />                    
                    <q-item-label>
                        <q-item-section label>Imprimir</q-item-section>
                    </q-item-label>
                </q-item>
                <q-item v-close-overlay @click.native="edit()">
                    <q-item-section inverted left icon="edit" color="grey-6" />
                    <q-item-label>
                        <q-item-section label>Editar</q-item-section>
                    </q-item-label>
                </q-item>
                <q-item v-close-overlay @click.native="clone()" >
                    <q-item-section inverted icon="content_copy" left color="grey-6" />
                    <q-item-label>
                        <q-item-section label>Clonar</q-item-section>
                    </q-item-label>
                </q-item>
                <q-item link v-close-overlay>
                    <q-item-section inverted :icon="data.status_id === 1 ? 'lock_outline' : 'lock_open'"  color="grey-6" />
                    <q-item-label :label="data.status_id === 1 ? 'Anular' : 'Habilitar'" />
                    <q-item-section right >
                        <cToggle @blur="lockUnlock(data)" :id="data.status_id"></cToggle>
                    </q-item-section>  
                </q-item>
                <q-item v-close-overlay @click.native="email($refs)" >
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

     </q-page>
</template>

<script>
import cSendEmail from "../../components/modals/SendEmailForm.vue";
import cToolbar from "../../components/cToolbar.vue";
import cStatus from "../../components/status/cStatus.vue";
import cTableShow from "../../components/tables/Datatable-Show.vue";
import cPaymentAssociated from "./payment_associated.vue";
import cAttachFiles from "../../components/modals/AttachFiles.vue";
import cToggle from "../../components/tables/cToggle.vue";

export default {
  middleware: "auth",
  components: {
    cSendEmail,
    cToolbar,
    cStatus,
    cTableShow,
    cPaymentAssociated,
    cAttachFiles,
    cToggle
  },
  created() {
    this.fetchData();
  },
  data() {
    return {
      state: "ABIERTA",
      model: "invoice",
      path: `invoice/${this.$route.params.id}`,
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
