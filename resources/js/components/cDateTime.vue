<template>
    <q-datetime :color="color" monday-first  @change="handleChange"
    :value="value" :clear-label="clearLabel" :ok-label="okLabel" 
    :cancel-label="cancelLabel" :month-names="monthNames" 
    :day-names="dayNames" :float-label="stackLabel"
    :default-selection="value" />
</template>
<script type="text/javascript">


export default {
    data() {
        return {
            color: 'secondary',
            clearLabel: 'Borrar',
            okLabel: 'Establecer',
            cancelLabel: 'Cancelar',
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            dayNames: ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado']

        }
    },
    props: ['value', 'stackLabel'],
    methods: {
        handleChange(newVal) {
            this.$emit('input', newVal)
        }
    }
}
</script>
