
import { Line, mixins } from 'vue-chartjs'

export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ['chartData', 'options', 'dataOriginal'],
  watch: {
    'dataOriginal'() {
      this.renderChart(this.chartData, this.options);    
      console.log(this.chartData)
    }
  },
  mounted() {
    this.renderChart(this.chartData, this.options)
  },
  beforeDestroy() {
    if (this._chart) {
      this._chart.destroy()
    }
  }
}

