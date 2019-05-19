<template id="q-app">
<div >
 <HomeLayout v-if="authenticated" :title="title" :subtitle="subtitle" :background-color="backgroundcolor" :items="items">  
  </HomeLayout>  
  <LoginLayout v-else :title="title" :subtitle="subtitle" :background-color="backgroundcolor">
  </LoginLayout>
</div>
</template>

<script>

import LoginLayout from './_login.vue';
import HomeLayout from './_main.vue';

import { mapGetters } from "vuex";

export default {
  name: 'MainLayout',
  data: () => ({
    title: window.config.appName,
    subtitle: "Sistema de facturación en la nube",
    backgroundcolor: "bg-primary glossy",
    items: [
      {
        icon: "home",
        title: "INICIO",
        path: "/",
        type: "alone",
        active: true
      },
      {
        icon: "assessment",
        title: "MIS VENTAS",
        path: "/2",
        items: [
          { title: "Factura de venta", path: "/invoice" },
          { title: "Pagos recibidos", path: "/payment-in" },
          { title: "Notas crédito", path: "/credit-note" },
          { title: "Cotizaciones", path: "/estimate" },
          { title: "Remisiones", path: "/remision" }
        ]
      },
      {
        icon: "local_atm",
        title: "MIS COMPRAS",
        path: "/3",
        items: [
          { title: "Pagos", path: "/payment-out" },
          { title: "Factura proveedores", path: "/bill" },
          { title: "Notas débito", path: "/debit-note" },
          { title: "Ordenes de compra", path: "/purchase-order" }
        ]
      },
      {
        icon: "people",
        title: "CONTACTOS",
        path: "/contact",
        type: "alone"
      },
      {
        icon: "local_mall",
        title: "INVENTARIO",
        path: "/inventory",
        type: "alone"
      },
      {
        icon: "business",
        title: "BANCOS",
        path: "/bank",
        type: "alone"
      },
      {
        icon: "library_books",
        title: "CATEGORIAS",
        path: "/category",
        type: "alone"
      },
      {
        icon: "build",
        title: "CONFIGURACIÓN",
        path: "/settings",
        type: "alone"
      },
      {
        icon: "pie_chart",
        title: "REPORTES",
        path: "/config6",
        type: "alone"
      }
    ]
    
  }),
  components: {
    LoginLayout,HomeLayout
  },
   computed: mapGetters({
    authenticated: "auth/check"
  })
}
</script>