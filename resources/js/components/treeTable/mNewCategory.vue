<template>
  <div class="q-pa-md q-gutter-sm">
    <q-dialog v-model="openCategoryFormLayout">
      <q-card style="width: 650px; max-width: 80vw;">
        <q-bar dense class="bg-blue text-white">
          <q-icon name="mail"></q-icon>
          <div>{{toolbarLabel}}</div>

          <q-space></q-space>

          <q-btn dense flat icon="close" v-close-popup>
            <q-tooltip>Cerrar</q-tooltip>
          </q-btn>
        </q-bar>

        <q-card-section>
          <q-input
            hide-bottom-space
            dense
            clearable
            v-model="form.name"
            label="*Nombre"
            :error="checkIfFieldHasError(errors, 'name')"
          ></q-input>
          <q-input
            hide-bottom-space
            dense
            type="textarea"
            autogrow
            clearable
            v-model="form.description"
            label="Descripción"
          ></q-input>
          <q-input
            hide-bottom-space
            dense
            clearable
            v-model="form.niif_account"
            label="Cuenta NIIF"
          ></q-input>    

          <kBlockQuote textToShow="<strong>Las categorías</strong>
              te ayudan a clasificar toda la información y movimientos de tu empresa de manera inteligente."
              customClass="doc-note doc-note--tip">
          </kBlockQuote>
        </q-card-section>
       

        <q-card-actions align="right" class="text-primary">
          <q-btn
            rpunded
            :loading="isProcessing"
            color="primary"
            @click.native="submit()"
            icon="save"
            label="Guardar"
          >
            <span slot="loading">
              <q-spinner-hourglass class="on-left"/>
            </span>
          </q-btn>
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>

<script>
import kButton from "../../components/tables/cButton.vue";
import kNotify from "../../components/messages/Notify.js";
import kBlockQuote from "../../components/messages/cBlockQuote.vue";

export default {
  data() {
    return {
      openCategoryFormLayout: false,
      treeParentID: null,
      isProcessing: false,
      kindOfProcess: "create",
      error: false,
      toolbarLabel: "NUEVA CATEGORÍA",
      model: "category",
      form: {
        auto_increment: true,
        isDefault: 0
      },
      errors: "",
      pathFetchData: "/api/category/create"
    };
  },
  components: {
    kButton,
    kBlockQuote
  },
  methods: {
    handleHide(newVal) {
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
        })
        .catch(function(error) {});
    },

    //kindOfProcess= create/edit
    //id= (opcional) id del registro cuando se edita
    open(kindOfProcess, id) {
      this.$set(this.$data, "errors", []);
      this.kindOfProcess = kindOfProcess;

      if (kindOfProcess === "edit") {
        this.pathFetchData = `/api/category/${id}/edit`;
        this.toolbarLabel = "EDITAR CATEGORÍA";
      } else {
        this.pathFetchData = "/api/category/create";
        this.toolbarLabel = "NUEVA CATEGORÍA";
      }
      this.fetchData();
      this.treeParentID = id;
      this.openCategoryFormLayout = true;
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
      vm.form.parent_id = vm.treeParentID;
      axios
        .post(`/api/${vm.model}`, vm.form)
        .then(function(response) {
          if (response.data.created) {
            kNotify(vm, "Se guardó el registro satisfactoriamente", "positive");
            vm.$refs["categoryModal"].hide();
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
        .put("/api/category/" + vm.form.id, vm.form)
        .then(function(response) {
          if (response.data.updated) {
            kNotify(
              vm,
              "Se actualizó el registro satisfactoriamente.",
              "positive"
            );
            vm.$refs["categoryModal"].hide();
          }

          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;

          vm.$set(vm.$data, "errors", error.response.data);
          kNotify(
            vm,
            "No fue posible actualizar el registro actual, intente de nuevo.",
            "negative"
          );
        });
    }
  }
};
</script>
