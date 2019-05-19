<template>
 <q-page class="row justify-center">
    <div style="width: 300px; max-width: 90vw;">      
      <q-modal ref="categoryModal" v-ripple.mat :minimized="$q.platform.is.desktop" :content-css="{minWidth: '50vw', minHeight: '50vh'}"
      @hide="handleHide">
      <q-modal-layout>
         <q-toolbar color="secondary" slot="header">                                        
            <q-toolbar-title>
                {{toolbarLabel}}  
            </q-toolbar-title>   
            <q-btn flat round  icon="save"  @click="submit"> 
                <q-tooltip> Guardar</q-tooltip> 
            </q-btn>
            <q-btn flat round  icon="exit_to_app" v-close-overlay>
              <q-tooltip> Cancelar </q-tooltip> 
            </q-btn>                 
          </q-toolbar>
  
       <div class="layout-padding">    
          <q-field class="no-margin no-padding" :error="checkIfFieldHasError(errors, 'name')" error-label="Este campo es obligatorio">  
            <q-input color="green" clearable v-model="form.name" float-label="*Nombre" />  
          </q-field>  
          <q-input color="green" type="textarea" clearable v-model="form.description" float-label="Descripción" />  
          <q-input color="green" clearable v-model="form.niif_account" float-label="Cuenta NIIF" />   
        </div>
         <q-separator />
         
          <q-field
            icon="help_outline"
          >           
            <blockquote>  
              <small>  
                Las categorías te permiten clasificar 
                toda la información y movimientos de tu empresa de manera inteligente. 
                </small>  
            </blockquote>
          </q-field>
          <q-inner-loading :visible="isProcessing">
          <q-spinner-hourglass size="50px" color="secondary"></q-spinner-hourglass>
        </q-inner-loading>

        </q-modal-layout>
      </q-modal>
  
    </div>
  
  </q-page>
</template>

<script>
import kButton from "../../components/tables/cButton.vue";
import kNotify from "../../components/messages/Notify.js";

export default {
  data() {
    return {
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
    kButton
  },

  computed: {},

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
      this.$refs["categoryModal"].show();
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
