<template>
  <q-page padding class="row justify-center">
    <div style="width: 400px; max-width: 90vw;">

      <q-modal ref="bankModal" v-ripple.mat :minimized="$q.platform.is.desktop" :content-css="{minWidth: '40vw', minHeight: '50vh'}"
      @hide="handleClose">
        <q-modal-layout>
                <q-toolbar color="secondary" slot="header"> 
                    <q-btn flat round  icon="account_balance">                
                    </q-btn>                   
                    <q-toolbar-title>
                        {{toolbarLabel}}
                    </q-toolbar-title>   
                    <q-btn flat round  icon="exit_to_app" v-close-overlay>
                    </q-btn>                 
                </q-toolbar>

               <q-toolbar inverted slot="footer" color="secondary">                        
                      <q-toolbar-title>                    
                      </q-toolbar-title>

                      <q-btn dense no-wrap :loading="loading" @click.native="_submit" icon="save" color="green" label="GUARDAR">
                          <span slot="loading"><q-spinner-hourglass class="on-left" />
                              GUARDANDO..
                          </span>                    
                        </q-btn>
                </q-toolbar> 

                 <div class="layout-padding">

                  <q-list style="border: 0;padding: 0">
                    <q-field :error="checkIfFieldHasError(errors, 'bank_account_type_id')" error-label="Este campo es obligatorio">
                      <q-select color="secondary" autofocus-filter filter filter-placeholder="Buscar" float-label="*Tipo de cuenta" v-model="form.bank_account_type_id" :options="base.banks" />
                    </q-field>
                    <q-field :error="checkIfFieldHasError(errors, 'bank_account_name')" error-label="Este campo es obligatorio">
                      <q-input color="secondary" v-model="form.bank_account_name" float-label="*Nombre de la cuenta" />
                    </q-field>
                    <q-input  color="secondary" v-model="form.bank_account_number" float-label="Número de cuenta" />
                    <q-field :error="checkIfFieldHasError(errors, 'initial_balance')" error-label="Este campo es obligatorio">
                      <q-input  color="secondary"  type="number" v-model="form.initial_balance" float-label="*Saldo Inicial ($)" />
                    </q-field>
                    <q-input  color="secondary" type="textarea" v-model="form.description" float-label="Descripción" />
                  </q-list>
            </div>
        </q-modal-layout>
      </q-modal>
    </div>
  </q-page>
</template>

<script>


export default {
  data() {
    return {
      toolbarLabel: "",
      pathFetchData: "/api/bank/create",
      error: false,
      errors:'',
      model: "bank",
      checked: false,
      additionalfields: [],
      form: { bank_account_type_id: "" },
      loading: false,
      base: {
        banks: [
          {
            label: "",
            value: ""
          }
        ]
      }
    };
  },
  methods: {
    checkIfFieldHasError(error, field) {
      try {
        if (error.errors[field]) {
          return true;
        }
      } catch (err) {}

      return false;
    },
    handleClose(newVal) {
      this.$emit("hide", newVal);
    },
    fetchData() {
      var vm = this;
      axios
        .get(vm.pathFetchData)
        .then(function(response) {
          vm.$set(vm.$data, "form", response.data.form);
          vm.$set(
            vm.$data.base,
            "banks",
            response.data.base["bankaccountlist"]
          );
        })
        .catch(function(error) {
        });
    },
    open(kindOfProcess, bankId) {
      this.kindOfProcess = kindOfProcess;

      if (kindOfProcess === "edit") {
        this.pathFetchData = `/api/bank/${bankId}/edit`;
        this.toolbarLabel = "EDITAR BANCO";
      } else {
        this.pathFetchData = "/api/bank/create";
        this.toolbarLabel = "NUEVO BANCO";
      }
      this.fetchData();
      this.$set(this, "errors", ""); 
      this.$refs["bankModal"].show();
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
            vm.$q.notify({
              message: `Se creó el registro satisfactoriamente`,
              type: "positive",
              timeout: 3000
            });
          }
          vm.isProcessing = false;
          vm.$refs.bankModal.hide()
        })
        .catch(function(error) {
          vm.$set(vm, "errors", error.response.data); 
          vm.isProcessing = false;
          vm.$q.notify({
            message: `Ooops! No fue posible guardar el registro actual, intente de nuevo..`,
            type: "negative",
            timeout: 3000
          });
        });
    },

    update() {
      let vm = this;
      vm.isProcessing = true;
      axios
        .put(`/api/${vm.model}/${vm.form.id}`, vm.form)
        .then(function(response) {
          if (response.data.updated) {
            vm.$q.notify({
              message: `Se actualizó el registro satisfactoriamente`,
              type: "positive",
              timeout: 3000
            });
          }
          vm.isProcessing = false;
          vm.$refs.bankModal.hide()
        })
        .catch(function(error) {
          vm.isProcessing = false;
           vm.$set(vm, "errors", error.response.data); 
          vm.$q.notify({
            message: `Ooops! No fue posible actualizar el registro actual, intente de nuevo..`,
            type: "negative",
            timeout: 3000
          });
        });
    }
  }
};
</script>
