<template>
  <div class="line-main">
    <div>
      <span class="tag">{{ tag }}</span>
      <span class="time-show">
        <span class="top-bar" style="font-size: 12px;">时间选择</span>
        <el-select size="mini" style="width: 90px;" v-model="selectedValue" placeholder="期限">
          <el-option v-for="item in options" :key="item.num" :label="item.name" :value="item.num">
          </el-option>
        </el-select>
      </span>
    </div>
    <div ref="chart" :style="{ width: '100%', height: height }"></div>
  </div>
</template>

<script>
// 折线图组件
import * as echarts from 'echarts';
export default {
  name: 'DialogLine',
  props: {
    tag: {
      type: String,
      default: '折线图'
    },
    values: {
      type: Array,
      required: true
    },
    date: {
      type: Array,
      required: true
    },
    height: {
      type: String,
      default: '300px' // 增加高度以显示更多标签
    },
  },
  watch: {
    selectedValue: {
      handler(newVal, oldVal) {
        this.$emit('on-selected', newVal);
      },
      deep: true,
      immediate: false // 如果需要在初始化时也触发监听，可以设为 true
    },
    values: {
      handler(newVal, oldVal) {
        this.initChart();
      },
      deep: true,
      immediate: false // 根据需要选择是否开启
    }
  },
  data() {
    return {
      chart: null,
      options: [{ num: 7, name: '7天内' }, { num: 30, name: '30天内' }, { num: 60, name: '60天内' }],
      selectedValue: '',
    }
  },
  methods: {
    // 图表初始化
    initChart() {
      this.sortDates();
      this.chart = echarts.init(this.$refs.chart);
      let option = {
        grid: {
          left: 50, // 增加左边距
          right: 30,
          top: 50,
          borderWidth: 0,
        },
        title: {
           text: '',
            color: '#ffffff',
        },
        tooltip: {
          trigger: 'axis',
          formatter: '{b}->{c}',
        },
        legend: {
           data: ['']
        },
        xAxis: {
           data: this.date,
           axisLine: { show: false },
           axisTick: { show: false },
           axisLabel: {
            color: 'rgb(51，51，51)',
            fontSize: '14'
          },
        },
        yAxis: {
           axisLine: { show: false },
           axisTick: { show: false },
           axisLabel: {
            color: 'rgb(51，51，51)',
            fontSize: '14'
          },
        },
        series: [{
          name: '',
          type: 'line',
          smooth: true,
          data: this.values,
          areaStyle: {
            color: 'rgba(144, 191, 237, 0.3)'
          },
          lineStyle: {
            color: '#5B8FF9'
          },
          itemStyle: {
            color: '#5B8FF9',
            borderColor: '#5B8FF9',
            borderWidth: 2
          },
          label: {
            show: true,
            position: 'top',
            color: 'rgb(102, 102, 102)',
          },
         }]
      };
      this.chart.setOption(option);
    },
    sortDates() {
      this.date.sort(((a, b) => new Date(a) - new Date(b)));
    },
  beforeDestroy() {
    if (!this.chart) {
      return;
    }
    this.chart.dispose();
  },
},
}
</script>

<style scoped lang="scss">
.line-main {
  margin-bottom: 5px;
  border-radius: 3px;

  .tag {
    font-size: 14px;
    padding: 15px 16px;
    display: inline-block;
    color: #6f6d6d;
    font-weight: bold;
  }

  .time-show {
    padding: 15px 6px;
    float: right;
  }
}
</style>