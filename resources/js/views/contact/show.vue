<template>
    <div class="layout-padding docs-tab ">
       <kToolbar :toolbarlabel="form.name" :showsaveButton="false" :redirectTo="`${redirect}`" 
        ></kToolbar>  

          <q-tabs color="grey-2" align="justify" inverted>
            <q-tab default color="grey-6" name="info" slot="title" icon="people" label="Acerca de" />
            <q-tab color="grey-6" name="report" slot="title" icon="pie_chart" label="Movimientos" />
            <q-tab-pane name="info">
                <q-list>
                    <q-expansion-item icon="perm_identity" label="<strong>General</strong>" sublabel="información básica del contacto" opened>
                        <div>
                            <q-item>
                                <q-item-section icon="perm_identity" color="light" />
                                <q-item-label>
                                    <q-item-section label>{{form.name}}</q-item-section>
                                    <q-item-section sublabel>Nombre</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item>
                                <q-item-label inset>
                                    <q-item-section label>{{form.nit}}</q-item-section>
                                    <q-item-section sublabel>Nit</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item>
                                <q-item-section icon="location_city" color="light" />
                                <q-item-label inset>
                                    <q-item-section label>{{form.city}}</q-item-section>
                                    <q-item-section sublabel>Ciudad</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item>
                                <q-item-section icon="email" color="light" />
                                <q-item-label inset>
                                    <q-item-section label>{{form.email}}</q-item-section>
                                    <q-item-section sublabel>Correo Electrónico</q-item-section>
                                </q-item-label>
                            </q-item>
                        </div>
                    </q-expansion-item>
                    <q-expansion-item icon="phone" label="<strong>Teléfonos</strong>" sublabel="Números de contacto">
                        <div>
                            <q-item>
                                <q-item-section icon="phone" color="light" />
                                <q-item-label inset>
                                    <q-item-section label>{{form.phone1}}</q-item-section>
                                    <q-item-section sublabel>Teléfono</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item>
                                <q-item-section icon="phone" color="light" />
                                <q-item-label>
                                    <q-item-section label>{{form.phone2}}</q-item-section>
                                    <q-item-section sublabel>Teléfono 2</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item>
                                <q-item-section icon="smartphone" color="light" />
                                <q-item-label inset>
                                    <q-item-section label>{{form.phone_mobile}}</q-item-section>
                                    <q-item-section sublabel>Celular</q-item-section>
                                </q-item-label>
                            </q-item>
                        </div>
                    </q-expansion-item>
                    <q-expansion-item icon="info_outline" label="<strong>Otros</strong>" sublabel="información adicional del contacto">
                        <div>
                            <q-item>
                                <q-item-section icon="attach_money" color="light" />
                                <q-item-label>
                                    <q-item-section label>{{list_price}}</q-item-section>
                                    <q-item-section sublabel>Lista de Precios</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item>
                                <q-item-section icon="note" color="light" />
                                <q-item-label inset>
                                    <q-item-section label>{{form.observation}}</q-item-section>
                                    <q-item-section sublabel>Observaciones</q-item-section>
                                </q-item-label>
                            </q-item>
                        </div>
                    </q-expansion-item>
                </q-list>
            </q-tab-pane>
            <q-tab-pane name="report">
                <q-select color="secondary" float-label="Seleccione un reporte" v-model="transaction_type" :options="listOptions" @change="handleChange" />
                <!--<kDatatable ref="__transactions" :path="path" :kmodule="transaction_type"></kDatatable>-->
               <template v-if="transaction_type=='payment'">
                <paymentReport :path="path" :kmodule="transaction_type"></paymentReport>
               </template>
               <template v-if="transaction_type=='bill'">
                <billReport  :path="path" :kmodule="transaction_type"></billReport>
               </template>
                 <template v-if="transaction_type=='credit_note'">
                <creditNoteReport  :path="path" :kmodule="transaction_type"></creditNoteReport>
               </template>
                 <template v-if="transaction_type=='debit_note'">
                <debitNoteReport  :path="path" :kmodule="transaction_type"></debitNoteReport>
               </template>
                <template v-if="transaction_type=='estimate'">
                <estimateReport  :path="path" :kmodule="transaction_type"></estimateReport>
               </template>
                 <template v-if="transaction_type=='invoice'">
                <invoiceReport  :path="path" :kmodule="transaction_type"></invoiceReport>
               </template>
                   <template v-if="transaction_type=='po'">
                <poReport  :path="path" :kmodule="transaction_type"></poReport>
               </template>
                 <template v-if="transaction_type=='remision'">
                <remisionReport  :path="path" :kmodule="transaction_type"></remisionReport>
               </template>
            </q-tab-pane>
        </q-tabs>

    </div>
