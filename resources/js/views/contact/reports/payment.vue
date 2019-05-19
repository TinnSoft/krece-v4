<template>
    <div>
    <q-data-table  :data="dataFinal" :config="config" :columns="columns" >
    
        <template slot="col-status_id" slot-scope="cell">         
            <PaymentInStatus  :id="cell.row.status_id"></PaymentInStatus>         
        </template>
        
    </q-data-table>
    <q-inner-loading :visible="isProcessing">
        <q-spinner-mat size="100px" color="teal-4" />Espere por favor...
    </q-inner-loading>
    </div>
</template>
<script type="text/javascript">
import PaymentInStatus from "../../../components/status/PaymentIn.vue";
import Toggle from "../../../components/tables/Toggle.vue";
import kButton from "../../../components/tables/Button.vue";

import {
  QDataTable,
  Dialog,
  QInnerLoading,
  QSpinnerMat
} from 'quasar-framework/dist/quasar.mat.esm';

import accounting from "accounting";
import axios from "axios";
import moment from "moment";
moment.locale("es");

export default {
  mixin: [QDataTable],
  components: {
    QDataTable,
    kButton,
    Toggle,
    PaymentInStatus,
    QInnerLoading,
    QSpinnerMat
  },
  props: ["path", "kmodule"],
  methods: {
    fetchData(path) {
      let vm = this;
      vm.isProcessing = true;
      vm.config.messages.noData = "Cargando...";
      axios
        .get(`/api/${path}`)
        .then(function(response) {
          vm.$set(vm, "table", response.data);
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
         // console.log(error.response);
        });

      if (vm.table.length === 0) {
        vm.config.messages.noData = "Aún no tienes registros creados";
      }
    },
    setColumns(kmodule, id) {
      let vm = this;
      let cols = vm.columns;
      cols.clear;
      let colListToApply = paymentInColumns();
      vm.$set(vm, "columns", colListToApply);
      this.fetchData(`getContactReports/${kmodule}/${id}`);
    }
  },
  beforeDestroy() {
    clearTimeout(this.timeout);
  },
  data() {
    return {
      isProcessing: false,
      table: [],
      config: {
        refresh: false,
        noHeader: false,
        columnPicker: false,
        leftStickyColumns: 0,
        rightStickyColumns: 0,
        bodyStyle: {
          maxHeight: "500px"
        },
        rowHeight: "40px",
        responsive: true,
        pagination: {
          rowsPerPage: 10,
          options: [5, 10, 15, 30, 50, 500]
        },
        //selection: 'multiple',
        labels: {
          columns: "Columnas",
          allCols: "Todas",
          rows: "Mostrar ",
          selected: {
            singular: "item seleccionado.",
            plural: "items seleccionados."
          },
          clear: "Limpiar",
          search: "Buscar",
          all: "Todo"
        },
        messages: {
          noData: "Cargando...",
          noDataAfterFiltering:
            "No se encontraron coincidencias con la busqueda. Porfavor revise los valores ingresados."
        }
      },
      columns: null,
      pagination: true,
      rowHeight: 50,
      bodyHeightProp: "maxHeight",
      bodyHeight: 500
    };
  },
  created() {
    this.columns = paymentInColumns();
    this.fetchData(this.path);
  },
  computed: {
    dataFinal() {
      return this.table;
    },
    columnsFinal() {
      return this.columns;
    }
  },
  watch: {
    pagination(value) {
      if (!value) {
        this.oldPagination = clone(this.config.pagination);
        this.config.pagination = false;
        return;
      }
      this.config.pagination = this.oldPagination;
    },
    rowHeight(value) {
      this.config.rowHeight = value + "px";
    },
    bodyHeight(value) {
      let style = {};
      if (this.bodyHeightProp !== "auto") {
        style[this.bodyHeightProp] = value + "px";
      }
      this.config.bodyStyle = style;
    },
    bodyHeightProp(value) {
      let style = {};
      if (value !== "auto") {
        style[value] = this.bodyHeight + "px";
      }
      this.config.bodyStyle = style;
    }
  }
};

function paymentInColumns() {
  return [
    {
      label: "No",
      field: "public_id",
      width: "40px",
      sort: true,

      filter: true,
      type: "text"
    },
    {
      label: "Detalle",
      field: "detail",
      sort: true,
      filter: true,
      width: "130px"
    },
    {
      label: "Fecha",
      field: "date",
      width: "90px",
      sort(a, b) {
        return new Date(a) - new Date(b);
      },
      format(value) {
        return moment(value).format("MMMM Do YYYY");
      },
      filter: true
    },
    {
      label: "Salidas",
      field: "total_outcome",
      filter: false,
      sort(t) {
        return t;
      },
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string",
      width: "80px"
    },
    {
      label: "Entradas",
      field: "total_income",
      filter: false,
      sort(t) {
        return t;
      },
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string",
      width: "80px"
    },
    {
      label: "Estado",
      field: "status_id",
      width: "60px",
      sort: true,
      filter: true
    }
  ];
}
</script>
