<template>
  <div class="q-pa-md">
    <div class="q-gutter-sm">
    
          <q-dialog v-model="openInventoryForm" @hide="handleHide">
            <q-card style="width: 700px; max-width: 90vw;">
              <q-bar class="bg-blue text-white">
                <q-icon name="mail" ></q-icon>
                <div>{{toolbarLabel}}  </div>
      
                <q-space ></q-space>

                <q-btn dense flat icon="close" v-close-popup>
                  <q-tooltip>Cerrar</q-tooltip>
                </q-btn>
              </q-bar>

              <q-card-section>                 
                  <div class="doc-container">
                    <div class="row">                
                        <div class="col-12 col-md-6">
                            <div class="q-gutter-sm">
                              <q-input filled hide-bottom-space dense clearable :error="checkIfFieldHasError(errors,'name')" 
                                  v-model="form.name" label="*Nombre" />

                              <q-input filled hide-bottom-space dense clearable v-model="form.reference" label="Referencia" />

                              <q-input filled clearable dense autogrow v-model="form.description" label="Descripción" />
                              
                              <q-input filled hide-bottom-space dense :error="checkIfFieldHasError(errors,'sale_price')" clearable type="number"  
                                  prefix="$" v-model="form.sale_price" label="*Precio de venta" />
                            
                              <q-select options-dense filled hide-bottom-space dense filter autofocus-filter clearable :options="base.listPrice" v-model="form.list_price_id" label="Lista de Precios" />                    
                                              
                              <q-select options-dense filled hide-bottom-space dense :error="checkIfFieldHasError(errors,'tax_id')" filter autofocus-filter 
                                clearable :options="base.taxes" v-model="form.tax_id" label="*Impuesto" />                    
                            </div>
                        </div>
                        <div class="col-12 col-md-1">
                        </div>
                        <div class="col-12 col-md-5">
                            <div class="q-gutter-sm">                                  
                                  <q-checkbox v-model="form.inv_inStock" label="Ítem inventariable?">
                                    <q-tooltip anchor="top middle" self="bottom middle" :offset="[10, 10]">
                                      <q-icon name="help_outline" />
                                      <strong>Marque esta opción</strong><div>si desea que la herramienta lleve el inventario de manera automática para este ítem</div>
                                    </q-tooltip>
                                  </q-checkbox>
                                  
                                <template v-if="form.inv_inStock===true">                                                                   
                                  <q-select filled hide-bottom-space options-dense dense :error="checkIfFieldHasError(errors,'inv_type_id')" 
                                      filter autofocus
                                      clearable :options="base.measureUnit" v-model="form.inv_type_id" label="*Unidad de Medida">                                     
                                  </q-select>    
                                  <q-input filled hide-bottom-space dense :error="checkIfFieldHasError(errors,'inv_quantity_initial')" clearable type="number"  
                                      v-model="form.inv_quantity_initial" abel="*Cantidad Inicial" />    
                                  <q-input filled hide-bottom-space dense :error="checkIfFieldHasError(errors,'inv_unit_cost')" clearable type="number" prefix="$"
                                      v-model="form.inv_unit_cost" label="*Precio de Compra" /> 
                                </template>
                            </div>
                        </div>
                    </div>
                  </div>                            
              </q-card-section>              

              <q-card-section>
                  <kBlockQuote textToShow="<strong>No te olvides de seleccionar la categoría</strong> a la cual pertenece el ítem que estás creando.
                          Esto ayudará a que la herramienta te genere los reportes de una manera más precisa."
                      customClass="doc-note doc-note--tip">
                  </kBlockQuote>
                  <treetable :route="pathCatehory" @click="handleClick" :selectedIDRow="form.category_id"/> 
              </q-card-section>
              <q-card-actions align="right" class="text-primary"> 
                  <q-btn rpunded :loading="loading" color="primary" @click.native="submit()" icon="save" label="Guardar">
                      <span slot="loading"><q-spinner-hourglass class="on-left" />
                      </span>                    
                  </q-btn>
                </q-card-actions>     
            </q-card>
          </q-dialog>            
      </div>
  </div>
</template>

<script>

import treetable from "../../../components/treeTable/TreeTable.vue";
import kNotify from "../../../components/messages/Notify.js";
import kBlockQuote from "../../../components/messages/cBlockQuote.vue";

