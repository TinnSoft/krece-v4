<template>
     <q-table
        dense
      :data="qdata"
      :columns="columns"
      row-key="name"
      color="secondary"
    >
     <q-tr slot="bottom-row"  style="text-align: right" >  
        <td class colspan="100%" align="right">    
            <cTotals :subtotal="subtotal" :discounts="discounts" :taxes="taxes" :total="total" :isTaxArray="true"></cTotals>
        </td>
      </q-tr> 
    </q-table>
</template>

<script>
import cTotals from "../../components/tables/cTotal.vue";

export default {
  props: {
    isInvoice: {},
    qdata: {},
    subtotal: {},
    discounts: {},
    taxes: {},
    total: {}
  },
  data() {
    return {
      columns: []
    };
  },
  components: {
    cTotals
  },
  computed: {
    /*  dataTable() {
      if (this.qData) {
        return this.qData;
      }
      return [];
    }*/
  },
  created() {
    if (this.isInvoice === 1) {
      this.columns = invoiceColumns();
    } else {
      this.columns = categoryColumns();
    }
  }
};

function invoiceColumns() {
  return [
    {
      label: "No Factura",
      field: "public_id",
      name: "public_id",
      sortable: true,
      type: "string"
    },
    {
      label: "Fecha",
      field: "date",
      name: "date",
      sortable: true,
      format(value) {
        return moment(value.date).format("MMMM Do YYYY");
      }
    },
    {
      label: "Vencimiento",
      field: "due_date",
      name: "due_date",
      sortable: true,
      format(value) {
        return moment(value.due_date).format("MMMM Do YYYY");
      }
    },
    {
      label: "Total",
      field: "total",
      name: "total",
      sortable: true,
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string"
    },
    {
      label: "Pago Acumulado",
      field: "total_pending_by_payment2",
      name: "total_pending_by_payment2",
      sortable: true,
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string"
    },
    {
      label: "Pagado",
      field: "total_payed",
      name: "total_payed",
      sortable: true,
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string"
    },
    {
      label: "Por Pagar",
      field: "total_pending_by_payment",
      name: "total_pending_by_payment",
      sortable: true,
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string"
    }
  ];
}

function categoryColumns() {
  return [
    {
      label: "Categoría",
      field: "category",
      name: "category",
      format(value) {
        return value.type.description + ": " + value.name;
      },
      sortable: true,
      type: "string"
    },
    {
      label: "Precio Unitario",
      field: "unit_price",
      name: "unit_price",
      sortable: true,
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string"
    },
    {
      label: "Impuesto (%)",
      field: "tax_amount",
      name: "tax_amount",
      sortable: true,
      format(value) {
        return accounting.formatNumber(value);
      },
      type: "string"
    },
    {
      label: "Cantidad",
      field: "quantity",
      name: "quantity",
      sortable: true,
      type: "string"
    },
    {
      label: "Observaciones",
      field: "observations",
      name: "observations",
      sortable: true,
      type: "string"
    },
    {
      label: "Total",
      field: "total",
      name: "total",
      sortable: true,
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string"
    }
  ];
}
</script>

