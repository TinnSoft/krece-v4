<template>
      <q-tabs color="grey-1" text-color="positive" no-pane-border>
          <q-tab default name="__detail" slot="title" :label="tabLabel" />
          <q-tab-pane keep-alive name="__detail">
            <div class="q-table-container q-table-dense">
            <div class="q-table-middle scroll">
            <table class="q-table q-table-horizontal-separator ">
              <thead >
                  <tr class style="text-align: left;">
                      <th class="text-center q-table-col-auto-width">PRODUCTO</th>
                      <th>DESCRIPCIÓN</th>
                      <th>PRECIO</th>
                      <th>CANTIDAD</th>
                      <th>DESCUENTO (%)</th>
                      <th>IMPUESTO (%)</th>
                      <th>TOTAL</th>
                  </tr>
              </thead>
              <tbody slot="body" >
                  <tr v-for="(_detail, index) in form.detail" :key="index" style="border-bottom: 1px solid #ddd;">
                      
                      <td>   
                        <div class="row items-center justify-between no-wrap">
                          <button 
                            @click="remove(_detail)"
                            tabindex="0" 
                            type="button" 
                            class="q-btn inline relative-position q-btn-item non-selectable q-mr-xs q-btn-round 
                            q-focusable q-hoverable bg-secondary text-white q-btn-dense" 
                            style="font-size: 10px;">
                            <div class="q-focus-helper">
                            </div>
                            <div class="q-btn-inner row col items-center justify-center">
                              <i aria-hidden="true" class="q-icon material-icons">remove</i>
                            </div>
                          </button>                         
                          <div>                
                            <q-field :error="checkIfFieldHasError(errors,['detail.' + index + '.product_id'])" error-label="Seleccione un producto">
                                  <q-select 
                                    style="width: 12em;"                                       
                                    autofocus-filter filter 
                                    filter-placeholder="Buscar producto" 
                                    v-model="_detail.product_id" 
                                    @input="onChangeProduct(_detail)" 
                                    :options="base.products" />
                              </q-field>   
                          </div>
                        </div>         
                      </td>
                      
                      <td>
                          <q-field>
                              <q-input style="width: 12em;" v-model="_detail.description" />
                          </q-field>
                      </td>
                      <td >
                          <q-field  :error="checkIfFieldHasError(errors,['detail.' + index + '.unit_price'])" :error-label="label_required_field">
                              <q-input style="width: 8em" type="number" prefix="$" v-model="_detail.unit_price" />
                          </q-field>
                      </td>
                      <td >
                          <q-field  :error="checkIfFieldHasError(errors,['detail.' + index + '.quantity'])" :error-label="label_required_field">
                              <q-input  style="width: 7em" type="number" v-model="_detail.quantity" />
                          </q-field>
                      </td>
                      <td  >
                          <q-field >
                              <q-input style="width: 4em" type="number" prefix="%" v-model="_detail.discount" />
                          </q-field>
                      </td>
                      <td >
                        <q-select style="width: 6em"  autofocus-filter filter filter-placeholder="Buscar impuesto" 
                         v-model="_detail.tax_id" :value="_detail.tax_id" @input="onChangeTax(_detail)" :options="base.taxes" />                        
                      </td>
                      <td >
                          <q-field >
                              <q-input style="width: 10em" disable type="number" prefix="$" :value="totalByLine(_detail)" />
                          </q-field>
                      </td>                    
                  </tr>
                  <tr>
                    <td class colspan="100%">
                        <q-btn @click="addLine" flat rounded no-wrap color="deep-orange" label="NUEVO ITEM" icon="add"></q-btn>
                    </td>
                  </tr>
                  <tr>
                    <td class colspan="100%" align="right">                   
                      <cTotals :subtotal="subTotal" :discounts="DiscountsTotal" :taxes="TaxesTotal" :total="grandTotal"></cTotals>
                    </td>
                  </tr>
              </tbody>
            </table>
            </div>
            </div>
          </q-tab-pane>
        </q-tabs>   
