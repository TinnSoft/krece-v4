<template>

      <div >
          <q-markup-table flat bordered dense>
              <thead >
                  <tr class="bg-light-blue-1">
                      <th>PRODUCTO</th>
                      <th>DESCRIPCIÓN</th>
                      <th>PRECIO</th>
                      <th>CANTIDAD</th>
                      <th>DESCUENTO (%)</th>
                      <th>IMPUESTO (%)</th>
                      <th>TOTAL</th>
                  </tr>
              </thead>
              <tbody>
                  <tr  v-for="(_detail, index) in form.detail" :key="index">                      
                      <td>   
                          <q-field borderless bottom-slots dense hide-bottom-space>
                            <template v-slot:before>
                              <q-btn @click="remove(_detail)" round dense flat icon="delete" ></q-btn>
                            </template>
                    
                            <template v-slot:control>
                              <kSelectFilter
                                      :error="checkIfFieldHasError(errors,['detail.' + index + '.product_id'])"
                                              v-model="_detail.product" 
                                              :options="base.products"
                                              @input="onChangeProduct(_detail)" 
                                              filled
                                              dense
                                              outlined
                                              self-filter
                                              clearable
                                              use-input
                                              fill-input
                                              hide-selected
                                              emit-value
                                              map-options
                                              input-debounce="0"
                                              options-dense
                                              hide-bottom-space
                                            >                          
                                </kSelectFilter>
                            </template>
                          </q-field>

                         
                      </td>
                      
                      <td>
                          <q-input autogrow
                                dense
                                hide-bottom-space
                                v-model="_detail.description">
                          </q-input>
                      </td>
                      <td>
                         <!-- <kCurrencyInput
                          :val="_detail.unit_price"
                          v-model="_detail.unit_price"
                          clearable
                          :error="checkIfFieldHasError(errors,['detail.' + index + '.unit_price'])" 
                          @input="_detail.unit_price"
                          @blur="_detail.unit_price"
                        >
                        </kCurrencyInput>-->
                      
                          <q-input hide-bottom-space
                                   dense
                                 :error="checkIfFieldHasError(errors,['detail.' + index + '.unit_price'])" 
                                  type="number" prefix="$" v-model="_detail.unit_price">
                          </q-input>
                      </td>
                      <td>
                          <q-input dense type="number" v-model="_detail.quantity"  hide-bottom-space
                              :error="checkIfFieldHasError(errors,['detail.' + index + '.quantity'])"
                          ></q-input>
                      </td>
                      <td>
                          <q-input hide-bottom-space dense type="number" prefix="%" v-model="_detail.discount"></q-input>
                      </td>
                      <td>
                        <q-select hide-bottom-space dense  autofocus-filter filter filter-placeholder="Buscar impuesto" 
                         v-model="_detail.tax_id" :value="_detail.tax_id" @input="onChangeTax(_detail)" :options="base.taxes"></q-select>                        
                      </td>
                      <td>
                          <q-input hide-bottom-space dense disable :value="totalByLine(_detail)"></q-input>
                      </td>                    
                  </tr>
                  <tr>
                    <td class colspan="100%">
                        <q-btn @click="addLine" flat rounded no-wrap color="purple" label="AGREGAR ITEM" icon="add"></q-btn>
                    </td>
                  </tr>
                  <tr>
                    <td class colspan="100%" align="right">                   
                      <cTotals :subtotal="subTotal" :discounts="DiscountsTotal" :taxes="TaxesTotal" :total="grandTotal"></cTotals>
                    </td>
                  </tr>
              </tbody>
          </q-markup-table>
      </div>         

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
  created() {
  },
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
      return accounting.formatMoney(total);
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
