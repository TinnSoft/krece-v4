<template>

 <div class="q-pa-md q-gutter-sm">

          <q-dialog v-model="openBankFormLayout" @hide="handleClose">
            <q-card style="width: 650px; max-width: 80vw;">
              <q-bar dense class="bg-blue text-white">
                <q-icon name="mail" ></q-icon>
                <div>{{toolbarLabel}}  </div>
      
                <q-space ></q-space>
      
                <q-btn dense flat icon="close" v-close-popup>
                  <q-tooltip>Cerrar</q-tooltip>
                </q-btn>
              </q-bar>

              <q-card-section>
                  <q-select hide-bottom-space dense color="secondary" autofocus-filter filter label="*Tipo de cuenta"
                      :error="checkIfFieldHasError(errors, 'bank_account_type_id')" v-model="form.bank_account_type_id" :options="base.banks" ></q-select>
   
                  <q-input hide-bottom-space dense :error="checkIfFieldHasError(errors, 'bank_account_name')" color="secondary" v-model="form.bank_account_name" 
                  label="*Nombre de la cuenta" ></q-input>
                
                  <q-input hide-bottom-space dense color="secondary" v-model="form.bank_account_number" label="Número de cuenta"></q-input>
                  
                  <q-input hide-bottom-space dense :error="checkIfFieldHasError(errors, 'initial_balance')"  color="secondary"  type="number" 
                  v-model="form.initial_balance" label="*Saldo Inicial ($)" ></q-input>

                  <q-input hide-bottom-space dense color="secondary" type="textarea" v-model="form.description" label="Descripción"></q-input>
              </q-card-section>
      
              <q-card-actions align="right" class="text-primary"> 
                  <q-btn rpunded :loading="isProcessing" color="primary" @click.native="_submit()" icon="save" label="Guardar">
                      <span slot="loading"><q-spinner-hourglass class="on-left" />
                      </span>                    
                  </q-btn>
                </q-card-actions>     
            </q-card>
          </q-dialog>            
      </div>
</template>

<script>


export default {
  data() {
    return {
      openBankFormLayout:false,
      toolbarLabel: "",
      pathFetchData: "/api/bank/create",
      error: false,
      errors:'',
      model: "bank",
      checked: false,
      additionalfields: [],
      form: { bank_account_type_id: "" },
      isProcessing: false,
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
      this.openBankFormLayout=true;
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
          vm.openBankFormLayout=false;
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
          vm.openBankFormLayout=false;
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
