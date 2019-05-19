<template>
    <q-data-table :data="qdata" :config="config" :columns="columns">
        <template slot="col-status_id" slot-scope="cell">
            <InvoiceStatus :id="cell.row.status_id"></InvoiceStatus>
        </template>

    </q-data-table>
</template>
<script type="text/javascript">
import {
    QDataTable
} from 'quasar-framework/dist/quasar.mat.esm'

import accounting from 'accounting'
import InvoiceStatus from '../../components/status/Invoice.vue'
import moment from 'moment'
moment.locale('es');

export default {
    components: {
        QDataTable, InvoiceStatus
    },
    props: ['qdata'],
    data() {
        return {
            estimate: {},
            config: {
                refresh: false,
                noHeader: false,
                columnPicker: false,
                leftStickyColumns: 0,
                rightStickyColumns: 0,
                bodyStyle: {
                    maxHeight: '500px'
                },
                rowHeight: '35px',
                responsive: true,
                pagination: {
                    rowsPerPage: 10,
                    options: [5, 10, 15, 30, 50, 500]
                },
                labels: {
                    columns: 'Columnas',
                    allCols: 'Todas',
                    rows: 'Mostrar ',
                    selected: {
                        singular: 'item seleccionado.',
                        plural: 'items seleccionados.'
                    },
                    clear: 'Limpiar',
                    search: 'Buscar',
                    all: 'Todo'
                },
                messages: {
                    noData: 'Esta factura no tiene pagos relacionados aún..',
                    noDataAfterFiltering: 'No se encontraron coincidencias con la busqueda. Porfavor revise los valores ingresados.'
                },
            },
            columns: [
                {
                    label: 'Fecha',
                    field: 'date',
                     format(value) {
                        return moment(value).format('MMMM Do YYYY');
                    },                   
                    width: '70px',
                    type: 'text'
                },
                {
                    label: 'Comp. de Egreso #',
                    field: 'resolution_id',
                    type: 'string',
                    width: '70px'
                },
                {
                    label: 'Estado',
                    field: 'status_id',
                    width: '70px',
                    type: 'string',
                },
                {
                    label: 'Monto',
                    field: 'total_payed',
                    format(value) {
                        return accounting.formatMoney(value);
                    },
                    type: 'string',
                    width: '100px'
                },
                {
                    label: 'Observaciones',
                    field: 'observations',
                    width: '100px',
                    type: 'string',
                },
            ],
            pagination: true,
            rowHeight: 50,
            bodyHeightProp: 'maxHeight',
            bodyHeight: 500,
        }
    },
    watch: {
        pagination(value) {
            if (!value) {
                this.oldPagination = clone(this.config.pagination)
                this.config.pagination = false
                return
            }
            this.config.pagination = this.oldPagination
        },
        rowHeight(value) {
            this.config.rowHeight = value + 'px'
        },
        bodyHeight(value) {
            let style = {}
            if (this.bodyHeightProp !== 'auto') {
                style[this.bodyHeightProp] = value + 'px'
            }
            this.config.bodyStyle = style
        },
        bodyHeightProp(value) {
            let style = {}
            if (value !== 'auto') {
                style[value] = this.bodyHeight + 'px'
            }
            this.config.bodyStyle = style
        }
    },
    methods: {

    }
}
</script>
