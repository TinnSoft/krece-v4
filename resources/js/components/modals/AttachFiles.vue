<template>
  <q-page class="row justify-center">
    <div style="width: 400px; max-width: 90vw;">

      <q-modal ref="attachFileModal" v-ripple.mat :minimized="$q.platform.is.desktop" :content-css="{minWidth: '50vw', minHeight: '50vh'}">
        <q-modal-layout>
                <q-toolbar color="secondary" slot="header"> 
                    <q-btn flat round  icon="attach_file">                
                    </q-btn>                   
                    <q-toolbar-title>
                        Gestion de Archivos
                    </q-toolbar-title>   
                    <q-btn flat round  icon="exit_to_app" v-close-overlay>
                    </q-btn>                 
                </q-toolbar>

        
           <div class="layout-padding">
              <div class="q-subheading">Aquí podrás gestionar los archivos del documento actual</div>

              <br>
              <q-field icon="file_upload" :helper="helper">
                <q-uploader color="secondary" ref="testx" @finish="endUpload($refs)" 
                :additionalFields="additionalfields" float-label="Seleccione un archivo"
                 :url="url" ></q-uploader>

              </q-field>
              <br>
              <q-list v-if="documentList.length >0" class="no-margin no-padding">
                <q-item-label inset>MIS ARCHIVOS</q-item-label>
                <q-item v-for="item in documentList" :key="item.id">
                  <q-btn class="no-margin no-padding" @click="downloadFile(item.id)" icon="file_download" color="secondary" flat></q-btn>
                  <q-item-label>
                    <q-item-section label>
                      <small>{{item.filename}}</small>
                    </q-item-section>
                    <q-item-section sublabel>Cargado: {{item.created_at}}</q-item-section>
                  </q-item-label>
                  <q-btn @click="deleteRow(item.id)" class="no-margin no-padding" style="float: right;" icon="close" color="red" flat></q-btn>
                </q-item>
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
      url: "/api/document",
      error: false,
      helper:
        'Recuerda que el tamaño máximo de los archivos a cargar es de 2MB',
      documentList: [],
      model: "",
      public_id: "",
      additionalfields: []
    };
  },
  components: {},
  methods: {
    notification(message, msgtype) {
      this.$q.notify({
        message,
        timeout: 3000,
         type: msgtype,
        });
    },
    endUpload(ref) {
      //console.log(ref.testx);
      if (ref.testx.files[0].__failed == true) {
        this.notification(
          'Algo salió mal con la carga del archivo, intente nuevamente','warning'
        );
      } else {
        this.notification('Se cargó el archivo correctamente','positive');
      }
      this.fetchData();
    },
    fetchData() {
      var vm = this;
      axios
        .get(`/api/getDocuments/${vm.public_id}/${vm.model}`)
        .then(function(response) {
          vm.$set(vm.$data, "documentList", response.data.list);
        })
        .catch(function(error) {});
    },
    downloadFile(id) {
      var vm = this;
      axios
        .get(`/api/downloadDocuments/${id}`)
        .then(function(response) {
          // console.log(response.data);
        })
        .catch(function(error) {});
    },
    deleteRow(id) {
      var vm = this;
      if (id) {
        axios
          .delete("/api/deleteDocuments/" + id)
          .then(function(response) {
            if (response.data.deleted) {
              vm.fetchData();
              vm.notification('Se eliminó el archivo correctamente','positive');
            }
          })
          .catch(function(error) {
            vm.notification(
              'No se pudo eliminar el archivo, intente nuevamente','negative'
            );
          });
      }
    },
    open(id, model) {
      this.model = model;
      this.public_id = id;

      this.additionalfields = [
        {
          name: "model",
          value: model
        },
        {
          name: "publicID",
          value: id
        }
      ];

      let data = new FormData();
      this.$refs["attachFileModal"].show();
      this.fetchData();
    }
  }
};
</script>
<style>
.inputfile + label {
  font-size: 1.25em;
  font-weight: 700;
  color: white;
  background-color: black;
  display: inline-block;
}

.inputfile:focus + label,
.inputfile + label:hover {
  background-color: red;
}
</style>