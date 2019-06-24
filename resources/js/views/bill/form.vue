<template>
    <div class="layout-padding">

        <q-toolbar inverted color="secondary">
            <q-toolbar-title>
                <h5>
                    <b>{{toolbarlabel}} {{form.resolution_id}}</b>
                </h5>
            </q-toolbar-title>

            <q-btn class="within-iframe-hide" color="orange" flat @click="$router.replace(`${redirect}`)">
                <q-icon name="keyboard_arrow_left" />REGRESAR
            </q-btn>
            <q-btn @click="submit" class="within-iframe-hide" flat color="secondary">
                <q-icon name="add" /> GUARDAR
            </q-btn>

        </q-toolbar>

        <q-separator color="secondary" />

        <div class="doc-container">
            <div class="row ">
                <div class="col-sm-5">
                    <q-list style="border: 0;padding: 0">

                        <q-field :error="checkIfFieldHasError(errors, 'customer_id')" error-label="Este campo es obligatorio">
                            <q-select color="secondary" filter filter-placeholder="Buscar" stack-label="*Proveedor" v-model="form.customer_id" :options="base.contacts" />
                        </q-field>
                        <q-field :error="checkIfFieldHasError(errors,'date')" error-label="Seleccione una fecha válida">
                            <kDateTime v-model="form.date" stackLabel="*Fecha (Año-Mes-Dia)"></kDateTime>
                        </q-field>

                        <q-field :error="checkIfFieldHasError(errors,'due_date')" error-label="Seleccione una fecha válida">
                            <kDateTime v-model="form.due_date" stackLabel="*Fecha de vencimiento (Año-Mes-Dia)"></kDateTime>
                        </q-field>

                    </q-list>
                </div>
                <div class="col-sm-1">
                </div>
                <div class="col-sm-5">
                    <q-list style="border: 0;padding: 0">
                        <q-field :error="checkIfFieldHasError(errors,'currency_code')" error-label="Este campo es obligatorio">
                            <q-select color="secondary" stack-label="*Moneda" v-model="form.currency_code" :options="base.currency" />
                        </q-field>
                        <q-input color="secondary" type="textarea" v-model="form.observations" stack-label="Observaciones" />
                        <!--Agregar nuevos archivos-->
                        <q-btn v-if="(processType == 'edit')" flat class="within-iframe-hide" color="positive" flat @click="loadFiles($refs)">
                            <q-icon size="1rem" name="attach_file" />
                            <small>Gestionar Documentos</small>
                        </q-btn>
                    </q-list>
                </div>
            </div>
        </div>

        <table class="q-table responsive bordered compact highlight horizontal-separator striped" style="width: 100%;">
            <thead>
                <tr style="text-align: left;">
                    <th colspan="2">CATEGORÍA</th>
                    <th>DESCRIPCIÓN</th>
                    <th>PRECIO</th>
                    <th>CANTIDAD</th>
                    <th>DESCUENTO</th>
                    <th>IMPUESTO</th>
                    <th>TOTAL</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(_detail, index) in form.detail">
                    <td style="width: 1em">
                        <a @click="remove(_detail)">
                            <q-icon name="delete_forever" color="red" size="20px" />
                        </a>
                    </td>
                    <td data-th="PRODUCTO" style="width: 12em">
                        <q-field :error="checkIfFieldHasError(errors,['detail.' + index + '.category_id'])" error-label="Seleccione un ÍTEM">
                            <q-select class="no-margin no-padding" filter filter-placeholder="Buscar ítem" v-model="_detail.category_id" :options="base.products" />
                        </q-field>
                    </td>

                    <td data-th="DESCRIPCIÓN" style="width: 12em">
                        <q-field>
                            <q-input class="no-margin no-padding" v-model="_detail.description" />
                        </q-field>
                    </td>
                    <td data-th="PRECIO" style="width: 8em">
                        <q-field :error="checkIfFieldHasError(errors,['detail.' + index + '.unit_price'])" error-label="Obligatorio">
                            <q-input class="no-margin no-padding" type="number" prefix="$" v-model="_detail.unit_price" />
                        </q-field>
                    </td>
                    <td data-th="CANTIDAD" style="width: 7em">
                        <q-field :error="checkIfFieldHasError(errors,['detail.' + index + '.quantity'])" error-label="Obligatorio">
                            <q-input class="no-margin no-padding" type="number" v-model="_detail.quantity" />
                        </q-field>
                    </td>
                    <td data-th="DESCUENTO" style="width: 4em">
                        <q-field>
                            <q-input class="no-margin no-padding" type="number" prefix="%" v-model="_detail.discount" />
                        </q-field>
                    </td>
                    <td data-th="IMPUESTO" style="width: 6em">
                        <q-field>
                            <q-select @change="onChangeTax(_detail)" class="no-margin no-padding" filter filter-placeholder="Buscar impuesto" v-model="_detail.tax_id" :options="base.taxes" />
                        </q-field>
                    </td>
                    <td data-th="TOTAL" style="width: 8em">
                        <q-field>
                            <q-input class="no-margin no-padding" disable type="number" prefix="$" :value="totalByLine(_detail)" />
                        </q-field>
                    </td>
                </tr>
            </tbody>
        </table>
        <q-btn class="within-iframe-hide" @click="addLine" flat color="deep-orange">
            <q-icon name="add" /> NUEVA LINEA
        </q-btn>
        <!--<pre><code>{{$data.form}}</code></pre>-->
        <totals :subtotal="subTotal" :discounts="DiscountsTotal" :taxes="TaxesTotal" :total="grandTotal"></totals>

        <kAttachFiles ref="_attachfile"></kAttachFiles>
    </div>
