<template>
    <q-toggle color="secondary" :value="isChecked" checked-icon="lock_open" unchecked-icon="lock_outline" @blur="handleClick">
        <q-tooltip>
            {{tooltipText}}
        </q-tooltip>
    </q-toggle>
</template>
<script type="text/javascript">


export default {
    props: ['id','isActive'],
    computed: {
        isChecked() {            
            if (this.id === 2 || this.isActive === 0) {    
                return false
            }
            return true
        },
        tooltipText() {
            if (this.id === 2|| this.isActive === 0) {
                return 'Activar'
            }
            return 'Anular'
        }
    },
     methods: {
        handleClick(newVal) {
            this.$emit('blur', newVal)
        }
    },
}
</script>
