<template>
    <div>
        <q-table :data="qdata" :columns="columns">

            <q-td slot="body-cell-amount_receipt" slot-scope="props" :props="props">
               <q-input color="secondary" class="no-margin no-padding" 
               @change="onChange" type="number" prefix="$" v-model="qdata[props.row.__index].amount_receipt" 
               :value="qdata[props.row.__index].amount_receipt" />
            </q-td>
                
            <q-td slot="body-cell-tax_id" slot-scope="props" :props="props">
                <q-select color="secondary" class="no-margin no-padding" 
                float-label="Seleccione" v-model="qdata[props.row.__index].tax_id" :options="taxlist" />
            </q-td>

            <q-td slot="body-cell-category_id" slot-scope="props" :props="props">
                <q-select color="secondary" filter filter-placeholder="Buscar" class="no-margin no-padding" 
                float-label="Seleccione" v-model="qdata[props.row.__index].category_id" :options="categorylist" />
            </q-td>

            <q-td slot="body-cell-unit_price" slot-scope="props" :props="props">
                <q-input color="secondary"  @change="onChange" 
                type="number" prefix="$" v-model="qdata[props.row.__index].unit_price" :value="qdata[props.row.__index].unit_price" />
            </q-td>

            <q-td slot="body-cell-quantity" slot-scope="props" :props="props">
                <q-input color="secondary" class="no-margin no-padding" @change="onChange" 
                type="number" v-model="qdata[props.row.__index].quantity" />
            </q-td>

            <q-td slot="body-cell-observations" slot-scope="props" :props="props">
                <q-input color="secondary" class="no-margin no-padding" placeholder="Observaciones" 
                v-model="qdata[props.row.__index].observations" />
            </q-td>
            
            <q-td slot="body-cell-ctotal" slot-scope="props" :props="props">
                <q-input :value="ftotal(qdata[props.row.__index])" disable />
            </q-td>

            <q-td slot="body-cell-actions" slot-scope="props" :props="props">
                <q-btn flat icon="delete" color="red" small v-bind:style="styleButton" @click="deleteRow(props)">
                    <q-tooltip>
                        Eliminar fila
                    </q-tooltip>
                </q-btn>
            </q-td>

        </q-table>
        <template v-if="isInvoice != 1">
            <q-btn flat color="red" push @click="addline()" small>
                <q-icon name="add" /> Nueva línea
            </q-btn>
        </template>
        <q-stepper-navigation>
            <q-btn color="secondary" flat @click="refstepper.previous()">ANTERIOR</q-btn>
            <q-btn color="secondary" @click="submit()" v-model="isProcessing" loader>Guardar
                <span slot="loading">
                    <q-spinner-hourglass class="on-left" /> Guardando...
                </span>
            </q-btn>
        </q-stepper-navigation>
        
    </div>
</template>

<script>
function invoiceColumns() {
  return [
    {
      label: "# Factura",
      field: "resolution_id",
      name: "resolution_id",
      type: "text"
    },
    {
      label: "Total",
      field: "total",
      name: "total",
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string"
    },
    {
      label: "Pagado",
      field: "total_payed",
      name: "total_payed",
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string"
    },
    {
      label: "Por Pagar",
      field: "total_pending_by_payment",
      name: "total_pending_by_payment",
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string"
    },
    {
      label: "Valor Recibido",
      field: "amount_receipt",
      format(value) {
        return value;
      },
      type: "number"
    }
  ];
}

function categoryColumns() {
  return [
    {
      label: "Categoría",
      field: "category_id",
      name: "category_id",
      type: "text"
    },
    {
      label: "Valor",
      field: "unit_price",
      name: "unit_price",
      type: "text"
    },
    {
      label: "Impuesto",
      field: "tax_id",
      name: "tax_id",
      type: "text"
    },
    {
      label: "Cantidad",
      field: "quantity",
      name: "quantity",
      type: "text"
    },
    {
      label: "Observaciones",
      field: "observations",
      name: "observations",
      type: "text"
    },
    {
      label: "Total",
      field: "ctotal",
      name: "ctotal",
      type: "text"
    },
    {
      label: "",
      field: "actions",
      name: "actions",
      type: "text"
    }
  ];
}

export default {
  props: {
    qdata: {
      type: Array,
      default: () => []
    },
    refstepper: {},
    sourceForm: {},
    isInvoice: {},
    categorylist: { type: Array, default: () => [] },
    taxlist: { type: Array, default: () => [] }
  },
  methods: {
    deleteRow(cell) {
      let vm = this;
      vm.qdata.splice(cell.row.__index, 1);
    },
    addline() {
      this.qdata.push({
        category_id: "",
        unit_price: 0,
        tax_id: "",
        quantity: 1,
        observations: "",
        total: 0
      });
    },
    ftotal(val) {
      let total = 0;
      if (val) {
        total = val.quantity * val.unit_price;
      }
      return accounting.formatMoney(total);
    },
    onChange(newVal) {
      this.$emit("change", newVal);
    },
    submit() {
      this.$set(this, "form", this.sourceForm);
      this.$set(this.form, "isInvoice", this.isInvoice);

      if (this.isInvoice === 1) {
        this.$delete(vm.form, "payment_in_to_category", []);
        this.$set(this.form, "pending_payment_in", this.qdata);
      } else {
        this.$delete(this.form, "pending_payment_in", []);
        this.$set(this.form, "payment_in_to_category", this.qdata);
      }
      console.log(this.form);
      this.create();
    },
    create() {
      let vm = this;
      vm.isProcessing = true;

      axios
        .post("/api" + vm.path, vm.form)
        .then(function(response) {
          if (response.data.created) {
            vm.$router.push(vm.path + response.data.id);
          }
          vm.isProcessing = false;
          Toast.create.positive("Se ha creado el pago exitosamente");
        })
        .catch(function(error) {
          vm.isProcessing = false;
          if (error.response.data.message) {
            Toast.create.negative(error.response.data.message[0]);
          }
        });
    },

    update() {
      let vm = this;
      vm.isProcessing = true;

      axios
        .put(vm.path + vm.form.id, vm.form)
        .then(function(response) {
          if (response.data.updated) {
            vm.$router.push(vm.path + response.data.id);
          }
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
          Vue.set(vm.$data, "errors", error.response.data);
        });
    }
  },
  created() {
    if (this.isInvoice === "1") {
      this.columns = invoiceColumns();
    } else {
      this.columns = categoryColumns();
    }
  },
  data() {
    return {
      styleButton: {
        border: 0,
        padding: 0
      },
      form: {},
      columns: [],
      isProcessing: false,
      path: "/payment-in/"
    };
  }
};
</script>