</template>
<script type="text/javascript">
import cTotals from "../../components/tables/cTotal.vue";

export default {
  middleware: "auth",
  props: {
    errors: {},
    form: {},
    base: {
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
      ]
    },
    tabLabel:""
  },
  data() {
    return {
      label_required_field: "Este Campo es Obligatorio"
    };
  },
  components: {
    cTotals
  },
  created() {},
  computed: {
    subTotal() {
      var vm = this;
      var _subtotal = 0;
      if (vm.form.detail) {
        _subtotal = vm.form.detail.reduce(function(carry, detail) {
          return (
            carry + parseFloat(detail.quantity) * parseFloat(detail.unit_price)
          );
        }, 0);
      }
      _subtotal = isNaN(_subtotal) ? 0 : _subtotal;
      this.form.sub_total = _subtotal;
      return accounting.formatMoney(_subtotal);
    },

    DiscountsTotal() {
      var discountsTot = 0;
      if (this.form.detail) {
        discountsTot = this.form.detail.reduce(function(carry, detail) {
          return (
            carry +
            parseFloat(detail.quantity) *
              parseFloat(detail.unit_price) *
              parseFloat(detail.discount) /
              100
          );
        }, 0);
      }

      discountsTot = isNaN(discountsTot) ? 0 : discountsTot;
      this.form.total_discounts = discountsTot;
      return accounting.formatMoney(discountsTot);
    },

    TaxesTotal() {
      var TaxTot = 0;

      if (this.form.detail) {
        TaxTot = this.form.detail.reduce(function(carry, detail) {
          return (
            carry +
            (parseFloat(detail.quantity) * parseFloat(detail.unit_price) -
              parseFloat(detail.quantity) *
                parseFloat(detail.unit_price) *
                parseFloat(detail.discount) /
                100) *
              parseFloat(
                isNaN(detail.tax_amount) ||
                detail.tax_amount == "" ||
                detail.tax_amount == null
                  ? 0
                  : detail.tax_amount
              ) /
              100
          );
        }, 0);
      }
      TaxTot = isNaN(TaxTot) ? 0 : TaxTot;
      this.form.total_taxes = TaxTot;
      return accounting.formatMoney(TaxTot);
    },

    grandTotal() {
      var totalval =
        (isNaN(this.form.sub_total) ? 0 : parseFloat(this.form.sub_total)) -
        (isNaN(this.form.total_discounts)
          ? 0
          : parseFloat(this.form.total_discounts)) +
        (isNaN(this.form.total_taxes) ? 0 : parseFloat(this.form.total_taxes));

      totalval = isNaN(totalval) ? 0 : totalval;
      this.form.total = totalval;
      return accounting.formatMoney(totalval);
    }
  },
  methods: {
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
    onChangeTax(val) {
      if (val.tax_id) {
        var vm = this;
        vm.base.taxes.forEach(function(item) {
          if (item.id == val.tax_id) {
            val.tax_amount = item.amount;
          }
        });
      } else {
        val.tax_amount = 0;
        val.tax_id = "";
      }
    },
    onChangeProduct(val) {
      if (val.product_id) {
        var vm = this;
        vm.base.products.forEach(function(item) {
          if (item.id == val.product_id) {
            val.product_id = item.id;
            val.description = item.description;
            val.unit_price = item.sale_price;
            val.reference = item.reference;
          }
        });
      } else {
        val.product_id = "";
        val.description = "";
        val.unit_price = 0;
        val.reference = "";
      }
    },
    addLine() {
      this.form.detail.push({
        product_id: null,
        name: "",
        description: "",
        unit_price: 0,
        discount: 0,
        quantity: 1,
        tax_id: null,
        tax_amount: 0,
        total_tax: 0
      });
    },
    remove(detail) {
      // prevent removal of last item
      if (this.form.detail.length > 1) {
        var index = this.form.detail.indexOf(detail);
        this.form.detail.splice(index, 1);
      }
    }
  }
};
</script>
