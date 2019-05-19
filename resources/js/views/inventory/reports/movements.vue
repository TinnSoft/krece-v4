<template>
    <q-table ref="_mainMovementTable" :data="table" :columns="columns"
    :loading="loading" color="secondary" dense row-key="id" 
    :pagination.sync="paginationControl"
    :filter="filter">

        <template slot="top-right" slot-scope="props">                   
              <q-btn
                flat round dense
                :icon="props.inFullscreen ? 'fullscreen_exit' : 'fullscreen'"
                @click="props.toggleFullscreen"
              >
              <q-tooltip>Ver en pantalla completa</q-tooltip>
              </q-btn>
              
            </template>

            <template slot="top-left" slot-scope="props">
              <q-search
                hide-underline
                color="secondary"
                v-model="filter"
                class="col-6"
              />
            </template>

       <q-tr slot="header" slot-scope="props">
            <q-th auto-width v-for="col in props.cols" :key="col.name" :props="props">
              {{ col.label }}
            </q-th>
          </q-tr>      
         <q-tr slot="body" slot-scope="props" :props="props" class="cursor-pointer">
          <q-td auto-width v-for="col in props.cols" :key="col.name" :props="props">             
              <template v-if="col.name==='status_id'">
                  <rowStatus  :statusId="props.row.status_id" :processType="kmodule" ></rowStatus>
              </template>
              <template v-else>
                {{ col.value }} 
              </template>  
            </q-td>
         </q-tr>
    </q-table>
</template>
<script type="text/javascript">
import rowStatus from "../../../components/status/cStatus.vue";
import movementsCols from "./movements_cols";

export default {
  components: {
    rowStatus
  },
  props: ["path", "kmodule"],
  methods: {
    fetchData(path) {
      let vm = this;
      vm.loading = true;
      axios
        .get(`/api/${path}`)
        .then(function(response) {
          vm.$set(vm, "table", response.data);
          vm.loading = false;
        })
        .catch(function(error) {
          console.log(error.response);
          vm.loading = false;
        });
    },
    setColumns() {
      let vm = this;
      let colListToApply = movementsCols(vm.kmodule);
      vm.$set(vm, "columns", colListToApply);
      vm.fetchData(vm.path);
    }
  },
  data() {
    return {
      loading: false,
      table: [],
      columns: [],
      filter:"",
      paginationControl: { rowsPerPage: 10, page: 1 },
    };
  },
  watch: {
    kmodule() {
      this.setColumns();
    }
  },
  created() {
    this.setColumns();
  }
};
</script>
