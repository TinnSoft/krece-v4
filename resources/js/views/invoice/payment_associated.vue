<template>
    <q-table dense :data="qdata" :columns="columns" no-data-label="No se han realizado pagos">
        <template slot="col-status_id" slot-scope="cell">
            <cStatus :id="cell.row.status_id"></cStatus>
        </template>

    </q-table>
</template>
<script type="text/javascript">


import cStatus from '../../components/status/cStatus.vue'

export default {
    components: {
        cStatus
    },
    props: ['qdata'],
    data() {
        return {
            estimate: {},           
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
                    label: 'Recibo de Caja #',
                    field: 'resolution_id',
                    type: 'string',
                    width: '50px'
                },
                {
                    label: 'Estado',
                    field: 'status_id',
                    width: '70px',
                    type: 'string',
                },
                {
                    label: 'Método de Pago',
                    field: 'payment_method',
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
                    width: '70px'
                },
                {
                    label: 'Observaciones',
                    field: 'observations',
                    width: '90px',
                    type: 'string',
                },
            ],
            pagination: true,
        }
    },
}
</script>
