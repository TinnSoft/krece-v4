<template>
   <q-page padding class="row justify-center">
     <div style="width: 300px; max-width: 90vw;">
       <q-modal ref="sellerModal" v-ripple.mat :minimized="$q.platform.is.desktop" :content-css="{minWidth: '40vw', minHeight: '50vh'}"
      @hide="handleClose">

        <q-modal-layout>
        <q-toolbar color="secondary" slot="header">                                  
                    <q-toolbar-title>
                        {{toolbarLabel}}
                    </q-toolbar-title>   
                    <q-btn flat round  icon="exit_to_app" v-close-overlay>
                    </q-btn>                 
                </q-toolbar>

                <q-toolbar inverted slot="footer" color="secondary">                        
                      <q-toolbar-title>                    
                      </q-toolbar-title>
                      <q-btn dense no-wrap :loading="isProcessing" @click.native="submit" icon="save" color="green" label="GUARDAR">
                          <span slot="loading"><q-spinner-hourglass class="on-left" />
                              GUARDANDO..
                          </span>                    
                        </q-btn>
                </q-toolbar>    
             <div class="layout-padding">
              <q-list style="border: 0;padding: 0">
                <q-input clearable color="secondary" v-model="form.name" float-label="*Nombre" />
                <q-input clearable color="secondary" v-model="form.dni" float-label="# Identificación" />
                <q-input clearable color="secondary" v-model="form.work_phone" float-label="Teléfono Trabajo" />
                <q-input clearable color="secondary" v-model="form.private_phone" float-label="Teléfono Privado" />
                <q-input clearable color="secondary" type="textarea" v-model="form.observations" float-label="Observaciones" />
              </q-list>
             </div>
        </q-modal-layout>
      </q-modal>
     </div>
   </q-page>
</template>

<script>
import kNotify from "../../../components/messages/Notify.js";

export default {
  data() {
    return {
      toolbarLabel: "",
      pathFetchData: "/api/seller/create",
      error: false,
      model: "seller",
      checked: false,
      additionalfields: [],
      isProcessing: false,
      form: {},
      base: {
        products: [
          {
            label: "",
            value: ""
          }
        ]
      }
    };
  },
  methods: {
    handleClose(newVal) {
      this.$emit("hide", newVal);
    },
    fetchData() {
      let vm = this;
      vm.isProcessing = true;
      axios
        .get(vm.pathFetchData)
        .then(function(response) {
          vm.$set(vm.$data, "form", response.data.form);
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
        });
    },
    open(kindOfProcess, sellerId) {
      let vm=this;
      vm.kindOfProcess = kindOfProcess;
      if (kindOfProcess === "edit") {
        vm.pathFetchData = `/api/seller/${sellerId}/edit`;
        vm.toolbarLabel = "EDITAR VENDEDOR";
      } else {
        vm.pathFetchData = "/api/seller/create";
        vm.toolbarLabel = "NUEVO VENDEDOR";
      }
      vm.fetchData();

      vm.$refs["sellerModal"].show();
    },

    _submit() {
      if (this.kindOfProcess === "edit") {
        this.update();
      } else {
        this.create();
      }
    },
    create() {
      let vm = this;
      vm.isProcessing = true;
      axios
        .post(`/api/${vm.model}`, vm.form)
        .then(function(response) {
          if (response.data.created) {
            kNotify(vm, "El registro se creó satisfactoriamente", "positive");
          }
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
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
        .put("/api/seller/" + vm.form.id, vm.form)
        .then(function(response) {
          if (response.data.updated) {
            kNotify(
              vm,
              "El registro se actualizó satisfactoriamente",
              "positive"
            );
          }
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
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
