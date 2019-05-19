<template>
    <q-data-table ref="_mainTable" :data="dataFinal" :config="config" :columns="columns" >

    </q-data-table>
</template>
<script type="text/javascript">
import Toggle from "../../../components/tables/Toggle.vue";
import kButton from "../../../components/tables/Button.vue";

import { QDataTable, Dialog } from 'quasar-framework/dist/quasar.mat.esm';

import accounting from "accounting";
import axios from "axios";
import moment from "moment";
moment.locale("es");

export default {
  mixin: [QDataTable],
  components: {
    QDataTable,
    kButton,
    Toggle
  },
  props: ["path", "kmodule"],
  methods: {
    fetchData(path) {
      let vm = this;

      vm.config.messages.noData = "Cargando...";
      axios
        .get(`/api/${path}`)
        .then(function(response) {
          console.log("responde desde:", response.data);
          vm.$set(vm, "table", response.data);
        })
        .catch(function(error) {
          console.log(error.response);
        });

      if (vm.table.length === 0) {
        vm.config.messages.noData = "Aún no tienes registros creados";
      }
    },
    setColumns(kmodule, id) {
      let vm = this;
      let cols = vm.columns;
      cols.clear;

      let colListToApply = debitNoteColumns();

      vm.$set(vm, "columns", colListToApply);

      this.fetchData(`getContactReports/${kmodule}/${id}`);
    }
  },
  beforeDestroy() {
    clearTimeout(this.timeout);
  },
  data() {
    return {
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
    this.columns = debitNoteColumns();
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

function debitNoteColumns() {
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
      label: "Cliente",
      field: "name",
      sort(a) {
        return a;
      },
      filter: true,
      width: "150px",
      type: "string"
    },
    {
      label: "Creación",
      field: "date",
      width: "80px",
      sort(a, b) {
        return new Date(a.date) - new Date(b.date);
      },
      format(value) {
        return moment(value).fromNow();
      },
      filter: true
    },
    {
      label: "Total",
      field: "total",
      filter: false,
      sort(t) {
        return t;
      },
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string",
      width: "70px"
    },
    {
      label: "Por aplicar",
      field: "total",
      filter: false,
      sort(t) {
        return t;
      },
      format(value) {
        return accounting.formatMoney(value);
      },
      type: "string",
      width: "70px"
    }
  ];
}
</script>
