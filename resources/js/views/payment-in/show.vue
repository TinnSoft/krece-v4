<template>
     <q-page padding >
            <kToolbar toolbarlabel="RECIBO DE CAJA No: " :documentId="this.$route.params.id" :redirectTo="`/${model}`" @click="$router.push(`/${model}/create`)"
         icon2="add" label2="NUEVO INGRESO"></kToolbar> 
    

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
                  <!--<q-item link v-close-overlay>
                      <q-item-section inverted :icon="data.status_id === 1 ? 'lock_outline' : 'lock_open'"  color="grey-6" />
                      <q-item-label :label="data.status_id === 1 ? 'Anular' : 'Habilitar'" />
                      <q-item-section right >
                          <cToggle @blur="lockUnlock(data)" :id="data.status_id"></cToggle>
                      </q-item-section>  
                  </q-item>-->
                  <q-item v-close-overlay @click.native="email($refs)" >
                      <q-item-section inverted icon="mail" left color="grey-6" />
                      <q-item-label>
                          <q-item-section label>Enviar por Email</q-item-section>
                      </q-item-label>
                  </q-item>
              </q-list>
            </q-popover>
          </q-btn>
        </q-page-sticky>

        <div class="doc-container">
            <div class="row ">
                <div class="col-sm-5">
                    <q-list style="border: 0;padding: 0">
                        <q-input v-model="customerName" disable stack-label="Cliente" />
                        <q-input v-model="bankAccountName" disable stack-label="Cuenta" />
                        <q-input v-model="paymentMethod" disable stack-label="Método de pago" />
                        <q-input v-model="payment.observations" type="textarea" disable stack-label="Observaciones" />
                        <q-input v-model="payment.notes" type="textarea" disable stack-label="Notas" />

                    </q-list>
                </div>
                <div class="col-sm-1">
                </div>
                <div class="col-sm-5">
                    <q-list style="border: 0;padding: 0">
                        <q-input v-model="payment.date" disable stack-label="Fecha de creación" />
                        <q-input :value="ftotal" disable stack-label="Total Pagado" />
                        <q-field label="Estado: " :label-width="2">
                            <kStatus :statusId="payment.status_id"></kStatus>
                        </q-field>
                    </q-list>
                </div>
            </div>

        </div>
        <template v-if="checkFetchedData==true">   
        <q-tabs color="grey-1" text-color="positive">
            <q-tab default slot="title" name="tab-1" label="Detalle"/>
            <q-tab-pane name="tab-1">
                <cTableShow 
                    :qdata="detail" 
                    :isInvoice="payment.isInvoice"
                    :subtotal="sub_total" 
                    :taxes.sync="totalTaxes" 
                    :total="total"
                ></cTableShow>           
            </q-tab-pane>
        </q-tabs>  
             
        </template>
        <kSendEmailForm ref="_sendEmail"></kSendEmailForm>
     </q-page>
</template>

<script>
import cTableShow from "./show_datatable.vue";

export default {
  middleware: "auth",
  components: {
    cTableShow
  },
  created() {
    this.fetchData();
  },
  data() {
    return {
      state: "ABIERTA",
      model: "payment-in",
      path: `payment-in/${this.$route.params.id}`,
      data: {},
      detail: [],
      total: 0,
      sub_total: 0,
      payment: "",
      isCategory: false,
      table: [],
      totalTaxes: 0,
      pathEmailData: "getTemplateEmailToCustomerPaymentIn"
    };
  },
  watch: {
    $route: "fetchData"
  },
  computed: {
    checkFetchedData() {
      if (this.payment) {
        return true;
      }
      return false;
    },
    ftotal() {
      return accounting.formatMoney(this.total);
    },
    bankAccountName() {
      if (this.payment.bank_account) {
        return this.payment.bank_account.bank_account_name;
      }
      return "";
    },
    customerName() {
      if (this.payment.contact) {
        return this.payment.contact.name;
      }
      return "";
    },
    paymentMethod() {
      if (this.payment.payment_method) {
        return this.payment.payment_method.name;
      }
      return "";
    }
  },
  methods: {
    email(refs) {
      refs._sendEmail.open(
        this.payment.resolution_id,
        this.pathEmailData,
        this.model
      );
    },
    edit() {
      this.$router.push(`/${this.path}/edit`);
    },
    pdf() {
      window.open(
        `/api/${this.model}/${this.payment.public_id} /pdf`,
        "_blank"
      );
    },
    fetchData() {
      let vm = this;
      axios
        .get(`/api/${vm.path}`)
        .then(function(response) {
          console.log(response.data);
          vm.$set(vm, "payment", response.data.payment);
          vm.$set(vm, "detail", response.data.detail);
          vm.$set(vm, "total", response.data.total);
          vm.$set(vm, "sub_total", response.data.subtotal);
          vm.$set(vm, "isCategory", response.data.isCategory);
          vm.$set(vm, "totalTaxes", response.data.totalTaxes);
        })
        .catch(function(error) {
          console.log(error);
        });
    }
  }
};
</script>

<style>
</style>
