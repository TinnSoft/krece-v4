<template>
  <q-page class="row justify-center">
    <div style="width: 500px; max-width: 90vw;">

      <q-modal ref="numerationModal" v-ripple.mat  :minimized="$q.platform.is.desktop" :content-css="{minWidth: '40vw', minHeight: '50vh'}" @hide="handleClose">

        <q-modal-layout>

          <q-toolbar color="secondary" slot="header">                                        
            <q-toolbar-title>
                {{toolbarLabel}}  
            </q-toolbar-title>   
            <q-btn flat round :loading="isProcessing" icon="save"  @click="submit"> 
                <q-tooltip> Guardar</q-tooltip> 
            </q-btn>
            <q-btn flat round  icon="exit_to_app" v-close-overlay>
              <q-tooltip> Cancelar </q-tooltip> 
            </q-btn>                 
          </q-toolbar>
          <div class="layout-padding"> 
            <q-field :error="checkIfFieldHasError(errors, 'name')" error-label="Este campo es obligatorio">
              <q-input color="green" v-model="form.name" float-label="*Nombre" />
            </q-field>
            <q-field  :error="checkIfFieldHasError(errors, 'value')" error-label="Este campo es obligatorio">
              <q-input color="green" v-model="form.value" float-label="*Porcentaje" />
            </q-field>
            <q-field  :error="checkIfFieldHasError(errors, 'type_id')" error-label="Este campo es obligatorio">
              <q-select color="green" float-label="Tipo de retención" v-model="form.type_id" :options="base.retention" />
            </q-field>
            <q-input color="green" type="textarea" v-model="form.description" float-label="Descripción" />
            <br>
          </div>
        </q-modal-layout>
      </q-modal>
    </div>
  </q-page>
</template>

<script>
import kButton from "../../../components/tables/cButton.vue";
import kNotify from "../../../components/messages/Notify.js";

export default {
  data() {
    return {
      isProcessing: false,
      kindOfProcess: "create",
      error: false,
      toolbarLabel: "NUEVA RETENCIÓN",
      model: "retention",
      base: { retention: [{ label: "", value: "" }] },
      form: { auto_increment: true, isDefault: 0 },
      errors: "",
      pathFetchData: "/api/retention/create"
    };
  },
  components: {
    kButton
  },
  computed: {},
  methods: {
    handleClose(newVal) {
      this.$emit("hide", newVal);
    },

    checkIfFieldHasError(error, field) {
      try {
        if (error.errors[field]) {
          return true;
        }
      } catch (err) {}

      return false;
    },
    fetchData() {
      var vm = this;
      axios
        .get(vm.pathFetchData)
        .then(function(response) {
          vm.$set(vm.$data, "form", response.data.form);
          vm.$set(vm.$data.base, "retention", response.data.base);
        })
        .catch(function(error) {});
    },

    //kindOfProcess= create/edit
    //id= (opcional) id del registro cuando se edita
    open(kindOfProcess, id) {
      this.$set(this.$data, "errors", []);
      this.kindOfProcess = kindOfProcess;
      if (kindOfProcess === "edit") {
        this.pathFetchData = `/api/retention/${id}/edit`;
        this.toolbarLabel = "EDITAR RETENCIÓN";
      } else {
        this.pathFetchData = "/api/retention/create";
        this.toolbarLabel = "NUEVA RETENCIÓN";
      }
      this.fetchData();

      this.$refs["numerationModal"].show();
    },

    submit() {
      if (this.kindOfProcess === "edit") {
        this.update();
      } else {
        this.create();
      }
    },
    create() {
      var vm = this;
      vm.isProcessing = true;
      axios
        .post(`/api/${vm.model}`, vm.form)
        .then(function(response) {
          if (response.data.created) {
            kNotify(vm, "El registro se guardó satisfactoriamente", "positive");
          }
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
          vm.$set(vm.$data, "errors", error.response.data);
          kNotify(
            vm,
            "Ooops! No fue posible guardar el registro actual, intente de nuevo.",
            "negative"
          );
        });
    },

    update() {
      var vm = this;
      vm.isProcessing = true;
      axios
        .put("/api/retention/" + vm.form.id, vm.form)
        .then(function(response) {
          if (response.data.updated) {
            kNotify(
              vm,
              "El registro se registro satisfactoriamente",
              "positive"
            );
          }
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
          vm.$set(vm.$data, "errors", error.response.data);
          kNotify(
            vm,
            "Ooops! No fue posible actualizar el registro actual, intente de nuevo.",
            "negative"
          );
        });
    }
  }
};
</script>
