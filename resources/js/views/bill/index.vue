<template>
    <div class="layout-padding">

        <q-toolbar inverted color="secondary">

            <q-toolbar-title>
                <h5>
                    <b>FACTURAS A PROVEEDORES</b>
                </h5>
            </q-toolbar-title>

            <q-btn flat @click="$router.push('/bill/create')">
                <q-icon name="add_circle_outline" />NUEVA FACTURA</q-btn>
        </q-toolbar>

        <kDatatable :path="path" :kmodule="modulename" :mwarning="warningmessage"
        :pathemaildata="pathEmailData" :pathToUpdateState="pathToUpdateState"></kDatatable>
    </div>
</template>

<script>


import {
    QBtn,
    QIcon,
    clone,
    QToolbar,
    QToolbarTitle
} from 'quasar-framework/dist/quasar.mat.esm'

import kDatatable from '../../components/tables/Datatable-Index.vue'


export default {
   
    components: {
        kDatatable,
        QBtn,
        QIcon,
        QToolbar,
        QToolbarTitle
    },
    methods: {

    },

    data() {
        return {
            path: 'getBillList',
            modulename: 'bill',
            warningmessage: 'Estas a punto de eliminar la Factura de proveedor # ',
            pathEmailData:'',
            pathToUpdateState:'bill_update_state'
        }
    },


}
</script>
