<template>
<q-page padding>
    <!--
    <template v-if="income_value===0 && outcome_value===0">    
      <transition
              enter-active-class="animated bounceInLeft"
              leave-active-class="animated bounceOutRight"
              appear
            >
                <q-banner class="bg-primary text-white"
                  v-if="visible"
                  appear                                  
                >
                  <template v-slot:avatar>
                    <q-icon name="info_outline" color="primary" ></q-icon>
                  </template>
                  {{withouthMovementsMsg}}
                  <template v-slot:action>
                    <q-btn flat color="white" label="Cerrar" ></q-btn>
                  </template>
                  
                </q-banner>
      </transition>
    </template>
    -->
    <div class="q-pa-md">  
      <div class="row">
        <div class="col">
           <cardTotal class="my-card" title="INGRESOS" background-color="primary" icon-name="" :total="income_value" subtitle="Total entradas" />
             
        </div>
        <div class="col">
           <cardTotal class="my-card" title="EGRESOS" background-color="orange" icon-name="" :total="outcome_value" subtitle="Total gastos" />              
            
        </div>
      </div>  
      <br>
      <div class="row">
        <div class="col">
           <q-card class="my-card">
              <q-card-section>
                <q-toolbar class="text-primary">                 
                  <q-toolbar-title>
                    INGRESOS/EGRESOS
                  </q-toolbar-title>
                  <!--<q-btn flat round dense icon="date_range" ></q-btn>    -->
                    <q-btn-dropdown split outline dense
                      push disable-main-btn
                      :label="filterBylabel"
                      icon="filter_list">
                      <q-list dense>
                        <q-item clickable v-close-popup @click.native="filterPeriod('d')">
                          <q-item-label>
                            <q-item-section label >Hoy</q-item-section>
                          </q-item-label>
                        </q-item>
                        <q-item clickable v-close-popup @click.native="filterPeriod('w')">
                          <q-item-label>
                            <q-item-section label >Última semana</q-item-section>
                          </q-item-label>
                        </q-item>
                        <q-item clickable v-close-popup @click.native="filterPeriod('m')">
                          <q-item-label>
                            <q-item-section label>Último mes</q-item-section>
                          </q-item-label>
                        </q-item>
                        <q-item clickable v-close-popup @click.native="filterPeriod('y')">
                          <q-item-label>
                            <q-item-section label >Último Año</q-item-section>
                          </q-item-label>
                        </q-item>
                      </q-list>
                    </q-btn-dropdown>
                </q-toolbar>              
              </q-card-section>

              <q-card-section>
                <q-tabs
                  v-model="tab"
                  dense
                  class="text-grey"
                  active-color="purple"
                  indicator-color="purple"
                  align="justify"
                  narrow-indicator
                >
                  <q-tab name="causado" label="causado" >
                  </q-tab>
                  <q-tab name="pagado" label="pagado" ></q-tab>
                </q-tabs>
                <q-tab-panels v-model="tab" animated>
                  <q-tab-panel name="causado">
                    <dashboardChart :chart-data="datacollection" :options="lineOptions" :dataOriginal="datacollection.datasets[0].data"/>
                 
                  </q-tab-panel>
        
                  <q-tab-panel name="pagado">
                    <div class="text-h6">Alarms</div>
                    Lorem ipsum dolor sit amet consectetur adipisicing elit.
                  </q-tab-panel>
                </q-tab-panels>
  
               </q-card-section>
        
            </q-card>
        </div>
        <div class="col">
           <q-card class="my-card">
              <q-card-section>
                 <q-toolbar class="text-primary">                 
                  <q-toolbar-title>
                    GASTOS
                  </q-toolbar-title>
                  <q-btn flat round dense icon="perm_data_setting" ></q-btn>                  
                </q-toolbar>
              </q-card-section>

              <q-card-section>
                <dashboardChart :chart-data="datacollection" :options="lineOptions" :dataOriginal="datacollection.datasets[0].data"/>
              </q-card-section>
        
            </q-card>
        </div>
      </div>  
    </div>

    
   
</q-page>
</template>

<script>
import dashboardChart from "../components/chart/Line.js";
import cardTotal from "../components/cCard.vue";

