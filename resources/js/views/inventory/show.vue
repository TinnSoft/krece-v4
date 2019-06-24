<template>
     <q-page padding>
       <kToolbar :toolbarlabel="form.name" :showsaveButton="false" :redirectTo="`${redirect}`" 
        ></kToolbar>  

          <q-tabs color="grey-2" align="justify" inverted>
            <q-tab default color="grey-6" name="info" slot="title" icon="dashboard" label="Detalle" />
            <q-tab color="grey-6" name="report" slot="title" icon="pie_chart" label="Movimientos" />
            <q-tab-pane name="info">
                <q-list separator>
                    <q-expansion-item icon="developer_board" color="green" label="GENERAL" sublabel="información básica del ítem" opened> 
   
                        <div>
                            <q-item v-if="form.description">
                                <q-item-section icon="assignment"  />
                                <q-item-label>
                                    <q-item-section label>{{form.description}}</q-item-section>
                                    <q-item-section sublabel>Descripción</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item v-if="form.reference">
                                <q-item-label inset>
                                    <q-item-section label>{{form.reference}}</q-item-section>
                                    <q-item-section sublabel>Referencia</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item  v-if="form.sale_price">
                                <q-item-section icon="attach_money"  />
                                <q-item-label inset>
                                    <q-item-section label>{{form.sale_price}}</q-item-section>
                                    <q-item-section sublabel>Precio de venta</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item v-if="form.inv_unit_cost">
                                <q-item-section icon="attach_money"  />
                                <q-item-label inset>
                                    <q-item-section label>{{form.inv_unit_cost}}</q-item-section>
                                    <q-item-section sublabel>Precio de Compra</q-item-section>
                                </q-item-label>
                            </q-item>
                              <q-item v-if="form.category">
                                <q-item-section icon="play_for_work" />
                                <q-item-label inset>
                                    <q-item-section label>{{getNameValue(form.category)}}</q-item-section>
                                    <q-item-section sublabel>Categoría</q-item-section>
                                </q-item-label>
                            </q-item>
                             <q-item v-if="form.list_price">
                                <q-item-section icon="view_list"  />
                                <q-item-label inset>
                                    <q-item-section label>{{getNameValue(form.list_price)}}</q-item-section>
                                    <q-item-section sublabel>Lista de Precios</q-item-section>
                                </q-item-label>
                            </q-item>
                        </div>
                   
                   
                    </q-expansion-item>                   
                    <q-expansion-item icon="more_horiz" label="OTROS" sublabel="información adicional del ítem">
                        <div>
                            <q-item v-if="measureUnit">
                                <q-item-section icon="assignment"  />
                                <q-item-label>
                                    <q-item-section label>{{measureUnit}}</q-item-section>
                                    <q-item-section sublabel>Unidad de Medida</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item v-if="form.inv_quantity_initial">
                                <q-item-section icon="equalizer"  />
                                <q-item-label inset>
                                    <q-item-section label>{{form.inv_quantity_initial}}</q-item-section>
                                    <q-item-section sublabel>Inventario Inicial (Cantidad)</q-item-section>
                                </q-item-label>
                            </q-item>
                             <q-item v-if="form.inv_quantity_actual">
                                <q-item-section icon="equalizer" />
                                <q-item-label inset>
                                    <q-item-section label>{{form.inv_quantity_actual}}</q-item-section>
                                    <q-item-section sublabel>Inventario Actual (Cantidad)</q-item-section>
                                </q-item-label>
                            </q-item>
                            <q-item v-if="form.tax">
                                <q-item-section icon="attach_money" />
                                <q-item-label inset>
                                    <q-item-section label>{{getNameValue(form.tax)}}</q-item-section>
                                    <q-item-section sublabel>Impuesto</q-item-section>
                                </q-item-label>
                            </q-item>
                        </div>
                    </q-expansion-item>
                </q-list>
            </q-tab-pane>
            <q-tab-pane name="report">
                <q-select color="secondary" float-label="Seleccione un reporte" v-model="transaction_type" :options="listOptions" @input="handleChange" />
                 <movementsSummary  :path="path" :kmodule="transaction_type"></movementsSummary>
            </q-tab-pane>
        </q-tabs>

     </q-page>
</template>

<script>

import movementsSummary from "./reports/movements.vue";

export default {
   middleware: "auth",
  components: {
    movementsSummary,   
    kToolbar,
  },
  data() {
    return {
      redirect: "/inventory",
      listOptions: [
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
      transaction_type: "invoice",
      pathFetchData: `inventory/${this.$route.params.id}`,
      modulename: "inventory",
      warningmessage: "Estas a punto de eliminar el producto: "
    };
  },
  created() {
    this.fetchData();
  },
  computed: {
    measureUnit() {
      try {
        if (this.form.measure_unit) {
          return this.form.measure_unit.measure_unit;
        }
      } catch ($e) {
        return null;
      }
    },
    path() {
      return `getInventoryReports/${this.transaction_type}/${this.$route.params
        .id}`;
    }
  },
  methods: {
    getNameValue(val) {
      try {
        return val.name;
      } catch ($e) {
        return null;
      }
    },
    handleChange(val) {
      this.transaction_type = val;
    },
    fetchData() {
      let vm = this;
      vm.isProcessing = true;
      axios
        .get(`/api/${vm.pathFetchData}`)
        .then(function(response) {
          // console.log(response.data.model)
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