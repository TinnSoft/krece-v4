<template>
  <div>
      <q-markup-table flat bordered dense separator="none">  
                  <thead class="bg-light-blue-1">
                      <tr  class style="text-align: left;">                        
                          <th >NOMBRE</th>
                          <th >DESCRIPCIÓN</th>
                          <th>CUENTA NIIF</th>
                          <th>ACCIONES</th>
                      </tr>
                  </thead>
                  <tbody>
            
                      <tr v-for="(item ,index)  in (arrayTreeObj)" :key="index"  v-bind:class="[(item.id != selectedRowID.id) ? 'my-label':'text-blue bg-light-blue-1','']"  @click="selectedRow(item)" >
                          <td  data-th="NOMBRE" @click="toggle(item, index)">
                          
                              <span class="q-tree-link q-tree-label items-center" v-bind:style="setPadding(item)" >                
                                  <q-icon size="24px" style="cursor: pointer;" :name="iconName(item)"  />
                                  {{item.name}}
                              </span>
                          
                          </td>
                          <td  data-th="DESCRIPCIÓN">{{item.description}}</td>
                          <td width="20%" data-th="CUENTA NIIF">{{item.niif_account}} </td>
                          <td width="10%" data-th="ACCIONES"> 
                            <kButton color="grey" iconname="add_circle" tooltiplabel="Agregar Categoría" @click="openProductModal($refs,'create', item.id)"></kButton>
                            <kButton  v-if="item.isEditable==true" color="grey"   iconname="edit" tooltiplabel="Editar" @click="openProductModal($refs,'edit', item.id)"></kButton>
                         
                           <kButton v-if="item.isEditable==true" color="red"  iconname="delete" tooltiplabel="Eliminar Categoría" @click="remove(item)"></kButton>
                                                 
                          </td>
                      </tr>
                  </tbody>
          
      </q-markup-table>            
            <mAddCategory ref="_addCategory"  @hide="hideCategoryModal"></mAddCategory>
              <q-inner-loading :visible="isProcessing">
                <q-spinner-mat size="50px" color="teal-4" />{{loadingMessage}}
            </q-inner-loading>
  </div>
</template>

<script>
import kButton from "../../components/tables/cButton.vue";
import mAddCategory from "./mNewCategory.vue";
import kNotify from "../../components/messages/Notify.js";

export default {
  props: {
    columns: {
      type: [Array, Object],
      default: () => []
    },
    route: {
      type: String,
      default: null
    },
    selectedIDRow: {
      type: Number,
      default: null
    }
  },
  components: {
    kButton,
   mAddCategory
  },
  data() {
    return {
      search: "",
      loadingMessage: null,
      isProcessing: false,
      selectedRowID: {},
      table: [],
      itemId: null,
      isExpanded: true
    };
  },
  watch: {
    selectedIDRow: function(val) {
      if (this.selectedRowID != null) {
        this.$set(this.selectedRowID, "id", val);
      }
    }
  },
  computed: {
    arrayTreeObj() {
      let vm = this;
      var newObj = [];
      vm.recursive(vm.table, newObj, 0, vm.itemId, vm.isExpanded);
      return newObj;
    }
  },
  methods: {
    iconName(item) {
      if (item.expend == true) {
        return "remove_circle_outline";
      }

      if (item.children && item.children.length > 0) {
        return "control_point";
      }

      return "done";
    },
    toggle(item, index) {
      let vm = this;
      vm.itemId = item.id;

      item.leaf = false;
      //Muestra los sub items al dar click en +
      if (
        item.leaf == false &&
        item.expend == undefined &&
        item.children != undefined
      ) {
        if (item.children.length != 0) {
          vm.recursive(item.children, [], item.level + 1, item.id, true);
        }
      }

      //Eliminar items cuando se da click en ocultar fila
      if (item.expend == true && item.children != undefined) {
        var __subindex = 0;
        item.children.forEach(function(o) {
          o.expend = undefined;
        });

        vm.$set(item, "expend", undefined);
        vm.$set(item, "leaf", false);
        vm.itemId = null;
      }
    },
    setPadding(item) {
      return `padding-left: ${item.level * 30}px;`;
    },
    recursive(obj, newObj, level, itemId, isExpanded) {
      let vm = this;

      obj.forEach(function(o) {
        if (o.children && o.children.length != 0) {
          o.level = level;
          o.leaf = false;
          newObj.push(o);
          if (o.id == itemId) {
            o.expend = isExpanded;
          }
          if (o.expend == true) {
            vm.recursive(o.children, newObj, o.level + 1, itemId, isExpanded);
          }
        } else {
          o.level = level;
          o.leaf = true;
          newObj.push(o);
          return false;
        }
      });
    },
    openProductModal(refs, processType, itemId) {
      refs._addCategory.open(processType, itemId);
    },
    hideCategoryModal() {
      this.fetchData();
    },
    fetchData() {
      let vm = this;
      vm.loadingMessage = "Cargando...";
      vm.isProcessing = true;
      if (vm.route.length > 0) {
        axios
          .get(`/api/${vm.route}`)
          .then(function(response) {
            vm.$set(vm, "table", response.data);
            vm.isProcessing = false;
          })
          .catch(function(error) {
            vm.isProcessing = false;
            if (error.response.data.message) {
              kNotify(vm, error.response.data.message, "negative");
            }
            if (error.response.data.redirectTo) {
              vm.$router.replace(`${error.response.data.redirectTo}`);
            }
          });
      }
    },
    selectedRow(row, clicked) {
      let vm = this;
      vm.selectedRowID = row;
      vm.$emit("click", row);
    },
    remove(val) {
      var vm = this;
     vm.$q
        .dialog({
          title: "Tenga Cuidado!",
          message: "Está seguro de eliminar la categoría: " + val.name,
          ok: "SI, Eliminar!",
          cancel: "NO, Cancelar",
        })
        .onOk(() => {
          vm.submit(val.id);
        })
        .onCancel(() => {});
    },
    submit(categoryid) {
      let vm = this;
      vm.isProcessing = true;
      vm.loadingMessage = "Eliminando...";
      axios
        .delete("/api/category/" + categoryid)
        .then(function(response) {
          if (response.data.deleted) {
            kNotify(
              vm,
              "Se eliminó satisfactoriamente la categoría seleccionada",
              "positive"
            );
            vm.fetchData();
            vm.isProcessing = false;
          }
        })
        .catch(function(error) {
          vm.isProcessing = false;
          kNotify(
            vm,
            "Ooops! No fue posible la categoría seleccionada, intente de nuevo.",
            "negative"
          );
        });
    }
  },
  created() {
    this.fetchData();
  }
};
</script>


