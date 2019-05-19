<template>
    <q-page padding>

            <q-toolbar :glossy="$q.theme === 'mat'"
                    :inverted="$q.theme === 'ios'" color="grey" >
                <q-btn flat round dense icon="menu" @click="layoutStore.left = !layoutStore.left"/>
                <q-toolbar-title>
                    CONFIGURACIÓN
                </q-toolbar-title>
            </q-toolbar>
            <q-layout ref="settingsLayout" view="lHr lpr lff" >
                
                <q-drawer
                side="left"
                v-model="layoutStore.left"
                :overlay="layoutStore.leftOverlay"
                :behavior="layoutStore.leftBehavior"
                :breakpoint="layoutStore.leftBreakpoint"
                :content-class="$q.theme === 'mat' ? 'bg-white' : null"
                >
               <q-scroll-area class="fit">
                    <q-item-label>Impuestos</q-item-label>
                    <q-item to="/settings/taxes">
                        <q-item-section icon="monetization_on" />
                        <q-item-label label="Impuestos" />
                        <q-item-section right icon="chevron_right" />
                    </q-item>
                    <q-item to="/settings/retention">
                        <q-item-section icon="monetization_on" />
                        <q-item-label label="Retenciones" />
                        <q-item-section right icon="chevron_right" />
                    </q-item>
                    <q-separator />
                    <q-item-label>Facturación</q-item-label>
                    <q-item to="/settings/payment_terms">
                        <q-item-section icon="comment" />
                        <q-item-label label="Terminos de pago" />
                        <q-item-section right icon="chevron_right" />
                    </q-item>
                    <q-item to="/settings/numeration">
                        <q-item-section icon="format_list_numbered" />
                        <q-item-label label="Numeración de documentos" />
                        <q-item-section right icon="chevron_right" />
                    </q-item>
                    <q-separator />
                    <q-item-label>Empresa</q-item-label>
                    <q-item to="/settings/company">
                        <q-item-section icon="domain" />
                        <q-item-label label="Empresa" />
                        <q-item-section right icon="chevron_right" />
                    </q-item>

                    <q-item to="/settings/profile">
                        <q-item-section icon="person_outline" />
                        <q-item-label label="Mi perfil" />
                        <q-item-section right icon="chevron_right" />
                   </q-item>

                </q-scroll-area>
                </q-drawer>
                <q-page-container>
                    <router-view />
                </q-page-container>
            </q-layout>
    </q-page>
</template>

<script>
export default {
  middleware: "auth",
  data() {
    return {
      layoutStore: {
        header: true,
        reveal: false,
        left: true,
        leftScroll: true,
        rightScroll: true,
        leftOverlay: false,
        leftBehavior: "default",
        leftBreakpoint: 996,
        rightBreakpoint: 1200
      }
    };
  }
};
</script>