</template>

<script>
import Multiselect from 'vue-multiselect'
import moment from 'moment'
moment.locale('es');

import totals from '../../components/tables/Total.vue'

import {
    QDataTable, QInput, QSlider,
    QBtn, QIcon, QTooltip, clone,
    QToolbar, QToolbarTitle, QItemSeparator,
    QFixedPosition, QFab, QFabAction, QList,
    date, QSelect, QItemSide, QItemMain,
    Ripple, Toast, QItem, QItemTile, QField,
    QSpinnerGears, Loading
} from 'quasar-framework/dist/quasar.mat.esm'

import axios from 'axios'
const { addToDate } = date

import kDateTime from '../../components/DateTime.vue'

import accounting from 'accounting'



export default {

    data() {
        return {
            form: {},
            base: {
                contacts: [{
                    label: '',
                    value: ''
                }],
                currency: [{
                    label: 'COP',
                    value: 'COP'
                }],
                products: [{
                    label: '',
                    value: ''
                }],
                taxes: [{
                    label: '',
                    value: ''
                }],
            },
            select: null,
            value: null,
            options: [],
            redirect: '/bill',
            toolbarlabel: 'NUEVA FACTURA DE PROVEEDOR No: ',
            path: 'bill/create',
            store: 'bill',
            method: 'post',
            processType: 'create',
            showManualNumber: false
        }
    },
    components: {
        QInput, QField, QSlider,
        QBtn, totals, QIcon, QTooltip, QToolbar,
        QToolbarTitle, QItemSeparator,
        QFixedPosition, QItem, QItemTile, QFab,
        QFabAction, QList, Multiselect,
        QSelect, kDateTime, QDataTable, QItemSide, QItemMain,
        Ripple, QSpinnerGears
    },
    created() {
        if (this.$route.meta.mode === 'edit') {
            this.path = `bill/${this.$route.params.id}/edit`
            this.store = `bill/${this.$route.params.id}`
            this.method = 'put'
            this.button = 'Guardar'
            this.toolbarlabel = 'EDITAR FACTURA DE PROVEEDOR No: '
            this.processType = "edit"
        } else if (this.$route.meta.mode === 'clone') {
            this.path = `bill/${this.$route.params.id}/edit?convert=clone`
            this.store = `bill`
            this.method = 'post'
            this.toolbarlabel = 'CLONAR FACTURA DE PROVEEDOR No: '
            this.processType = "clone"
        }
        this.fetchData();
    },
    computed: {
        subTotal() {
            var vm = this;
            var _subtotal = 0
            if (vm.form.detail) {
                _subtotal = vm.form.detail.reduce(function(carry, detail) {
                    return carry + (parseFloat(detail.quantity) * parseFloat(detail.unit_price));
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
                    return carry + (((parseFloat(detail.quantity) * parseFloat(detail.unit_price)) * parseFloat(detail.discount))) / 100;
                }, 0);
            }

            discountsTot = isNaN(discountsTot) ? 0 : discountsTot
            this.form.total_discounts = discountsTot;
            return accounting.formatMoney(discountsTot);
        },

        TaxesTotal() {
            var TaxTot = 0;

            if (this.form.detail) {
                TaxTot = this.form.detail.reduce(function(carry, detail) {
                    return carry + ((((parseFloat(detail.quantity) * parseFloat(detail.unit_price))
                        - ((parseFloat(detail.quantity) * parseFloat(detail.unit_price)) * parseFloat(detail.discount)) / 100) *
                        parseFloat(isNaN(detail.tax_amount) || detail.tax_amount == '' || detail.tax_amount == null ? 0 : detail.tax_amount))) / 100;
                }, 0);
            }
            TaxTot = isNaN(TaxTot) ? 0 : TaxTot
            this.form.total_taxes = TaxTot;
            return accounting.formatMoney(TaxTot);
        },

        grandTotal() {
            var totalval = (isNaN(this.form.sub_total) ? 0 : parseFloat(this.form.sub_total)) -
                (isNaN(this.form.total_discounts) ? 0 : parseFloat(this.form.total_discounts)) + (isNaN(this.form.total_taxes) ? 0 : parseFloat(this.form.total_taxes));

            totalval = isNaN(totalval) ? 0 : totalval
            this.form.total = totalval;
            return accounting.formatMoney(totalval);
        },
        errors() {
            return this.$store.getters.errors
        },

    },
    methods: {
        loadFiles(refs) {
            refs._attachfile.open(this.$route.params.id, 'bill');
        },
        checkIfFieldHasError(error, field) {
            try {
                if (error.errors[field]) {
                    return true
                }
            } catch (err)
            { }

            return false
        },
        totalByLine(val) {
            var total = val.quantity * val.unit_price - (val.quantity * val.unit_price * val.discount / 100)
            return total;
        },

        onChangeTax(val) {

            if (val.tax_id) {
                var vm = this;
                vm.base.taxes.forEach(function(item) {
                    if (item.id == val.tax_id) {
                        val.tax_amount = item.amount;
                    };
                });
            }
            else {
                val.tax_amount = 0;
                val.tax_id = "";
            }
        },

        showMenu() {
            showActionSheetWithIcons()
        },
        getCurrentDate() {
            var vm = this;
            if (vm.form.date == null) {
                const today = new Date()
                vm.form.date = today
                vm.form.due_date = addToDate(today, { days: 30 });
            }
        },
        addLine() {

            this.form.detail.push({
                category_id: null,
                name: '',
                description: '',
                unit_price: 0,
                discount: 0,
                quantity: 1,
                tax_id: null,
                tax_amount: 0,
                total_tax: 0
            })

        },
        remove(detail) {
            // prevent removal of last item
            if (this.form.detail.length > 1) {
                var index = this.form.detail.indexOf(detail)
                this.form.detail.splice(index, 1);
            }
        },
        fetchData() {
            let vm = this;
            axios.get(`/api/${this.path}`)
                .then(function(response) {
                    vm.$set(vm, 'form', response.data.form)
                    //console.log(response.data);
                    if (response.data.base.contacts.length > 0) {
                        vm.$set(vm.$data.base, 'contacts', response.data.base.contacts)
                    }
                    if (response.data.base.currency.length > 0) {
                        vm.$set(vm.$data.base, 'currency', response.data.base.currency)
                    }
                    if (response.data.base.taxes.length > 0) {
                        vm.$set(vm.$data.base, 'taxes', response.data.base.taxes)
                    }
                    if (response.data.base.productlist.length > 0) {
                        vm.$set(vm.$data.base, 'products', response.data.base.productlist)
                    }
                    vm.getCurrentDate();
                })
                .catch(function(error) {
                    if (error.response.data.message) {
                        Toast.create.negative(error.response.data.message)
                    }
                    if (error.response.data.redirectTo) {
                        vm.$router.replace(`${error.response.data.redirectTo}`)
                    }
                })

        },
        submit() {
            this.$set(this.form, 'processType', this.processType)
            this.$nextTick(function() {
                this.$store.dispatch('storeById', {
                    form: this.form,
                    store: this.store,
                    method: this.method,
                    redirect: this.redirect,
                    router: this.$router
                })
            })
        }
    },
    watch: {
        '$route': 'fetchData'
    },
}
</script>

