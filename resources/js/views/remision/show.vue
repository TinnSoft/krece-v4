<template>
    <div class="layout-padding">
        <kToolbar toolbarlabel="REMISION No: " :documentId="public_id" :redirectTo="`/${model}`" @click="$router.push(`/${model}/create`)"
        label2="NUEVA REMISION" icon2="add_circle_outline"></kToolbar>     

        
        <div class="row justify-center mobile-only">
            <div style="width: 500px; max-width: 90vw;">
                <q-fixed-position corner="top-right" :offset="[16, 16]">
                    <q-btn round color="secondary" @click="mobileMenu($refs)" icon="add" class="animate-pop" />
                </q-fixed-position>
            </div>
        </div>
        <q-fixed-position class="desktop-only" corner="top-right" :offset="[16, 16]">
            <q-fab color="secondary" active-icon="close" direction="down" class="animate-pop">
                <q-fab-action color="lime-14" @click="pdf()" icon="control_point_duplicate">
                    <q-tooltip anchor="center left" self="center right" :offset="[20, 0]">Convertir en factura </q-tooltip>
                </q-fab-action>
                <q-fab-action color="green-6" @click="email($refs)" icon="mail">
                    <q-tooltip anchor="center left" self="center right" :offset="[20, 0]">Enviar por email</q-tooltip>
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
                        <q-input v-model="seller" disable stack-label="Vendedor" />
                        <q-input v-model="data.observations" type="textarea" disable stack-label="Observaciones" />
                        <q-input v-model="listprice" disable stack-label="Lista de precios" />
                        <q-input v-model="data.currency_code" disable stack-label="Moneda" />
                    </q-list>
                </div>
                <div class="col-sm-1">
                </div>
                <div class="col-sm-5">
                    <q-list style="border: 0;padding: 0">
                        <q-input v-model="data.date" disable stack-label="Fecha de creación" />
                        <q-input v-model="data.due_date" disable stack-label="Fecha de vencimiento" />
                        <q-input v-model="data.notes" type="textarea" disable stack-label="Notas" />
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
        <datatableShow :qdata="table"></datatableShow>
        <totals :subtotal="data.sub_total" :discounts="data.total_discounts" :taxes="totalTaxes" :total="data.total" :isTaxArray="true" ></totals>
        <sendemail ref="_sendEmail"></sendemail>
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
    ActionSheet, Ripple
} from 'quasar-framework/dist/quasar.mat.esm'

import totals from '../../components/tables/Total.vue'
import kToolbar from '../../components/Toolbar.vue'

import axios from 'axios'
import moment from 'moment'
moment.locale('es');

import datatableShow from '../../components/tables/Datatable-Show.vue'
import sendemail from '../../components/modals/SendEmailForm.vue'

import attachfiles from '../../components/modals/AttachFiles.vue'

import status from '../../components/status/Remision.vue'

function showActionSheetWithIcons(vm, ref) {
    ActionSheet.create({
        title: 'Otras acciones',
        galery: true,
        actions: [
            {
                label: 'Convertir en factura',
                icon: 'control_point_duplicate',
                handler() {

                }
            },
            {
                label: 'Enviar por email',
                icon: 'email',
                handler() {
                    vm.email(ref)
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
        datatableShow, QInput, totals,kToolbar,
        QSlider, QBtn, QIcon,
        QTooltip, QToolbar, QField,
        QToolbarTitle, QItemSeparator,
        QFixedPosition, QFab, sendemail,
        QFabAction, QList, QModal, attachfiles, status
    },
    created() {
        this.fetchData();
    },
    data() {
        return {
            state: 'ABIERTA',
            model: 'remision',
            path: `remision/${this.$route.params.id}`,
            data: {},
            listprice: '',
            contactname: '',
            seller: '',
            totalTaxes: 0,
            table: [],
            pathEmailData: 'remision_EmailToCustomer'
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
        email(refs) {
            refs._sendEmail.open(this.$route.params.id, this.pathEmailData, this.model);
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