</template>

<script>
import {
  QList,
  QListHeader,
  QItem,
  QItemSeparator,
  QItemSide,
  QItemMain,
  QItemTile,
  QCollapsible,
  QRadio,
  QTab,
  QTabs,
  QTabPane,
  QSelect
} from 'quasar-framework/dist/quasar.mat.esm';

import axios from "axios";
import paymentReport from "./reports/payment.vue";
import billReport from "./reports/bill.vue";
import creditNoteReport from "./reports/credit_note.vue";
import debitNoteReport from "./reports/debit_note.vue";
import estimateReport from "./reports/estimate.vue";
import invoiceReport from "./reports/invoice.vue";
import poReport from "./reports/purchase_order.vue";
import remisionReport from "./reports/remision.vue";
import kToolbar from "../../components/Toolbar.vue";

export default {
  components: {
    QList,
    QSelect,
    QListHeader,
    QItem,
    QItemSeparator,
    QItemSide,
    QItemMain,
    QItemTile,
    QCollapsible,
    QRadio,
    QTab,
    QTabs,
    QTabPane,
    paymentReport,
    billReport,
    creditNoteReport,
    debitNoteReport,
    estimateReport,
    invoiceReport,
    poReport,
    kToolbar,
    remisionReport
  },
  data() {
    return {
      redirect: "/contact",
      listOptions: [
        {
          label: "Pagos",
          icon: "show_chart",
          value: "payment"
        },
        {
          label: "Facturas de venta",
          icon: "show_chart",
          value: "invoice"
        },
        {
          label: "Notas de crédito",
          icon: "show_chart",
          value: "credit_note"
        },
        {
          label: "Cotizaciones",
          icon: "show_chart",
          value: "estimate"
        },
        {
          label: "Facturas de compra",
          icon: "attach_money",
          value: "bill"
        },
        {
          label: "Notas débito",
          icon: "attach_money",
          value: "debit_note"
        },
        {
          label: "Remisiones",
          icon: "attach_money",
          value: "remision"
        },
        {
          label: "Ordenes de Compra",
          icon: "attach_money",
          value: "po"
        }
      ],
      form: {},
      isProcessing: false,
      transaction_type: "payment",
      pathFetchData: `contact/${this.$route.params.id}`,
      modulename: "payment",
      warningmessage: "Estas a punto de eliminar la Factura de venta # "
    };
  },
  created() {
    this.fetchData();
  },
  computed: {
    transactiontype() {
      return this.transaction_type;
    },
    list_price() {
      if (this.form.list_price) {
        return this.form.list_price.name;
      }
      return "";
    },
    path() {
      return `getContactReports/${this.transaction_type}/${this.$route.params
        .id}`;
    }
  },
  methods: {
    handleChange(val) {
      this.transaction_type = val;
    },
    fetchData() {
      var vm = this;
      vm.isProcessing = true;
      axios
        .get(`/api/${vm.pathFetchData}`)
        .then(function(response) {
          vm.$set(vm, "form", response.data.model);
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
        });
    }
  }
};
</script>