<style>
th {
    background-color: #6ECD6E;
    color: white;
}


table {
    font-size: 88%;
    table-layout: auto;
    width: 100%;
}

table {
    border-collapse: separate;
    border-spacing: 2px;
}

th,
td {
    border-width: 1px;
    padding: 0.5em;
    position: relative;
    text-align: left;
}

th,
td {
    border-radius: 0.25em;
}


td {
    border-color: #FFF;
}


::-webkit-input-placeholder {
    /* Chrome/Opera/Safari */
    font-size: 80%;
}

::-moz-placeholder {
    /* Firefox 19+ */
    font-size: 80%;
}

:-ms-input-placeholder {
    /* IE 10+ */
    font-size: 80%;
}

:-moz-placeholder {
    /* Firefox 18- */
    font-size: 80%;
}

.flex-row-docs h3 {
    padding-bottom: 4px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.2);
}

.flex-row-docs .row>div {
    padding: 10px 15px;
    background: rgba(86, 61, 124, 0.15);
    border: 1px solid rgba(86, 61, 124, 0.2);
}

.flex-row-docs .row+.row {
    margin-top: 1rem;
}

.flex-row-docs .doc-container {
    padding: 15px;
    max-height: 1000px;
}

.flex-row-docs .minheight-rows .row {
    min-height: 5rem;
}

.flex-row-docs .with-bg .row {
    background: rgba(255, 0, 0, 0.1);
}
</style>
