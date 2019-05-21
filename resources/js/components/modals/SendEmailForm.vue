<template>
     <q-page padding class="row justify-center">
        <div style="width: 500px; max-width: 90vw;">
            <q-dialog ref="emailModalForm"  v-ripple.mat :minimized="$q.platform.is.desktop" :content-css="{minWidth: '70vw', minHeight: '70vh'}">
                <q-card>
                <q-toolbar color="secondary" slot="header"> 
                    <q-btn flat round dense icon="mail">                
                    </q-btn>                   
                    <q-toolbar-title>
                        ENVIAR EMAIL
                    </q-toolbar-title>   
                    <q-btn flat round dense icon="person_add"  @click.native="openNewEmailModal()">
                        <q-tooltip>Adicionar nuevo destinatario</q-tooltip>
                    </q-btn>                 
                </q-toolbar>

                <div class="layout-padding">
                    <q-select multiple chips color="green" float-label="SELECCIONE LOS DESTINATARIOS" v-model="email.to" :options="listOfEmails"></q-select>
                    <br>
                    <q-input color="green" v-model="email.subject" float-label="ASUNTO"></q-input>
                    <br>

                    <q-editor
                      v-model="email.body"
                      :definitions="{
                        save: {
                          tip: 'Save your work',
                          icon: 'save',
                          label: 'Save'
                        },
                        upload: {
                          tip: 'Upload to cloud',
                          icon: 'cloud_upload',
                          label: 'Upload'
                        }
                      }"
                      :toolbar="[
                        ['bold', 'italic', 'strike', 'underline'],
                        ['upload', 'save']
                      ]"
                    ></q-editor>
                    <!--
                    <q-editor
                        v-model="email.body"              
                        :toolbar="[
                            ['bold', 'italic', 'strike', 'underline', 'subscript', 'superscript'],
                            ['token', 'hr', 'link', 'custom_btn'],
                            ['print', 'fullscreen'],
                            [
                            {
                                label: $q.i18n.editor.fontSize,
                                icon: $q.icon.editor.fontSize,
                                fixedLabel: true,
                                fixedIcon: true,
                                list: 'no-icons',
                                options: ['size-1', 'size-2', 'size-3', 'size-4', 'size-5', 'size-6', 'size-7']
                            },
                            'removeFormat'
                            ],
                            ['unordered', 'ordered'],
                            [
                            {
                                label: $q.i18n.editor.align,
                                icon: $q.icon.editor.align,
                                fixedLabel: true,
                                list: 'only-icons',
                                options: ['left', 'center', 'right', 'justify']
                            },
                            ],
                            ['undo', 'redo']
                        ]">
                            
                    </q-editor>
                    -->

                    
                </div>

                 <q-toolbar inverted slot="footer" color="secondary">
                    <q-btn dense flat color="faded" v-close-overlay label="Cancelar"></q-btn>
                        
                      <q-toolbar-title>                    
                      </q-toolbar-title>

                      <q-btn dense no-wrap :loading="loading" @click.native="send()" icon="send" color="green" label="Enviar">
                          <span slot="loading"><q-spinner-hourglass class="on-left" />
                              Enviando..
                          </span>                    
                        </q-btn>
                </q-toolbar>
                </q-card>
            </q-dialog>

            <q-dialog ref="emailModalForm_AddEmail" minimized :content-css="{padding: '20px'}">
                <q-field icon="email" helper="Solo está permitido adicionar un único destinatario" :count="50">
                    <q-input color="green" clearable v-model="newEmail" float-label="EMAIL" />
                </q-field>
                <br>
                <q-btn flat color="faded" v-close-overlay>Cancelar</q-btn>
                <q-btn @click.native="addNewEmail()" color="green">Agregar</q-btn>               
         
            </q-dialog>
            
        </div>
          
     </q-page>
</template>
 
 <script>

 import kNotify from "../../components/messages/Notify.js";

export default {
  data() {
    return {
      loading: false,
      email: {
        subject: "",
        body: "",
        to: [],
        additional_emails: [],
        model_from: "",
        public_id: ""
      },
      newEmail: "",
      path: "",
      errors: "",
      listOfEmails: []
    };
  },
  methods: {
    send() {
      let vm = this;
      if (vm.email.to.length) {
        vm.submit();
      } else {
         kNotify(vm,
          "Debe adicionar por lo menos un destinatario",
          "warning"
        );
      }
    },
    addNewEmail() {
      let vm = this;
      if (vm.newEmail) {
        vm.listOfEmails.push({
          label: vm.newEmail,
          value: vm.newEmail
        });
        vm.email.to.push(vm.newEmail);
        vm.newEmail = "";
      }
    },
    openNewEmailModal() {
      this.newEmail = "";
      this.$refs["emailModalForm_AddEmail"].show();
    },
    open(_documentID, _path, _model) {
      this.email.public_id = _documentID;
      this.path = _path;
      this.email.model_from = _model;
      this.email.to = [];
      this.listOfEmails = [];
      this.fetchData();
      this.$refs["emailModalForm"].show();
    },
    fetchData() {
      let vm = this;
      if (vm.path) {
        axios
          .get(`/api/${vm.path}/${vm.email.public_id}`)
          .then(function(response) {
            vm.$set(vm.$data.email, "body", response.data.body);
            vm.$set(vm.$data.email, "subject", response.data.subject);
            if (response.data.to) {
              vm.listOfEmails.push({
                label: response.data.to,
                value: response.data.to
              });
              vm.email.to.push(response.data.to);
            }

            vm.$set(
              vm.$data.email,
              "additional_emails",
              response.data.additional_emails
            );
          })
          .catch(function(error) {
            console.log(error.response.data, error.response)
            vm.$set(vm.$data, "errors", error);            
          });
      }
    },
    submit() {
      let vm = this;
      vm.loading = true;
      axios
        .post("/api/sendEmailToContact/", vm.email)
        .then(function(response) {
          if (response.data.created) {
             kNotify(vm,
              "Se ha enviado el correo al destinatario seleccionado",
              "positive"
            );
          } else {
             kNotify(vm,
              "OOPS! no fue posible enviar el correo... Intente de nuevo",
              "negative"
            );
          }
          vm.loading = false;
        })
        .catch(function(error) {
          kNotify(vm,
            "OOPS! no fue posible enviar el correo... Intente de nuevo",
            "negative"
          );
          vm.loading = false;
        });
    }
  }
};
</script>