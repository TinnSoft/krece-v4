<template>
     <q-page padding>

        <cToolbar :toolbarlabel="toolbarlabel" :documentId="form.resolution_id" :redirectTo="`${redirect}`" 
          @click="submit" :loading="loading"
        ></cToolbar>     

        <div class="doc-container">
            <div class="row ">
                <div class="col-sm-5">
                    <q-list style="border: 0;">

                        <template v-if="showNumerationList==true">
                            <q-select clearable color="secondary" @input="onChangeNumeration" 
                            float-label="*Numeración" v-model="form.resolution_id_ref" :options="base.numerationList_sale_order" />
                        </template>
                        <template v-if="showManualNumber==true">
                            <q-input color="secondary" v-model="form.prefix" float-label="Prefijo" />
                            <q-field :error="checkIfFieldHasError(errors, 'resolution_id')" :error-label="label_required_field">
                                <q-input color="secondary" type="number" v-model="form.resolution_id" float-label="*Número" />
                            </q-field>
                        </template>

                        <q-field :error="checkIfFieldHasError(errors, 'customer_id')" :error-label="label_required_field">
                            <q-select clearable color="secondary" 
                              filter autofocus-filter 
                              filter-placeholder="Buscar" 
                              v-model="form.customer_id"                              
                              @input="onChangeContact(form.customer_id)"
                              float-label="*Cliente"  
                              :options="base.contacts" />
                        </q-field>
                        <q-field :error="checkIfFieldHasError(errors,'date')" :error-label="label_required_field">
                            <cDateTime v-model="form.date" stackLabel="*Fecha"></cDateTime>
                        </q-field>

                        <q-field :error="checkIfFieldHasError(errors,'due_date')" :error-label="label_required_field">
                            <cDateTime v-model="form.due_date" stackLabel="*Fecha de vencimiento"></cDateTime>
                        </q-field>

                        <q-input color="secondary" clearable type="textarea" v-model="form.observations" float-label="Observaciones" />

                        <q-field :error="checkIfFieldHasError(errors,'notes')" :error-label="label_required_field">
                            <q-input  class="q-pb-md" color="secondary" clearable type="textarea" v-model="form.notes" float-label="*Notas" />
                        </q-field>

                    </q-list>
                </div>
                <div class="col-sm-1">
                </div>
                <div class="col-sm-5">
                    <q-list style="border: 0;">
                        <q-select clearable color="secondary" float-label="Vendedor" v-model="form.seller_id" :options="base.sellers" />
                        <q-select clearable color="secondary" float-label="Lista de precios" v-model="form.list_price_id" :options="base.listprice" />

                        <q-field :error="checkIfFieldHasError(errors,'payment_terms_id')" :error-label="label_required_field">
                            <q-select clearable color="secondary" @input="onChangePaymentTerms" float-label="*Plazo" 
                            v-model="form.payment_terms_id" :options="base.payment_terms" />
                        </q-field>
                        <q-field :error="checkIfFieldHasError(errors,'currency_code')" :error-label="label_required_field">
                            <q-select clearable color="secondary" float-label="*Moneda" 
                            v-model="form.currency_code" :options="base.currency" />
                        </q-field>
                 
                        <q-btn v-if="(processType == 'edit')" 
                          icon="attach_file" flat class="within-iframe-hide" 
                          color="positive"  @click="loadFiles($refs)"
                          label="Gestionar Documentos">
                        </q-btn>
                    </q-list>
                </div>
            </div>
        </div>
    
        <cInvoiceDetail :form="form" :base="base" :errors="errors" tabLabel="DETALLE DE LA FACTURA"></cInvoiceDetail>

        <cAttachFiles ref="_attachfile"></cAttachFiles>
     </q-page>
</template>

<script>
import cAttachFiles from "../../components/modals/AttachFiles.vue";
import cToolbar from "../../components/cToolbar.vue";
import cInvoiceDetail from "../../components/tables/Datatable-Form-Detail.vue";
import Quasar from "Quasar";
const { addToDate } = Quasar.utils.date;
import cDateTime from "../../components/cDateTime.vue";

