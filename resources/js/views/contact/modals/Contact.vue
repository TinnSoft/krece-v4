<template>
 <q-page padding class="row justify-center">
    <div style="width: 500px; max-width: 90vw;">

      <q-modal ref="contactModal" v-ripple.mat :minimized="$q.platform.is.desktop" :content-css="{minWidth: '40vw', minHeight: '50vh'}"
      @hide="handleClose">
        <q-modal-layout>
    
            <q-toolbar color="secondary" slot="header"> 
                    <q-btn flat round  icon="help_outline"> 
                      <q-tooltip anchor="bottom middle" self="top middle" :offset="[10, 10]">
                        <strong>Recuerda</strong>!
                        <div class="text-justify">Al seleccionar una lista de precios, vendedor<br> o término de pago, te ayudará a optimizar tu tiempo <br> al momento de realizar algúna operación.</div>
                      </q-tooltip>
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

                      <q-btn dense no-wrap :loading="isProcessing" @click.native="submit" icon="save" color="green" label="GUARDAR">
                          <span slot="loading"><q-spinner-hourglass class="on-left" />
                              GUARDANDO..
                          </span>                    
                        </q-btn>
                </q-toolbar> 

        
        <!--  <q-fixed-position class="mobile-only" corner="bottom-right" :offset="[18, 18]">
            <q-btn round color="green-14" icon="save" class="animate-pop" @click="submit" />
          </q-fixed-position>-->


        <q-tabs class="shadow-2" inverted color="secondary">
          <q-tab default slot="title" name="tab-1" label="General" />
          <q-tab slot="title" name="tab-2" label="Asociar Personas" />
          <q-tab-pane name="tab-1">

            <q-field helper="Este contacto puede ser clasificado como cliente o proveedor" label="Tipo de contacto">
              <q-checkbox v-model="form.isCustomer" color="secondary" label="Cliente" />
              <q-checkbox v-model="form.isProvider" color="secondary" label="Proveedor" />
            </q-field>

            <q-separator></q-separator>
           
              <div class="row ">

                <div class="col-sm-5">
                  <q-list style="border: 0;padding: 0">
                    <q-field  :error="checkIfFieldHasError(errors, 'name')" error-label="Este campo es obligatorio">
                      <q-input  color="secondary" v-model="form.name" float-label="*Nombre" />
                    </q-field>
                    <q-input color="secondary" v-model="form.nit" float-label="Nit" />
                    <q-input  color="secondary" v-model="form.address" float-label="Dirección" />
                    <q-input  color="secondary" v-model="form.city" float-label="Ciudad" />
                    <q-input  color="secondary" v-model="form.email" float-label="Email" />
                    <q-input  color="secondary" v-model="form.phone1" float-label="Teléfono 1" />
                    <q-input  color="secondary" v-model="form.phone2" float-label="Teléfono 2" />
                  </q-list>
                </div>
                <div class="col-sm-1">
                </div>
                <div class="col-sm-5">
                  <q-list style="border: 0;padding: 0">

                    <q-input  color="secondary" v-model="form.fax" float-label="Fax" />
                    <q-input  color="secondary" v-model="form.phone_mobile" float-label="Celular" />
                    <q-select  color="secondary" float-label="Lista de precios" v-model="form.list_price_id" :options="base.listprice" />
                    <q-select  color="secondary" float-label="Vendedor" v-model="form.seller_id" :options="base.sellers" />
                    <q-select  color="secondary" float-label="Terminos de pago" v-model="form.payment_terms_id" :options="base.paymentterms" />
                    <q-input  color="secondary" type="textarea" v-model="form.observation" float-label="Observaciones" />

                  </q-list>
                </div>
              </div>
           
          </q-tab-pane>
          <q-tab-pane name="tab-2">
            <div class="doc-container">
              <div class="row ">
                <div class="col-sm-5">
                  <q-list style="border: 0;padding: 0">
                    <q-input  color="secondary" v-model="contact_others.name" float-label="*Nombre" />
                    <q-input  color="secondary" v-model="contact_others.last_name" float-label="Apellido" />
                    <q-input  color="secondary" v-model="contact_others.email" float-label="*Email" />

                  </q-list>
                </div>
                <div class="col-sm-1">
                </div>
                <div class="col-sm-5">
                  <q-list style="border: 0;padding: 0">
                    <q-input  color="secondary" v-model="contact_others.phone" float-label="Teléfono" />
                    <q-input  color="secondary" v-model="contact_others.phone_mobile" float-label="Celular" />
                    <br>
                    <q-checkbox color="secondary" v-model="contact_others.notify" label="Notificar">
                      <q-tooltip anchor="top middle" self="bottom middle" :offset="[10, 10]">
                        <q-icon name="help_outline" />
                        <strong>Marque esta opción</strong>
                        <div>Solo si requiere que este contacto reciba correos</div>
                        <div>o alertas de facturas disponibles y/o vencidas.</div>
                      </q-tooltip>
                    </q-checkbox>

                  </q-list>
                </div>
              </div>
              <br>
              <template v-if="isEditActive===false">
                <q-btn color="primary" @click="associateContact" :disabled="hasName">
                  <q-icon name="add" />Agregar nuevo
                </q-btn>
              </template>
              <template v-if="isEditActive===true">
                <q-btn color="primary" @click="updateAssociate">
                  <q-icon name="update" />Actualizar
                </q-btn>
                <q-btn flat color="primary" @click="cancelUpdateAssociate">
                  Cancelar
                </q-btn>
              </template>
              <br>
              <br>
              <q-banner key="info" color="info" type="info" class="q-mb-sm">
                <small> Puedes agregar tantos contactos como desees, luego no olvides dar click en el boton GUARDAR</small>
              </q-banner>

              <q-separator color="secondary" />
              <q-table :data="form.contact_others" :columns="columns">
                <q-td slot="body-cell-notify" slot-scope="props" :props="props">
                  <q-checkbox v-model="props.row.notify" color="secondary" />
                </q-td>
                <q-td slot="body-cell-actions" slot-scope="props" :props="props">
                  <kButton color="secondary" iconname="edit" tooltiplabel="Editar" @click="editAssociate(props)"></kButton>
                  <kButton color="red" iconname="delete" tooltiplabel="Eliminar" @click="deleteAssociate(props)"></kButton>
                 </q-td>
              </q-table>
            </div>
          </q-tab-pane>          
        </q-tabs>
        </q-modal-layout>
        <q-inner-loading :visible="isProcessing">
            <q-spinner-mat size="50px" color="teal-4" />Espere por favor...
          </q-inner-loading>
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
      editIdAssociate: null,
      isEditActive: false,
      isProcessing: false,
      kindOfProcess: "create",
      errors: null,
      error: false,
      toolbarLabel: "NUEVO CONTACTO",
      model: "contact",
      contact_others: {
        name: "",
        last_name: "",
        email: null,
        phone: null,
        phone_mobile: null,
        notify: false
      },
      form: { contact_others: {}, isCustomer: false, isProvider: false },
      base: {
        listprice: [
          {
            label: "",
            value: ""
          }
        ],
        sellers: [
          {
            label: "",
            value: ""
          }
        ],
        paymentterms: [
          {
            label: "",
            value: ""
          }
        ]
      },
      columns: [
        {
          label: "Nombre",
          name: "name",
          field: "name",
          sortable: true,
          type: "string"
        },
        {
          label: "Apellido",
          field: "last_name",
          name: "last_name",
          sortable: true,
          type: "string"
        },
        {
          label: "email",
          field: "email",
          name: "email",
          sortable: true,
          type: "string"
        },
        {
          label: "Telefono",
          field: "phone",
          name: "phone",
          sortable: true,
          type: "string"
        },
        {
          label: "Celular",
          field: "phone_mobile",
          name: "phone_mobile",
          sortable: true,
          type: "string"
        },
        {
          label: "Notificar?",
          field: "notify",
          name: "notify",
          sortable: true,
          type: "string"
        },
        {
          label: "Acciones",
          field: "actions",
          name: "actions",
          width: "40px",
          sort: true,
          type: "string"
        }
      ],
      pathFetchData: "/api/contact/create"
    };
  },
  components: {
    kButton
  },
  computed: {
    hasName() {
      if (this.contact_others.name.length > 0) {
        if (
          this.contact_others.email != null &&
          this.contact_others.email != ""
        ) {
          return false;
        }
      }
      return true;
    }
  },
  methods: {
    cancelUpdateAssociate() {
      var vm = this;
      vm.isEditActive = false;
      vm.contact_others.id = "";
      vm.contact_others.name = "";
      vm.contact_others.last_name = "";
      vm.contact_others.email = "";
      vm.contact_others.phone = "";
      vm.contact_others.phone_mobile = "";
      vm.contact_others.notify = false;
    },
    updateAssociate() {
      let vm = this;

      if (vm.editIdAssociate >= 0) {
        vm.form.contact_others[vm.editIdAssociate].name =
          vm.contact_others.name;
        vm.form.contact_others[vm.editIdAssociate].last_name =
          vm.contact_others.last_name;
        vm.form.contact_others[vm.editIdAssociate].email =
          vm.contact_others.email;
        vm.form.contact_others[vm.editIdAssociate].phone =
          vm.contact_others.phone;
        vm.form.contact_others[vm.editIdAssociate].phone_mobile =
          vm.contact_others.phone_mobile;
        vm.form.contact_others[vm.editIdAssociate].notify =
          vm.contact_others.notify;
        vm.editIdAssociate = null;
        this.cancelUpdateAssociate();
      }
      vm.isEditActive = false;
    },
    editAssociate(val) {
      let vm = this;
      vm.isEditActive = true;
      vm.editIdAssociate = val.row.__index;

      vm.contact_others.name = val.row.name;
      vm.contact_others.last_name = val.row.last_name;
      vm.contact_others.email = val.row.email;
      vm.contact_others.phone = val.row.phone;
      vm.contact_others.phone_mobile = val.row.phone_mobile;
      vm.contact_others.notify = val.row.notify;
    },
    deleteAssociate(val) {
      this.form.contact_others.splice(val.row.__index, 1);
    },
    handleClose(newVal) {
      this.$emit("hide", newVal);
    },
    associateContact: function() {
      let vm = this;

      if (vm.form.contact_others === undefined) {
        vm.$set(vm.form, "contact_others", []);
      }
      vm.form.contact_others.push({
        name: vm.contact_others.name,
        last_name: vm.contact_others.last_name,
        email: vm.contact_others.email,
        phone: vm.contact_others.phone,
        phone_mobile: vm.contact_others.phone_mobile,
        notify: vm.contact_others.notify
      });
    },
    checkIfFieldHasError(error, field) {
      try {
        if (error.errors[field]) {
          return true;
        }
      } catch (err) {}

      return false;
    },
    fetchData(kindOfContact) {
      let vm = this;
      vm.isProcessing = true;
      axios
        .get(vm.pathFetchData)
        .then(function(response) {
          vm.$set(vm.$data, "form", response.data.form);
          vm.$set(vm.$data.base, "listprice", response.data.base.listprice);
          vm.$set(vm.$data.base, "sellers", response.data.base.sellers);
          vm.$set(
            vm.$data.base,
            "paymentterms",
            response.data.base.paymentterms
          );

          if (vm.kindOfProcess === "create") {
            if (kindOfContact === "client") {
              vm.form.isCustomer = true;
            }
            if (kindOfContact === "provider") {
              vm.form.isProvider = true;
            }
            vm.$set(vm.form, "contact_others", []);
          }
          vm.isProcessing = false;
        })
        .catch(function(error) {
          vm.isProcessing = false;
        });
    },

    //isCustomer= check si es cliente
    //isProvidre= check si es proveedor
    //kindOfProcess= create/edit
    //customerId= (opcional) id del contacto cuando se edita
    open(kindOfContact, kindOfProcess, customerId) {
      this.isEditActive = false;
      this.kindOfProcess = kindOfProcess;

      if (kindOfProcess === "edit") {
        this.pathFetchData = `/api/contact/${customerId}/edit`;
        this.toolbarLabel = "EDITAR CONTACTO";
      } else {
        this.pathFetchData = "/api/contact/create";
        this.toolbarLabel = "NUEVO CONTACTO";
      }

      this.fetchData(kindOfContact);

      this.$refs["contactModal"].show();
    },

    submit() {
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
          vm.handleClose();
        })
        .catch(function(error) {
          vm.$set(vm.$data, "errors", error.response.data);
          vm.isProcessing = false;
          kNotify(
            vm,
            "Ooops! No fue posible guardar el registro actual, intente de nuevo.",
            "negative"
          );
        });
    },

    update() {
      let vm = this;
      vm.isProcessing = true;
      axios
        .put("/api/contact/" + vm.form.id, vm.form)
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
          vm.$set(vm.$data, "errors", error.response.data);
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
