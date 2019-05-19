<template>
    <div class="layout-padding">

        <q-toolbar inverted color="secondary">
            <q-toolbar-title>
                <h5>
                    <b>FACTURA A PROVEEDORES No: {{public_id}}</b>
                </h5>

            </q-toolbar-title>

            <q-btn class="within-iframe-hide" color="orange" flat @click="$router.replace(`/${model}`)">
                <q-icon name="keyboard_arrow_left" />REGRESAR
            </q-btn>
            <q-btn class="within-iframe-hide" flat @click="$router.push(`/${model}/create`)">
                <q-icon name="add_circle_outline" />NUEVA FACTURA
            </q-btn>

        </q-toolbar>
        <div class="row justify-center mobile-only">
            <div style="width: 500px; max-width: 90vw;">
                <q-fixed-position corner="top-right" :offset="[16, 16]">
                    <q-btn round color="secondary" @click="mobileMenu($refs)" icon="add" class="animate-pop" />
                </q-fixed-position>
            </div>
        </div>
        <q-fixed-position class="desktop-only" corner="top-right" :offset="[16, 16]">
            <q-fab color="secondary" active-icon="close" direction="down" class="animate-pop">
                <q-fab-action color="lime-14" @click="pdf()" icon="attach_money">
                    <q-tooltip anchor="center left" self="center right" :offset="[20, 0]">Agregar Pago</q-tooltip>
                </q-fab-action>
                <q-fab-action color="green-6" @click="edit()" icon="edit">
                    <q-tooltip anchor="center left" self="center right" :offset="[20, 0]">Editar</q-tooltip>
                </q-fab-action>
                <q-fab-action color="green-6" @click="clone()" icon="content_copy">
                    <q-tooltip anchor="center left" self="center right" :offset="[20, 0]">Clonar</q-tooltip>
                </q-fab-action>
                <q-fab-action color="amber-6" @click="pdf()" icon="print">
                    <q-tooltip anchor="center left" self="center right" :offset="[20, 0]">Imprimir</q-tooltip>
                </q-fab-action>

            </q-fab>
        </q-fixed-position>

        <div class="doc-container">
            <div class="row ">
                <div class="col-sm-5">
                    <q-list style="border: 0;padding: 0">
                        <q-input v-model="contactname" disable stack-label="Cliente" />
                        <q-input v-model="data.currency_code" disable stack-label="Moneda" />
                        <q-input v-model="data.observations" type="textarea" disable stack-label="Observaciones" />                        
                    </q-list>
                </div>
                <div class="col-sm-1">
                </div>
                <div class="col-sm-5">
                    <q-list style="border: 0;padding: 0">
                        <q-input v-model="data.date" disable stack-label="Fecha de creación" />
                        <q-input v-model="data.due_date" disable stack-label="Fecha de vencimiento" />
                        <q-field label="Estado: " :label-width="2">
                            <status :id="data.status_id"></status>
                        </q-field>
                        <q-separator></q-separator>
                        <q-btn flat class="within-iframe-hide" color="positive" flat @click="LoadFiles($refs)">
                            <q-icon size="1rem" name="attach_file" />
                            <small style='text-decoration: underline'>Gestionar Documentos</small>
                        </q-btn>
                    </q-list>
                </div>
            </div>

        </div>
        <q-tabs color="green-5">
            <q-tab default slot="title" name="tab-1" label="Detalle"/>
            <q-tab slot="title" name="tab-2"  label="Pagos asociados"/>
            <q-tab-pane name="tab-1">
                 <datatableShow :qdata="table" module="outcome"></datatableShow>
                 <totals :subtotal="data.sub_total" :discounts="data.total_discounts" :taxes="totalTaxes" :total="data.total" :isTaxArray="true"></totals>
            </q-tab-pane>
            <q-tab-pane name="tab-2">
                <paymentassociated :qdata="payments"></paymentassociated>
            </q-tab-pane>
        </q-tabs>

        <attachfiles ref="_attachfile"></attachfiles>
    </div>
</template>

<script>
import {
    QInput, QField, QSlider,
    QBtn, QIcon, QTooltip,
    clone, QToolbar, QToolbarTitle,
    QItemSeparator, QFixedPosition,
    QFab, QFabAction, QList, QModal,
    ActionSheet, Ripple, QTabs, QTab,QTabPane
} from 'quasar-framework/dist/quasar.mat.esm'

import totals from '../../components/tables/Total.vue'

import axios from 'axios'
import moment from 'moment'
moment.locale('es');

import datatableShow from '../../components/tables/Datatable-Show.vue'

import attachfiles from '../../components/modals/AttachFiles.vue'

import status from '../../components/status/Bill.vue'

import paymentassociated from './payment_associated.vue'

function showActionSheetWithIcons(vm, ref) {
    ActionSheet.create({
        title: 'Otras acciones',
        galery: true,
        actions: [
            {
                label: 'Agregar Pago',
                icon: 'attach_money',
                handler() {

                }
            },
            {
                label: 'Editar',
                icon: 'edit',
                handler() {
                    vm.edit()
                }
            },
            {
                label: 'Clonar',
                icon: 'content_copy',
                handler() {
                    vm.clone()
                }
            },
            {
                label: 'Imprimir',
                icon: 'print',
                handler() {
                    vm.pdf()
                }
            },
            {
                label: 'SALIR',
                color: 'green'
            }
        ],
        dismiss: {
            label: 'Cancel',
        }
    })
}

export default {
    directives: {
        Ripple
    },
    components: {
        datatableShow, QInput, totals,
        QSlider, QBtn, QIcon, QTabs, QTab,QTabPane,
        QTooltip, QToolbar, QField,
        QToolbarTitle, QItemSeparator,
        QFixedPosition, QFab,
        QFabAction, QList, QModal, attachfiles, status,paymentassociated
    },
    created() {
        this.fetchData();
    },
    data() {
        return {
            state: 'ABIERTA',
            model: 'bill',
            path: `bill/${this.$route.params.id}`,
            data: {},
            listprice: '',
            contactname: '',
            seller: '',
            totalTaxes: 0,
            table: [],
            pathEmailData: '',
            payments:[]
        }
    },
    watch: {
        '$route': 'fetchData',
    },
    computed: {
        public_id() {
            return this.$route.params.id
        }
    },
    methods: {
        mobileMenu(ref) {
            showActionSheetWithIcons(this, ref)
        },
        LoadFiles(refs) {
            refs._attachfile.open(this.$route.params.id, this.model);
        },
        edit() {
            this.$router.push(`/${this.path}/edit`)
        },
        clone() {
            this.$router.push(`/${this.path}/clone`)
        },
        pdf() {
            window.open(`/api/${this.model}/${this.public_id} /pdf`, '_blank');
        },
        fetchData() {
            var vm = this;
            axios.get(`/api/${this.path}`)
                .then(function(response) {
                    console.log(response.data);
                    vm.$set(vm, 'data', response.data.model)
                    vm.$set(vm, 'totalTaxes', response.data.totalTaxes)
                    if (vm.data.list_price) {
                        vm.$set(vm, 'listprice', vm.data.list_price.name)
                    }
                    if (vm.data.contact) {
                        vm.$set(vm, 'contactname', vm.data.contact.name)
                    }
                    if (vm.data.seller) {
                        vm.$set(vm, 'seller', vm.data.seller.name)
                    }
                   
                    if (response.data.payments) {
                        vm.$set(vm, 'payments', response.data.payments)
                    }
                    vm.$set(vm, 'table', vm.data.detail)
                })
                .catch(function(error) {
                    // console.log(error);
                })
        }

    }
}
</script>

<style>
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
