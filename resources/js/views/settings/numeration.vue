<template>
     <q-page padding>
        <q-tabs inverted color="green-5">
            <q-tab default  animated swipeable slot="title" name="tab-1" label="GENERAL" />
            <q-tab slot="title" name="tab-2" label="FACTURAS"  animated swipeable/>
            <q-tab-pane color="green" name="tab-1" glossy align="justify">
                <small>
                    A continuación puedes cambiar el consecutivo de la numeración para cada uno de los documentos creados
                </small>
                <q-field v-for="(item, index) in form" :key="index">
                    <q-input color="green" type="number" v-model="item.number" :float-label="item.text" />
                </q-field>
                <br>
                <q-btn :loading="isProcessing" color="green" icon="save" @click="update" label="ACTUALIZAR"> 
                </q-btn>
            </q-tab-pane>
            <q-tab-pane name="tab-2" >
                <q-btn flat color="green" icon="add_circle_outline" label="NUEVA NUMERACIÓN" small @click="openNumerationModal($refs)">                    
                </q-btn>
                <br>
                <br>
                <q-table dense :data="table" :columns="columns">
                    <q-td slot="body-cell-actions" slot-scope="props" :props="props">
                        <cToggle @blur="lockUnlock(props.row, props)" :isActive="props.row.isActive"></cToggle>
                        <cButton color="secondary" iconname="edit" tooltiplabel="Editar" @click="editNumerationModal($refs, props.row)"></cButton>
                        <cButton color="red" iconname="delete" tooltiplabel="Eliminar" @click="remove(props)"></cButton>
                    </q-td>
                </q-table>
            </q-tab-pane>

            <q-inner-loading :visible="isProcessing">
                <q-spinner-mat size="50px" color="teal-4" />Espere por favor...
            </q-inner-loading>
        </q-tabs>

        <br>
        <numerationModal ref="_numeration" @close="closeNumerationModal"></numerationModal>
   </q-page>
</template>

<script>
import cButton from "../../components/tables/cButton.vue";
import cToggle from "../../components/tables/cToggle.vue";
import store from "../../store";
import numerationModal from "./modals/mNumeration.vue";
import kNotify from "../../components/messages/Notify.js";

export default {
  components: {
    cButton,
    cToggle,
    numerationModal
  },
  created() {
    this.fetchData();
  },
  data() {
    return {
      isProcessing: false,
      pathToUpdate: "/api/update_numeration/1",
      path: `resolutionAll`,
      regime: [{ label: "", value: "" }],
      form: [{ id: "", key: "", number: "", text: "" }],
      invoice_number: [],
      pathResolutionInvoice: "resolution_InvoiceNumbers",
      modulename: "resolution",
      warningmessage: "Estas a punto de eliminar la numeración # ",
      pathToUpdateState: "resolution_update_state",
      table: [],
      columns: [
        {
          label: "Nombre",
          field: "name",
          name: "name",
          width: "70px",
          sort: true,
          type: "string"
        },
        {
          label: "Prefijo",
          field: "prefix",
          name: "prefix",
          width: "50px"
        },
        {
          label: "# Inicial",
          classes: "bg-yellow-1",
          field: "initial_number",
          name: "initial_number",
          width: "50px"
        },
        {
          label: "# siguiente",
          classes: "bg-orange-1",
          field: "next_invoice_number",
          name: "next_invoice_number",
          width: "50px"
        },
        {
          label: "Preferido",
          field: "isDefault",
          name: "isDefault",
          format(value) {
            if (value === 1) {
              return "Si";
            }
            return "No";
          },
          type: "string",
          width: "50px"
        },
        {
          label: "Acciones",
          field: "actions",
          name: "actions",
          type: "string",
          width: "70px"
        }
      ]
    };
  },
  computed: {
    canSave() {
      if (this.form.name) {
        return true;
      }
      return false;
    }
  },
  methods: {
    remove(val) {
      let vm = this;
      vm.isProcessing = true;
      axios
        .delete("/api/resolution/" + val.row.id)
        .then(function(response) {
          if (response.data.deleted) {
            kNotify(
              vm,
              "Se eliminó el registro satisfactoriamente",
              "positive"
            );
            vm.fetchData();
            vm.isProcessing = false;
          }
        })
        .catch(function(error) {
          kNotify(
            vm,
            "No fue posible eliminar el registro seleccionado, intente de nuevo.",
            "positive"
          );
          vm.isProcessing = false;
        });
    },
    openNumerationModal(refs, processType, id) {
      refs._numeration.open(processType, id);
    },
    closeNumerationModal() {
      this.fetchData();
    },
    lockUnlock(cell, ref) {
      var _path = `/api/${this.pathToUpdateState}/${cell.id}`;
      var xstatus = { isActive: null };

      if (cell.isActive === 0) {
        xstatus.isActive = 1;
      } else {
        xstatus.isActive = 0;
      }

      this.submit(_path, xstatus);
    },
    editNumerationModal(refs, cell) {
      this.openNumerationModal(refs, "edit", cell.id);
    },
    fetchData() {
      var vm = this;
      vm.isProcessing = true;
      axios
        .get(`/api/${vm.path}`)
        .then(function(response) {
          vm.$set(vm.$data, "form", response.data.form);
          vm.$set(vm.$data, "table", response.data.invoice);
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
        });
    },
    update() {
      this.submit(this.pathToUpdate, this.form);
    },
    submit(path, request) {
      var vm = this;
      vm.isProcessing = true;
      axios
        .put(path, request)
        .then(function(response) {
          if (response.data.updated) {
            let _msg = "Registro actualizado correctamente";
            if (response.data.custom_message) {
              _msg = response.data.custom_message;
            }
            kNotify(vm, _msg, "positive");
            vm.fetchData();
          } else {
            let _msg = "No fue posible completar la operación";
            if (response.data.custom_message) {
              _msg = response.data.custom_message;
            }
            kNotify(vm, _msg, "negative");
          }

          vm.isProcessing = false;
        })
        .catch(function(error) {
          kNotify(
            vm,
            "No se ha podido actualizar el registro, intente de nuevo.",
            "negative"
          );
          vm.isProcessing = false;
        });
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
</script>
