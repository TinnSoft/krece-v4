<template>
  
    <div style="width: 400px; max-width: 90vw;">

    
        <q-dialog v-model="openAttachFilesFormLayout">
          <q-card style="width: 650px; max-width: 80vw;">

              <q-bar>
                <q-icon name="attach_file" ></q-icon>
                <div>GESTIÓN DE ARCHIVOS</div>
      
                <q-space ></q-space>
      
                <q-btn dense flat icon="close" v-close-popup>
                  <q-tooltip>Cerrar</q-tooltip>
                </q-btn>
              </q-bar>

               <q-card-section>
                  <q-uploader
                    dense
                    :url="url"
                    label="Seleccione un archivo"
                  ></q-uploader>
              </q-card-section>
              
              <q-card-section>
                <q-list bordered class="rounded-borders" v-if="documentList.length >0" >
                  <q-item-label header>ARCHIVOS CARGADOS</q-item-label>
                  <q-item clickable v-for="item in documentList" :key="item.id">                    
                      <q-item-section>                        
                        <q-item-label>
                            {{item.filename}}                       
                        </q-item-label>
                        <q-item-label caption lines="1">Actualizado: {{item.created_at}}</q-item-label>
                      </q-item-section>
                      
                      <q-item-section top side>
                        <div class="text-grey-8 q-gutter-xs">
                          <q-btn class="gt-xs" size="12px" flat dense round @click="downloadFile(item.id)" icon="file_download">
                            <q-tooltip>Descargar</q-tooltip>
                          </q-btn>
                          <q-btn class="gt-xs" size="12px" flat dense round @click="deleteRow(item.id)" icon="delete" >
                            <q-tooltip>Eliminar</q-tooltip>
                          </q-btn>
                        </div>
                      </q-item-section>                   
                  </q-item>
                   
                </q-list>
              </q-card-section>
     
          </q-card>
        </q-dialog>

    </div>

</template>

<script>
export default {
  name:'kAttachFiles',
  data() {
    return {
      openAttachFilesFormLayout: false,
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
     // this.$refs["attachFileModal"].show();
      this.openAttachFilesFormLayout=true;
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