<template>
 <q-page padding >
    <div style="width: 400px; max-width: 90vw;">

      <q-modal ref="productModal" v-ripple.mat :minimized="$q.platform.is.desktop" :content-css="{minWidth: '50vw', minHeight: '50vh'}"
        @hide="handleHide">
      <q-modal-layout>
        <q-toolbar color="secondary" slot="header">
              <q-toolbar-title>
                  {{toolbarLabel}}  
              </q-toolbar-title>   
              <q-btn flat round  icon="save"  @click="submit"> 
                <q-tooltip> Guardar </q-tooltip> 
              </q-btn>
              <q-btn flat round  icon="exit_to_app" v-close-overlay>
                <q-tooltip>Cancelar </q-tooltip> 
              </q-btn> 
         <!-- <q-fixed-position class="mobile-only" corner="bottom-right" :offset="[18, 18]">
            <q-btn round color="green-14" icon="save" class="animate-pop" @click="submit" />
          </q-fixed-position>-->
        </q-toolbar>

        <div class="layout-padding">
              <div class="row" >
                <div class="col-sm-5">
                  <q-list style="border: 0;padding: 0">

                    <q-field :error="checkIfFieldHasError(errors,'name')" error-label="Este campo es obligatorio">
                        <q-input clearable  :color="themeColor" v-model="form.name" float-label="*Nombre" />
                    </q-field>
                                            
                    <q-input clearable   :color="themeColor" v-model="form.reference" float-label="Referencia" />
                    <q-input clearable  :color="themeColor" v-model="form.description" float-label="Descripción" />
                    <q-field :error="checkIfFieldHasError(errors,'sale_price')" error-label="Este campo es obligatorio">
                        <q-input clearable type="number"  prefix="$"  :color="themeColor" v-model="form.sale_price" float-label="*Precio de venta" />
                    </q-field>
                    <q-select filter autofocus-filter filter-placeholder="Buscar" clearable :options="base.listPrice"  :color="themeColor" v-model="form.list_price_id" float-label="Lista de Precios" />                    
                  </q-list>
                </div>
                <div class="col-sm-2">
                </div>
                <div class="col-sm-5">
                  <q-list style="border: 0;padding: 0">
                    <q-field :error="checkIfFieldHasError(errors,'tax_id')" error-label="Este campo es obligatorio">
                     <q-select filter autofocus-filter filter-placeholder="Buscar" clearable  :options="base.taxes"  :color="themeColor" v-model="form.tax_id" float-label="*Impuesto" />                    
                    </q-field>
                    <br>
                    <q-checkbox  :color="themeColor" v-model="form.inv_inStock" label="Ítem inventariable?">
                      <q-tooltip anchor="top middle" self="bottom middle" :offset="[10, 10]">
                        <q-icon name="help_outline" />
                        <strong>Marque esta opción</strong><div>si desea que la herramienta lleve el inventario de manera automática para este ítem</div>
                      </q-tooltip>
                    </q-checkbox>
                    
                     <template v-if="form.inv_inStock===true">
                       <q-field
                          icon="playlist_add"
                          label="DETALLE"
                          error-label="Estos campos son obligatorios"
                        >
                        <q-field :error="checkIfFieldHasError(errors,'inv_type_id')" error-label="Este campo es obligatorio">
                          <q-select filter autofocus-filter filter-placeholder="Buscar" clearable :options="base.measureUnit"  :color="themeColor" v-model="form.inv_type_id" float-label="*Unidad de Medida" />    
                        </q-field>
                          <q-field :error="checkIfFieldHasError(errors,'inv_quantity_initial')" error-label="Este campo es obligatorio">
                          <q-input clearable type="number"  :color="themeColor" v-model="form.inv_quantity_initial" float-label="*Cantidad Inicial" />    
                          </q-field>
                          <q-field :error="checkIfFieldHasError(errors,'inv_unit_cost')" error-label="Este campo es obligatorio">
                          <q-input clearable type="number" prefix="$"  :color="themeColor" v-model="form.inv_unit_cost" float-label="*Precio de Compra" /> 
                          </q-field>
                    </q-field>
                      
                     </template>
                  </q-list>
                </div>
              </div>
              <br>       
             
            <blockquote>
              <small>
                No te olvides de seleccionar la categoría a la cual pertenece el ítem             
                que estás creando.
                Esto ayudará a que la herramienta te genere los reportes de una manera más precisa.
              </small>
            </blockquote>
            <q-separator />
            <q-field :error="checkIfFieldHasError(errors,'category_id')" error-label="Seleccione una categoría">
               <treetable :route="pathCatehory" @click="handleClick" :selectedIDRow="form.category_id"/>    
            </q-field>
            </div>
           <q-inner-loading :visible="loading">
            <q-spinner-mat size="50px" color="teal-4" />{{spinnerText}}
          </q-inner-loading>
      </q-modal-layout>
      </q-modal>

    </div>
 </q-page>
</template>

<script>
import treetable from "../../../components/treeTable/TreeTable.vue";
import kNotify from "../../../components/messages/Notify.js";

export default {
  data() {
    return {
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
          width: "50px",
          sort: true,
          type: "string"
        },
        {
          label: "Apellido",
          field: "last_name",
          width: "40px",
          sort: true,
          type: "string"
        },
        {
          label: "email",
          field: "email",
          width: "60px",
          sort: true,
          type: "string"
        },
        {
          label: "Telefono",
          field: "phone",
          width: "40px",
          sort: true,
          type: "string"
        },
        {
          label: "Celular",
          field: "phone_mobile",
          width: "40px",
          sort: true,
          type: "string"
        },
        {
          label: "Notificar?",
          field: "notify",
          width: "40px",
          sort: true,
          type: "string"
        },
        {
          label: "Acciones",
          field: "actions",
          width: "40px",
          sort: true,
          type: "string"
        }
      ],
      pathFetchData: "/api/inventory/create",
      pathCatehory: "getCategoryIncome"
    };
  },
  components: {
    treetable
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

      vm.$refs["productModal"].show();
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
