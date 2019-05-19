<template>
     <q-page padding >
        <kToolbar :toolbarlabel="toolbarlabel" :documentId="form.resolution_id" :redirectTo="`${redirect}`" 
          :loading="loading" :showsaveButton="false"
        ></kToolbar>   

        <div>
            <q-stepper ref="stepper" v-model="step" color="secondary" vertical>
                <q-step default name="general" title="Datos Generales">
                    <small>
                        Te guiaremos atraves del proceso de relacion de recibos de caja.Por favor diligencia los siguientes campos:
                    </small>

                    <div class="doc-container">
                        <div class="row ">
                            <div class="col-sm-5">
                                <q-list style="border: 0;padding: 0">
                                    <q-field :error="checkIfFieldHasError(errors, 'customer_id')" :error-label="label_required_field">
                                        <q-select 
                                        clearable 
                                        filter 
                                        autofocus-filter  
                                        filter-placeholder="Buscar" 
                                        v-model="form.customer_id" 
                                        float-label="*Cliente" 
                                        :options="base.contacts" />
                                    </q-field>

                                    <q-field :error="checkIfFieldHasError(errors, 'bank_account_id')" :error-label="label_required_field">
                                        <q-select 
                                          clearable 
                                          filter 
                                          autofocus-filter
                                          filter-placeholder="Buscar" 
                                          v-model="form.bank_account_id" 
                                          float-label="*Cuenta" 
                                          :options="base.bank" />
                                    </q-field>

                                    <q-field :error="checkIfFieldHasError(errors, 'payment_method_id')" :error-label="label_required_field">
                                        <q-select clearable 
                                        filter 
                                        filter-placeholder="Buscar" 
                                        v-model="form.payment_method_id" 
                                        float-label="*Método de pago" 
                                        :options="base.paymentmethod" />
                                    </q-field>

                                    <q-field :error="checkIfFieldHasError(errors, 'date')" :error-label="label_required_field">
                                        <kDateTime v-model="form.date" stackLabel="*Fecha"></kDateTime>
                                    </q-field>
                                </q-list>
                            </div>
                            <div class="col-sm-1">
                            </div>
                            <div class="col-sm-5">
                                <q-list style="border: 0;padding: 0">
                                    <q-input type="textarea" v-model="form.observations" stack-label="Observaciones" />

                                    <q-field :error="checkIfFieldHasError(errors, 'notes')" :error-label="label_required_field">
                                        <q-input type="textarea" v-model="form.notes" stack-label="*Notas del recibo" />
                                    </q-field>
                                </q-list>
                            </div>
                        </div>
                    </div>

                    <q-stepper-navigation>
                        <q-btn color="secondary" @click="$refs.stepper.next()" :disabled="generalDataNextStep">Siguiente</q-btn>
                    </q-stepper-navigation>
                </q-step>

                <q-step name="transactiontype" title="Tipo de transacción">
                    <small>Elija el tipo de transacción que desea asociar a su pago </small>

                    <q-list link>
                        <q-item tag="label">
                            <q-item-section>
                                <q-radio color="amber" v-model="isInvoice" val="1" />
                            </q-item-section>
                            <q-item-label>
                                <q-item-section label>Asociar pago a Factura de venta</q-item-section>
                                <q-item-section sublabel lines="2">Relacionar pagos a facturas que se encuentren en estado ABIERTO</q-item-section>
                            </q-item-label>
                        </q-item>
                        <q-item multiline tag="label">
                            <q-item-section>
                                <q-radio color="amber" v-model="isInvoice" val="0" />
                            </q-item-section>
                            <q-item-label>
                                <q-item-section label>Asociar pago a Categoría</q-item-section>
                                <q-item-section sublabel lines="2">Relacionar pagos a categorías existentes</q-item-section>
                            </q-item-label>
                        </q-item>
                    </q-list>

                    <q-stepper-navigation>
                        <q-btn color="secondary" flat @click="$refs.stepper.previous()">Anterior</q-btn>
                        <q-btn color="secondary" :disabled="transactionTypeNextStep" @click="gotPaymentStep($refs.stepper)">Siguiente</q-btn>
                    </q-stepper-navigation>
                </q-step>

                <q-step name="pay" icon="attach_money" title="Pago">
                 <template v-if="isInvoice=='1'">
                        <small>Facturas de venta pendientes por relacionar pago
                        </small><br>

                     <cPaymentInvoiceTable :qdata="form.pending_payment_in" :refstepper="$refs.stepper" :sourceForm="this.form" 
                     :isInvoice="isInvoice"></cPaymentInvoiceTable>
                  </template>
                  <template v-if="isInvoice=='0'">                        
                            <small>
                                Seleccione la Categoría a la que pertenece el gasto
                            </small>
                    
                       <cPaymentInvoiceTable :qdata="form.payment_in_to_category" 
                        :refstepper="$refs.stepper" 
                        :sourceForm="this.form" :isInvoice="isInvoice"
                        :categorylist="category_list"
                        :taxlist="taxes"></cPaymentInvoiceTable>
                    </template> 

                </q-step>

                <q-inner-loading :visible="showWait">
                    <q-spinner-mat size="50px" color="teal-4" />Espere por favor...
                </q-inner-loading>
            </q-stepper>

        </div>

     </q-page>
</template>