export default {
  data() {
    return {
      openInventoryForm:false,
      spinnerText: "Cargando...",
      errors: null,
      themeColor: "secondary",
      editIdAssociate: null,
      isEditActive: false,
      loading: false,
      kindOfProcess: "create",
      error: false,
      toolbarLabel: "NUEVO ÍTEM",
      model: "inventory",
      form: { inv_inStock: false },
      base: {
        measureUnit: [
          {
            label: "",
            value: ""
          }
        ],
        taxes: [
          {
            label: "",
            value: ""
          }
        ],
        listPrice: [
          {
            label: "",
            value: ""
          }
        ]
      },
      columns: [
        {
          label: "Nombre",
          field: "name",
          sortable: true,
          type: "string"
        },
        {
          label: "Apellido",
          field: "last_name",
          sortable: true,
          type: "string"
        },
        {
          label: "email",
          field: "email",
          sortable: true,
          type: "string"
        },
        {
          label: "Telefono",
          field: "phone",
          sortable: true,
          type: "string"
        },
        {
          label: "Celular",
          field: "phone_mobile",
          sortable: true,
          type: "string"
        },
        {
          label: "Notificar?",
          field: "notify",
          sortable: true,
          type: "string"
        },
        {
          label: "Acciones",
          field: "actions",
          sortable: true,
          type: "string"
        }
      ],
      pathFetchData: "/api/inventory/create",
      pathCatehory: "getCategoryIncome"
    };
  },
  components: {
    treetable,
    kBlockQuote
  },
  methods: {
    handleClick(row) {
      this.form.category_id = row.id;
    },
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
      vm.spinnerText = "Cargando...";
      vm.loading = true;
      axios
        .get(vm.pathFetchData)
        .then(function(response) {
          // console.log(response.data.form);
          vm.$set(vm.$data, "form", response.data.form);
          vm.$set(vm.$data.base, "taxes", response.data.base.taxes);
          vm.$set(vm.$data.base, "listPrice", response.data.base.listprice);
          vm.$set(
            vm.$data.base,
            "measureUnit",
            response.data.base.measure_unit
          );
         
          vm.loading = false;
        })
        .catch(function(error) {
          vm.loading = false;
        });
    },

    //kindOfProcess= create/edit
    //customerId= (opcional) id del producto cuando se edita
    open(kindOfProcess, customerId) {
      let vm = this;
      vm.isEditActive = false;
      vm.kindOfProcess = kindOfProcess;
      vm.category_id = null;

      if (kindOfProcess === "edit") {
        vm.pathFetchData = `/api/${vm.model}/${customerId}/${kindOfProcess}`;
        vm.toolbarLabel = "EDITAR ÍTEM";
      } else {
        vm.pathFetchData = `/api/${vm.model}/${kindOfProcess}`;
        vm.toolbarLabel = "NUEVO ÍTEM";
      }

      vm.fetchData();
      vm.openInventoryForm=true;
    },

    submit() {
      if (this.kindOfProcess === "edit") {
        this.spinnerText = "Actualizando...";
        this.update();
      } else {
        this.spinnerText = "Guardando...";
        this.create();
      }
    },
    create() {
      let vm = this;
      vm.$set(vm.$data, "errors", null);
      vm.loading = true;

      axios
        .post(`/api/${vm.model}`, vm.form)
        .then(function(response) {
          if (response.data.created) {
            kNotify(vm, "El registro se creó satisfactoriamente", "positive");
          }
          vm.loading = false;
          vm.$refs.productModal.hide()
        })
        .catch(function(error) {
          
          vm.$set(vm.$data, "errors", error.response.data);
          vm.loading = false;
          kNotify(
            vm,
            "Ooops! No fue posible guardar el registro actual, intente de nuevo.",
            "negative"
          );
        });
    },

    update() {
      var vm = this;
      vm.errors = null;
      vm.loading = true;

      axios
        .put(`/api/${vm.model}/${vm.form.id}`, vm.form)
        .then(function(response) {
          if (response.data.updated) {
            kNotify(
              vm,
              "Se actualizó el registro satisfactoriamente",
              "positive"
            );
          }
          vm.loading = false;
        })
        .catch(function(error) {
          vm.errors = error.response.data;
          vm.loading = false;
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
