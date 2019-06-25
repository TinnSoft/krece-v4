<template>
  <div class="q-pa-md q-gutter-sm">
    <q-dialog v-model="openEmailFormLayout">
      <q-card style="width: 650px; max-width: 80vw;">
        <q-bar>
          <q-icon name="mail"></q-icon>
          <div>ENVIAR EMAIL</div>

          <q-space></q-space>

          <q-btn dense flat icon="close" v-close-popup>
            <q-tooltip>Cerrar</q-tooltip>
          </q-btn>
        </q-bar>

        <q-card-section>
          <q-select
            dense
            clearable
            multiple
            filled
            chips
            label="*SELECCIONE LOS DESTINATARIOS"
            v-model="email.to"
            :options="listOfEmails"
            use-chips
            options-dense
          >
            <template v-slot:after>
              <q-btn flat round dense icon="person_add" @click.native="openNewEmailModal()">
                <q-tooltip>Adicionar nuevo destinatario</q-tooltip>
              </q-btn>
            </template>
          </q-select>
          <br>
          <q-input dense clearable filled v-model="email.subject" label="*ASUNTO"></q-input>
          <br>
        </q-card-section>

        <q-card-section>
          <q-editor
            :dense="$q.screen.lt.md"
            v-model="email.body"
            :toolbar="[
                            ['bold', 'italic', 'strike','token', 'hr', 'link', 'custom_btn'],
                            ['print', 'fullscreen'],
                                [
                                  {
                                    label: $q.lang.editor.align,
                                    icon: $q.iconSet.editor.align,
                                    fixedLabel: true,
                                    list: 'only-icons',
                                    options: ['left', 'center', 'right', 'justify']
                                  },
                                ],
                                ['unordered', 'ordered'],                        
                                ['undo', 'redo']
                              ]"
          ></q-editor>
        </q-card-section>

        <q-card-actions align="right" class="text-primary">
          <q-btn
            dense
            :loading="loading"
            color="primary"
            @click.native="send()"
            icon="mail_outline"
            label="Enviar"
          >
            <span slot="loading">
              <q-spinner-hourglass class="on-left"/>Enviando..
            </span>
          </q-btn>
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog v-model="openAddEmailFormLayout">
      <q-card style="width: 500px; max-width: 80vw;">
        <q-card-section>
          <div class="text-h6">Agregar Email</div>
        </q-card-section>

        <q-card-section>
          <q-input
            dense
            type="email"
            filled
            clearable
            v-model="newEmail"
            label="*EMAIL"
            counter
            maxlength="80"
          >
            <template v-slot:prepend>
              <q-icon name="email"></q-icon>
            </template>
            <template v-slot:hint>Caracteres</template>
          </q-input>
        </q-card-section>

        <q-card-actions align="right" class="text-primary">
          <q-btn flat color="grey-6" label="Cancelar" v-close-popup></q-btn>
          <q-btn flat label="Agregar" @click="addNewEmail()"></q-btn>
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>
 
 <script>
import kNotify from "../components/messages/Notify.js";

export default {
  name: "kSendEmailForm",
  data() {
    return {
      loading: false,
      openEmailFormLayout: false,
      openAddEmailFormLayout: false,
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
        kNotify(vm, "Debe adicionar por lo menos un destinatario", "warning");
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
      //this.$refs["emailModalForm_AddEmail"].show();
      this.openAddEmailFormLayout = true;
    },
    open(_documentID, _path, _model) {
      this.email.public_id = _documentID;
      this.path = _path;
      this.email.model_from = _model;
      this.email.to = [];
      this.listOfEmails = [];
      this.fetchData();
      //this.$refs["emailModalForm"].show();
      this.openEmailFormLayout = true;
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
            kNotify(
              vm,
              "Se ha enviado el correo al destinatario seleccionado",
              "positive"
            );
          } else {
            kNotify(
              vm,
              "OOPS! no fue posible enviar el correo... Intente de nuevo",
              "negative"
            );
          }
          vm.loading = false;
        })
        .catch(function(error) {
          kNotify(
            vm,
            "OOPS! no fue posible enviar el correo... Intente de nuevo",
            "negative"
          );
          vm.loading = false;
        });
    }
  }
};
</script>