export default {
  name: "home",
  middleware: "auth",
  components: {
    dashboardChart,
    cardTotal
  },
  data: function() {
    return {
      tab: 'causado',
      filterBylabel: "Hoy",
      model: 30,
      min: 0,
      max: 50,
      visible: false,
      withouthMovementsMsg: "Aún no tienes movimientos creados.",
      isProcessing: false,
      filter: "d",
      path: "getDashboardInfo",
      form: {},
      datacollection: {},
      YearLabels: [
        "Enero",
        "Febrero",
        "Marzo",
        "Abril",
        "Mayo",
        "Junio",
        "Julio",
        "Agosto",
        "Septiembre",
        "Octubre",
        "Noviembre",
        "Diciembre"
      ],
      WeekLabels: [
        "Lunes",
        "Martes",
        "Miercoles",
        "Jueves",
        "Viernes",
        "Sabado",
        "Domingo"
      ],
      lineOptions: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          yAxes: [
            {
              ticks: {
                callback: function(value, index, values) {
                  return value.toLocaleString("en-US", {
                    style: "currency",
                    currency: "USD"
                  });
                }
              }
            }
          ]
        },
        tooltips: {
          enabled: true,
          callbacks: {
            label: function(tooltipItems, data) {
              return tooltipItems.yLabel.toLocaleString("en-US", {
                style: "currency",
                currency: "USD"
              });
            }
          }
        }
      }
    };
  },
  metaInfo() {
    return { title: this.$t("home") };
  },
  created() {
    this.fillOptions();
    this.fetchData();
  },
  computed: {
    income_value() {
      try {
        if (this.filter === "d") {
          return this.form.income.day;
        } else if (this.filter === "w") {
          return this.form.income.week;
        } else if (this.filter === "m") {
          return this.form.income.month;
        } else if (this.filter === "y") {
          return this.form.income.year;
        }
      } catch (e) {
        return 0;
      }
    },
    outcome_value() {
      try {
        if (this.filter === "d") {
          return this.form.outcome.day;
        } else if (this.filter === "w") {
          return this.form.outcome.week;
        } else if (this.filter === "m") {
          return this.form.outcome.month;
        } else if (this.filter === "y") {
          return this.form.outcome.year;
        }
      } catch (e) {
        return 0;
      }
    }
  },
  methods: {
    fillOptions() {
      this.datacollection = {
        labels: [],
        datasets: [
          {
            label: "Ingresos",
            fill: true,
            // lineTension: 0.1,
            backgroundColor: "rgba(26,179,148,0.5)",
            borderColor: "rgba(26,179,148,0.7)",
            borderCapStyle: "butt",
            borderDash: [],
            borderDashOffset: 0.0,
            borderJoinStyle: "miter",
            pointBorderColor: "#fff",
            pointBackgroundColor: "rgba(26,179,148,1)",
            pointBorderWidth: 1,
            pointHoverRadius: 5,
            pointHoverBackgroundColor: "rgba(75,192,192,1)",
            pointHoverBorderColor: "rgba(220,220,220,1)",
            pointHoverBorderWidth: 2,
            pointRadius: 1,
            pointHitRadius: 10,
            data: [],
            spanGaps: false
          },
          {
            label: "Gastos",
            fill: true,
            // lineTension: 0.1,
            backgroundColor: "rgba(235, 200, 181,0.4)",
            borderColor: "rgba(245, 127, 64,1)",
            borderCapStyle: "butt",
            borderDash: [],
            borderDashOffset: 0.0,
            borderJoinStyle: "miter",
            pointBorderColor: "rgba(245, 127, 64,1)",
            pointBackgroundColor: "#fff",
            pointBorderWidth: 1,
            pointHoverRadius: 5,
            pointHoverBackgroundColor: "rgba(245, 127, 64,1)",
            pointHoverBorderColor: "rgba(245, 127, 64,1)",
            pointHoverBorderWidth: 2,
            pointRadius: 1,
            pointHitRadius: 10,
            data: [],
            spanGaps: false
          }
        ]
      };
    },
    filterPeriod(val) {
      let baseData = this.form.graph_data;
      let collection = this.datacollection;
      this.filter = val;

      if (val == "d") {
        this.filterBylabel = "Hoy";
        collection.labels = this.WeekLabels;
        collection.datasets[0].data = baseData.weekData_income;
        collection.datasets[1].data = baseData.weekData_outcome;
      } else if (val == "w") {
        this.filterBylabel = "Ultima Semana";
        collection.labels = this.WeekLabels;
        collection.datasets[0].data = baseData.weekData_income;
        collection.datasets[1].data = baseData.weekData_outcome;
      } else if (val == "m") {
        this.filterBylabel = "Ultimo Mes";
        collection.labels = baseData.labels_current_month;
        collection.datasets[0].data = baseData.data_by_day_current_month_in;
        collection.datasets[1].data = baseData.data_by_day_current_month_out;
      } else if (val == "y") {
        this.filterBylabel = "Ultimo Año";
        collection.labels = this.YearLabels;
        collection.datasets[0].data = baseData.DataBymont_peryear_in;
        collection.datasets[1].data = baseData.DataBymont_peryear_out;
      }
    },
    fetchData() {
      let vm = this;

      vm.isProcessing = true;
      axios
        .get(`/api/${vm.path}`)
        .then(function(response) {
          vm.$set(vm.$data, "form", response.data.form);
          vm.datacollection.datasets[0].data =
            vm.form.graph_data.weekData_income;
          vm.datacollection.datasets[1].data =
            vm.form.graph_data.weekData_outcome;
          vm.datacollection.labels = vm.WeekLabels;
          vm.isProcessing = false;

          if (vm.income_value === 0 && vm.outcome_value === 0) {
            vm.visible = true;
          }
        })
        .catch(function(error) {
          vm.isProcessing = false;
        });
    }
  }
};
</script>
<style lang="stylus">
.my-card
  width 100%
  max-width 95%
</style>