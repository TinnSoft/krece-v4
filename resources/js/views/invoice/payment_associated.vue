<template>
    <q-table 
        dense 
        :data="qdata" 
        table-header-class="bg-light-blue-1"
        flat     
        bordered
        :columns="columns" 
        no-data-label="No se han realizado pagos">
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
                    }
                },
                {
                    label: 'Recibo de Caja #',
                    field: 'resolution_id',
                },
                {
                    label: 'Estado',
                    field: 'status_id',
                },
                {
                    label: 'Método de Pago',
                    field: 'payment_method',
                },
                {
                    label: 'Monto',
                    field: 'total_payed',
                    format(value) {
                        return accounting.formatMoney(value);
                    },
                },
                {
                    label: 'Observaciones',
                    field: 'observations',
                },
            ],
            pagination: true,
        }
    },
}
</script>
