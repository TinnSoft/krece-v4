<template>
<!--v-bind:style="styleButton"-->
    <q-btn flat :color="color" dense rounded :icon="iconname" @click="handleClick" :disabled="isChecked" class="q-mr-xs">
        <q-tooltip>
            {{tooltiplabel}}
        </q-tooltip>
    </q-btn>
</template>

<script>

export default {
    props: ['color', 'statusID', 'iconname', 'tooltiplabel'],
    data() {
        return {
            styleButton: {
                border: 0,
                padding: 0
            }
        }
    },
    methods: {
        handleClick(newVal) {
            this.$emit('click', newVal)
        }
    },
    computed: {
        isChecked() {
            if (this.statusID === 2) {
               return true;
            }
            return false;
        },

    }
}
</script>