export default {
  middleware: "auth",
  data() {
    return {
      errors:'',
      form: {},
      base: {
        contacts: [
          {
            label: "",
            value: ""
          }
        ],
        sellers: [
          {
            label: "",
            value: ""
          }
        ],
        listprice: [
          {
            label: "",
            value: ""
          }
        ],
        currency: [
          {
            label: "COP",
            value: "COP"
          }
        ],
        products: [
          {
            label: "",
            value: ""
          }
        ],
        taxes: [
          {
            label: "",
            value: ""
          }
        ],
        payment_terms: [
          {
            label: "",
            value: ""
          }
        ],
        numerationList_sale_order: [
          {
            label: "",
            value: ""
          }
        ]
      },
      redirect: "/invoice",
      toolbarlabel: "NUEVA FACTURA DE VENTA #: ",
      path: "invoice/create",
      store: "invoice",
      method: "post",
      processType: "create",
      label_required_field: "Este Campo es Obligatorio",
      showManualNumber: false,
      loading:false
    };
  },
  components: {
    cAttachFiles,
    cToolbar,
    cDateTime,
    cInvoiceDetail
  },
  created() {
    if (this.$route.meta.mode === "edit") {
      this.path = `invoice/${this.$route.params.id}/edit`;
      this.store = `invoice/${this.$route.params.id}`;
      this.method = "put";
      this.button = "Guardar";
      this.toolbarlabel = "EDITAR FACTURA DE VENTA #: ";
      this.processType = "edit";
    } else if (this.$route.meta.mode === "clone") {
      this.path = `invoice/${this.$route.params.id}/edit?convert=clone`;
      this.store = `invoice`;
      this.method = "post";
      this.toolbarlabel = "CLONAR FACTURA DE VENTA No: ";
      this.processType = "clone";
    }
    this.fetchData();
  },
  computed: {
    showNumerationList() {
      if (this.base.numerationList_sale_order.length > 1) {
        return true;
      } else {
        return false;
      }
    },
  },
  methods: {
    onChangeNumeration(val) {
      if (val) {
        var vm = this;
        vm.base.numerationList_sale_order.forEach(function(item) {
          if (item.id == val) {
            vm.form.resolution_id_ref = item.id;
            vm.form.ResolutionIsAutoNumeric = item.auto_increment;

            if (item.auto_increment === 1) {
              vm.form.resolution_id = item.next_invoice_number;
              vm.form.prefix = item.prefix;
            } else {
              vm.form.resolution_id = "";
              vm.form.prefix = "";
            }

            if (item.isDefault == 1 || item.auto_increment == 1) {
              vm.showManualNumber = false;
            } else {
              vm.showManualNumber = true;
            }
          }
        });
      }
    },
    loadFiles(refs) {
      refs._attachfile.open(this.$route.params.id, "invoice");
    },
    checkIfFieldHasError(error, field) {
      try {
        if (error.errors[field]) {
          return true;
        }
      } catch (err) {}

      return false;
    },
    totalByLine(val) {
      var total =
        val.quantity * val.unit_price -
        val.quantity * val.unit_price * val.discount / 100;
      return total;
    },
    onChangePaymentTerms(val) {
      if (val) {
        var d = new Date();
        var vm = this;
        vm.base.payment_terms.forEach(function(item) {
          if (item.value === val) {
            if (item.days >= 0) {
              d.setDate(d.getDate() + item.days);

              vm.form.due_date = d;
            }
          }
        });
      } else {
        this.form.payment_terms_id = "";
      }
    },
    onChangeContact(val) {
      if (val) {
        var vm = this;
        vm.form.customer_id = val;
        vm.base.contacts.forEach(function(item) {
          if (item.id == val) {
            if (item.seller_id) {
              vm.form.seller_id = item.seller_id;
            }
          }
        });
      }
    },
    getCurrentDate() {
      var vm = this;
      if (vm.form.date == null) {
        const today = new Date();
        vm.form.date = today;
        vm.form.due_date = addToDate(today, { days: 30 });
      }
    },
    fetchData() {
      let vm = this;
      axios
        .get(`/api/${vm.path}`)
        .then(function(response) {
          vm.$set(vm, "form", response.data.form);
          
          if (response.data.base.contacts.length > 0) {
            vm.$set(vm.$data.base, "contacts", response.data.base.contacts);
          }
          if (response.data.base.currency.length > 0) {
            vm.$set(vm.$data.base, "currency", response.data.base.currency);
          }
          if (response.data.base.sellers.length > 0) {
            vm.$set(vm.$data.base, "sellers", response.data.base.sellers);
          }
          if (response.data.base.listprice.length > 0) {
            vm.$set(vm.$data.base, "listprice", response.data.base.listprice);
          }
          if (response.data.base.taxes.length > 0) {
            vm.$set(vm.$data.base, "taxes", response.data.base.taxes);
          }
          if (response.data.base.productlist.length > 0) {
            vm.$set(vm.$data.base, "products", response.data.base.productlist);
          }
          if (response.data.base.paymentTerms.length > 0) {
            vm.$set(
              vm.$data.base,
              "payment_terms",
              response.data.base.paymentTerms
            );
          }
          if (response.data.base.numerationList_sale_order.length > 0) {
            vm.$set(
              vm.$data.base,
              "numerationList_sale_order",
              response.data.base.numerationList_sale_order
            );
          }

          vm.getCurrentDate();
        })
        .catch(function(error) {
          if (error.response.data.message) {
            this.$q.notify({
              message: error.response.data.message,
              timeout: 3000,
              type: "negative"
            });
          }
          if (error.response.data.redirectTo) {
            vm.$router.replace(`${error.response.data.redirectTo}`);
          }
        });
    },
    submit() {
      let vm=this;
      vm.loading=true;
      vm.$set(vm.form, "processType", vm.processType);
     
      vm.$nextTick(function() {
        axios[vm.method](`/api/${vm.store}`, vm.form)
          .then(function(response) {
            let returnedId=response.data.id;

            if (returnedId) {              
                vm.$router.push(`${vm.redirect}/${returnedId}`)
            } else {
                vm.$router.push(vm.redirect)
            }
            vm.loading=false;            
          })
          .catch(function(error) {
            vm.$set(vm, "errors", error.response.data);           
            vm.loading=false;    
          });
      });
    }
  },
  watch: {
    $route: "fetchData"
  }
};
</script>