<script>
import Quasar from "Quasar";
const { addToDate } = Quasar.utils.date;
import cAttachFiles from "../../components/modals/AttachFiles.vue";
import kDateTime from "../../components/cDateTime.vue";
import cPaymentInvoiceTable from '../payment-in/payment_datatable.vue'
import cPaymentInDetail from "../../components/tables/Datatable-Form-Detail.vue";
import kToolbar from "../../components/cToolbar.vue";

export default {
  middleware: "auth",
  data() {
    return {
      errors:'',
      loading: false,
      step: "first",
      form: {},
      base: {
        contacts: [
          {
            label: "",
            value: ""
          }
        ],
        paymentmethod: [
          {
            label: "",
            value: ""
          }
        ],
        bank: []
      },
      select: null,
      value: null,
      redirect: "/payment-in",
      toolbarlabel: "RECIBO DE CAJA No: ",
      path: "payment-in/create",
      store: "payment-in",
      processType: "create",
      isInvoice: "",
      showWait: false,
      label_required_field: "Este Campo es Obligatorio",
      category_list: [{ label: "", value: "" }],
      taxes: [{ label: "", value: "" }]
    };
  },
  components: {
    kToolbar,
    cAttachFiles,
    kDateTime,
    cPaymentInDetail,
    cPaymentInvoiceTable
  },
  created() {
      console.log(this.form)
    if (this.$route.meta.mode === "edit") {
      this.path = `payment-in/${this.$route.params.id}/edit`;
    }
    this.fetchData();
  },
  computed: {
    transactionTypeNextStep() {
      if (this.isInvoice && this.isInvoice != "") {
        return false;
      }
      return true;
    },
    generalDataNextStep() {
      if (
        this.form.customer_id &&
        this.form.bank_account_id &&
        this.form.date &&
        this.form.payment_method_id &&
        this.form.notes
      ) {
        return false;
      }
      return true;
    },
  },
  methods: {
    gotPaymentStep(ref) {
      ref.next();
      this.getInvoiceSale();
    },
    getInvoiceSale() {
      let vm = this;
      var procedure_path = "";
      vm.showWait = true;
      vm.hasPendingPayment = 1;
      if (vm.isInvoice == 1) {
        vm.$delete(vm.$data.form, "payment_in_to_category", []);

        if (this.$route.meta.mode === "edit") {
          procedure_path = "/api/getInvoicePendingtoPay_edit/";
        } else {
          procedure_path = "/api/getInvoicePendingtoPay/";
        }

        axios
          .get(procedure_path + vm.form.customer_id)
          .then(function(response) {
            vm.$set(
              vm.$data.form,
              "pending_payment_in",
              response.data.PendingByPayment
            );

            if (response.data.PendingByPayment.length == 0) {
              vm.hasPendingPayment = 0;
            }
            vm.showWait = false;
          })
          .catch(function(error) {
            vm.showWait = false;
            vm.$set(vm.$data, "errors", error);
          });
      } else if (vm.isInvoice == 0) {
        var categoryData = [
          {
            category_id: "",
            unit_price: 0,
            tax_id: "",
            quantity: 1,
            observations: "",
            total: 0
          }
        ];

        vm.$delete(vm.$data.form, "pending_payment_in", []);
        vm.$set(vm.$data.form, "payment_in_to_category", categoryData);
        procedure_path = "/api/payment_in_ToCategorySection/";

        axios
          .get(procedure_path)
          .then(function(response) {
            vm.$set(vm.$data, "category_list", response.data.category);
            vm.$set(vm.$data, "taxes", response.data.taxes);
            vm.showWait = false;
          })
          .catch(function(error) {
            vm.$set(vm.$data, "errors", error);
            vm.showWait = false;
          });
      }
    },
    onInputBank(val) {
      let vm = this;
      if (val) {
        vm.$set(vm.$data.form, "bank_account_id", val.id);
      } else {
        vm.$set(vm.$data.form, "bank_account_id", null);
      }
    },
    checkIfFieldHasError(val) {
      if (val) {
        return true;
      }
      return false;
    },
    getCurrentDate() {
      let vm = this;
      if (vm.form.date == null) {
        const today = new Date();
        vm.form.date = today;
      }
    },
    fetchData() {
      let vm = this;
      axios
        .get(`/api/${vm.path}`)
        .then(function(response) {
          vm.$set(vm, "form", response.data.form);
          console.log('data master:',response.data)
          if (response.data.base.contacts) {
            vm.$set(vm.$data.base, "contacts", response.data.base.contacts);
          }
          if (response.data.base.paymentmethod) {
            vm.$set(
              vm.$data.base,
              "paymentmethod",
              response.data.base.paymentmethod
            );
          }

          if (response.data.base.bank) {
            vm.$set(vm.$data.base, "bank", response.data.base.bank);
          }

          if (vm.$route.meta.mode === "edit") {
            vm.$set(
              vm.$data,
              "isInvoice",
              "" + response.data.form.isInvoice + ""
            );
          } else {
            vm.getCurrentDate();
          }
        })
        .catch(function(error) {
          if (error.response.data.message) {
            Toast.create.negative(error.response.data.message);
          }
          if (error.response.data.redirectTo) {
            vm.$router.replace(`${error.response.data.redirectTo}`);
          }
        });
    }
  },
  watch: {
    $route: "fetchData"
  }
};
</script>