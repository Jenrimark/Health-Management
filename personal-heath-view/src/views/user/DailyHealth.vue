<template>
  <div class="daily-health">
    <!-- 添加头部标签 -->
    <div class="page-header">
      <h2 class="page-title">我的运动</h2>
      <p class="page-subtitle">记录和追踪您的日常运动数据，保持健康生活方式</p>
    </div>
    
    <!-- 统计功能卡片（保留） -->
    <el-card class="box-card stats-card">
      <div slot="header" class="clearfix">
        <span>运动数据统计</span>
        <div class="stat-controls">
          <el-radio-group v-model="statType" size="small" @change="updateStats">
            <el-radio-button label="week">周统计</el-radio-button>
            <el-radio-button label="month">月统计</el-radio-button>
          </el-radio-group>
          
          <el-date-picker
            v-if="statType === 'week'"
            v-model="selectedWeek"
            type="week"
            format="yyyy 第 WW 周"
            placeholder="选择周"
            @change="updateStats"
            size="small">
          </el-date-picker>
          
          <el-date-picker
            v-else
            v-model="selectedMonth"
            type="month"
            placeholder="选择月"
            @change="updateStats"
            size="small">
          </el-date-picker>
        </div>
      </div>
      
      <div class="stats-container">
        <div class="stats-summary">
          <div class="stat-item">
            <div class="stat-value">{{ totalSteps }}</div>
            <div class="stat-label">总步数</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">{{ totalDuration }}</div>
            <div class="stat-label">总时长(分钟)</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">{{ totalCaloriesBurned }}</div>
            <div class="stat-label">总消耗热量(kcal)</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">{{ averageStepsPerDay }}</div>
            <div class="stat-label">平均每日步数</div>
          </div>
        </div>
        
        <!-- 图表区域 -->
        <div class="charts-container">
          <div class="chart" ref="stepsChart"></div>
          <div class="chart" ref="caloriesChart"></div>
        </div>
      </div>
    </el-card>
    
    <!-- 我的运动记录卡片（还原为原始版本） -->
    <el-card class="box-card">
      <div slot="header" class="clearfix card-header">
        <span class="header-title">我的运动记录</span>
        
        <!-- 筛选元素整合到标题行 -->
        <div class="header-filters">
          <div class="filter-item">
            <el-date-picker
              v-model="dateRange"
              type="daterange"
              range-separator="至"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
              size="small"
              value-format="yyyy-MM-dd">
            </el-date-picker>
          </div>
          
          <div class="filter-item">
            <el-select 
              v-model="exerciseTypeFilter" 
              placeholder="运动方式" 
              size="small"
              clearable>
              <el-option label="跑步" value="跑步"></el-option>
              <el-option label="步行" value="步行"></el-option>
              <el-option label="游泳" value="游泳"></el-option>
              <el-option label="骑行" value="骑行"></el-option>
              <el-option label="爬山" value="爬山"></el-option>
              <el-option label="其他" value="其他"></el-option>
            </el-select>
          </div>
          
          <div class="filter-actions">
            <el-button type="primary" size="mini" icon="el-icon-search" circle @click="handleFilter"></el-button>
            <el-button size="mini" icon="el-icon-refresh" circle @click="resetFilter"></el-button>
          </div>
        </div>
        
        <el-button class="add-record-btn" type="primary" size="small" icon="el-icon-plus" @click="handleAdd">添加记录</el-button>
      </div>
      
      <el-table :data="filteredHealthPlans" style="width: 100%" class="health-table">
        <el-table-column prop="planDate" label="日期" width="120" align="center" header-align="center">
          <template slot-scope="scope">
            {{ formatDate(scope.row.planDate) }}
          </template>
        </el-table-column>
        <el-table-column prop="steps" label="步数" width="120" align="center" header-align="center"/>
        <el-table-column prop="exerciseMinutes" label="时间(分)" width="120" align="center" header-align="center"/>
        <el-table-column prop="exerciseType" label="运动方式" width="120" align="center" header-align="center"/>
        <el-table-column prop="caloriesBurned" label="热量(kcal)" width="120" align="center" header-align="center"/>
        <el-table-column label="操作设置" align="center" header-align="center">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 添加/编辑健康计划对话框（还原为原始版本） -->
    <el-dialog 
      :show-close="false" 
      :visible.sync="dialogVisible" 
      width="40%"
      class="custom-dialog">
      <div style="padding:16px 20px;">
        <p>{{ dialogTitle }}</p>
        
        <div style="margin-block: 10px;">
          <span class="dialog-hover">日期</span>
          <el-date-picker 
            v-model="form.planDate" 
            type="date" 
            placeholder="选择日期"
            style="width: 200px;">
          </el-date-picker>
        </div>
        
        <div style="margin-block: 10px;">
          <span class="dialog-hover">运动步数</span>
          <el-input-number 
            v-model="form.steps" 
            :min="0" 
            :max="50000"
            style="width: 200px;">
          </el-input-number>
        </div>
        
        <div style="margin-block: 10px;">
          <span class="dialog-hover">运动时间</span>
          <el-input-number 
            v-model="form.exerciseMinutes" 
            :min="0" 
            :max="300"
            style="width: 200px;">
          </el-input-number>
        </div>
        
        <div style="margin-block: 10px;">
          <span class="dialog-hover">运动方式</span>
          <el-select 
            v-model="form.exerciseType" 
            placeholder="选择运动方式"
            style="width: 200px;">
            <el-option label="跑步" value="跑步"></el-option>
            <el-option label="步行" value="步行"></el-option>
            <el-option label="游泳" value="游泳"></el-option>
            <el-option label="骑行" value="骑行"></el-option>
            <el-option label="爬山" value="爬山"></el-option>
            <el-option label="其他" value="其他"></el-option>
          </el-select>
        </div>
        
        <div style="margin-block: 10px;">
          <span class="dialog-hover">消耗热量</span>
          <el-input-number 
            v-model="form.caloriesBurned" 
            :min="0" 
            :max="3000"
            style="width: 200px;">
          </el-input-number>
        </div>
      </div>
      
      <span slot="footer" class="dialog-footer" style="margin-top: 10px;">
        <span class="channel-button" @click="dialogVisible = false">
          取消操作
        </span>
        <span class="edit-button" @click="submitForm">
          {{ form.id ? '确定修改' : '确定新增' }}
        </span>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import * as echarts from 'echarts';

export default {
  data() {
    return {
      // 原始健康计划数据
      healthPlans: [],
      latestHealthPlan: null,
      dialogVisible: false,
      dialogTitle: '添加记录',
      form: {
        planDate: '',
        steps: 8000,
        exerciseMinutes: 30,
        exerciseType: '跑步',
        caloriesBurned: 300
      },
      rules: {
        planDate: [{ required: true, message: '请选择日期', trigger: 'change' }],
        steps: [{ required: true, message: '请输入运动步数', trigger: 'blur' }]
      },
      
      // 统计数据（保留）
      statType: 'week',
      selectedWeek: new Date(),
      selectedMonth: new Date(),
      totalSteps: 0,
      totalDuration: 0,
      totalCaloriesBurned: 0,
      averageStepsPerDay: 0,
      statsData: [],
      
      // 图表实例（保留）
      stepsChart: null,
      caloriesChart: null,
      
      // 筛选相关数据
      dateRange: [],
      exerciseTypeFilter: '',
      filteredHealthPlans: []
    };
  },
  created() {
    this.fetchPlans();
    this.fetchLatestPlan();
    this.updateStats();
  },
  mounted() {
    this.$nextTick(() => {
      this.initCharts();
    });
  },
  methods: {
    formatDate(dateString) {
      if (!dateString) return '';
      const date = new Date(dateString);
      return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`;
    },
    
    // 原始健康计划方法（还原）
    async fetchPlans() {
      try {
        const response = await this.$axios.post('/health-plans/queryUser', {});
        this.healthPlans = response.data.data;
        this.filteredHealthPlans = [...this.healthPlans]; // 初始化筛选后数据
      } catch (error) {
        console.error('获取计划列表失败:', error);
        this.$message.error('获取计划列表失败');
      }
    },
    async fetchLatestPlan() {
      try {
        const response = await this.$axios.get('/health-plans/latest');
        this.latestHealthPlan = response.data.data;
        if (this.latestHealthPlan) {
          this.latestHealthPlan.formattedDate = this.formatDate(this.latestHealthPlan.planDate);
        }
      } catch (error) {
        console.error('获取最近一次计划失败:', error);
        this.$message.error('获取最近一次计划失败');
      }
    },
    handleAdd() {
      this.dialogTitle = '添加记录';
      this.form = {
        planDate: new Date(),
        steps: 8000,
        exerciseMinutes: 30,
        exerciseType: '跑步',
        caloriesBurned: 300
      };
      this.dialogVisible = true;
    },
    handleEdit(row) {
      this.dialogTitle = '编辑计划';
      this.form = { ...row };
      this.dialogVisible = true;
    },
    async handleDelete(row) {
      try {
        await this.$confirm('确认删除该计划?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        });
        await this.$axios.post('/health-plans/batchDelete', [row.id]);
        this.$message.success('删除成功');
        this.fetchPlans();
        this.fetchLatestPlan();
      } catch (error) {
        if (error !== 'cancel') {
          console.error('删除计划失败:', error);
          this.$message.error('删除失败');
        }
      }
    },
    async submitForm() {
      try {
        let response;
        if (this.form.id) {
          response = await this.$axios.put(`/health-plans/update`, this.form);
        } else {
          response = await this.$axios.post('/health-plans/save', this.form);
        }
        this.$message.success(this.form.id ? '更新成功' : '添加成功');
        this.dialogVisible = false;
        this.fetchPlans();
      } catch (error) {
        console.error('保存失败:', error);
        this.$message.error('保存失败');
      }
    },
    
    // 统计相关方法（保留）
    async updateStats() {
      try {
        // 准备日期范围参数
        let startDate, endDate;
        
        if (this.statType === 'week') {
          // 获取选择周的起始和结束日期
          const date = new Date(this.selectedWeek);
          const day = date.getDay() || 7; // 如果是周日，getDay() 返回 0，我们需要将其视为 7
          const diff = date.getDate() - day + 1; // 调整到周一
          
          startDate = new Date(date.setDate(diff));
          endDate = new Date(startDate);
          endDate.setDate(startDate.getDate() + 6); // 周日
        } else {
          // 获取选择月的起始和结束日期
          const date = new Date(this.selectedMonth);
          startDate = new Date(date.getFullYear(), date.getMonth(), 1);
          endDate = new Date(date.getFullYear(), date.getMonth() + 1, 0); // 本月最后一天
        }
        
        // 使用模拟数据
        this.useSimulatedData();
        
        // 更新图表
        this.updateCharts();
      } catch (error) {
        console.error('统计数据处理失败:', error);
        // 使用模拟数据
        this.useSimulatedData();
      }
    },
    
    // 使用模拟数据填充统计
    useSimulatedData() {
      this.totalSteps = 65000;
      this.totalDuration = 320;
      this.totalCaloriesBurned = 1850;
      this.averageStepsPerDay = 9285;
      
      if (this.statType === 'week') {
        this.statsData = [
          { date: '周一', steps: 8500, duration: 45, caloriesBurned: 220 },
          { date: '周二', steps: 12000, duration: 60, caloriesBurned: 450 },
          { date: '周三', steps: 9800, duration: 50, caloriesBurned: 300 },
          { date: '周四', steps: 10500, duration: 55, caloriesBurned: 320 },
          { date: '周五', steps: 11200, duration: 40, caloriesBurned: 260 },
          { date: '周六', steps: 7500, duration: 30, caloriesBurned: 150 },
          { date: '周日', steps: 5500, duration: 40, caloriesBurned: 150 }
        ];
      } else {
        // 生成本月数据
        const daysInMonth = new Date(this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1, 0).getDate();
        this.statsData = [];
        
        for (let i = 1; i <= daysInMonth; i++) {
          this.statsData.push({
            date: i + '日',
            steps: Math.floor(Math.random() * 5000) + 5000,
            duration: Math.floor(Math.random() * 30) + 20,
            caloriesBurned: Math.floor(Math.random() * 200) + 100
          });
        }
      }
    },
    
    // 图表相关方法（保留）
    initCharts() {
      // 初始化步数图表
      this.stepsChart = echarts.init(this.$refs.stepsChart);
      
      // 初始化热量图表
      this.caloriesChart = echarts.init(this.$refs.caloriesChart);
      
      // 监听窗口大小变化，重新计算图表大小
      window.addEventListener('resize', () => {
        if (this.stepsChart) this.stepsChart.resize();
        if (this.caloriesChart) this.caloriesChart.resize();
      });
      
      // 更新图表数据
      this.updateCharts();
    },
    
    // 更新图表数据
    updateCharts() {
      if (!this.stepsChart || !this.caloriesChart || !this.statsData.length) return;
      
      // 准备数据
      const dates = this.statsData.map(item => item.date);
      const steps = this.statsData.map(item => item.steps);
      const durations = this.statsData.map(item => item.duration);
      const calories = this.statsData.map(item => item.caloriesBurned);
      
      // 步数和时长图表
      this.stepsChart.setOption({
        title: {
          text: '步数和运动时长',
          left: 'center'
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross',
            crossStyle: {
              color: '#999'
            }
          }
        },
        legend: {
          data: ['步数', '时长'],
          bottom: 0
        },
        xAxis: {
          type: 'category',
          data: dates,
          axisPointer: {
            type: 'shadow'
          }
        },
        yAxis: [
          {
            type: 'value',
            name: '步数',
            min: 0,
            interval: 2000,
            axisLabel: {
              formatter: '{value}'
            }
          },
          {
            type: 'value',
            name: '时长(分钟)',
            min: 0,
            interval: 20,
            axisLabel: {
              formatter: '{value}'
            }
          }
        ],
        series: [
          {
            name: '步数',
            type: 'bar',
            data: steps,
            itemStyle: {
              color: '#5470c6'
            }
          },
          {
            name: '时长',
            type: 'line',
            yAxisIndex: 1,
            data: durations,
            itemStyle: {
              color: '#91cc75'
            }
          }
        ]
      });
      
      // 热量消耗图表
      this.caloriesChart.setOption({
        title: {
          text: '消耗热量统计',
          left: 'center'
        },
        tooltip: {
          trigger: 'axis'
        },
        xAxis: {
          type: 'category',
          data: dates
        },
        yAxis: {
          type: 'value',
          name: '热量(kcal)',
          min: 0
        },
        series: [
          {
            type: 'bar',
            name: '消耗热量',
            data: calories,
            itemStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: '#f6ad55' },
                { offset: 1, color: '#ed8936' }
              ])
            },
            emphasis: {
              itemStyle: {
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                  { offset: 0, color: '#f6ad55' },
                  { offset: 1, color: '#dd6b20' }
                ])
              }
            }
          }
        ]
      });
    },
    
    // 筛选相关方法
    handleFilter() {
      // 实现筛选逻辑
      this.filteredHealthPlans = this.healthPlans.filter(plan => {
        let dateMatch = true;
        if (this.dateRange && this.dateRange.length === 2) {
          const planDate = new Date(plan.planDate);
          const startDate = new Date(this.dateRange[0]);
          const endDate = new Date(this.dateRange[1]);
          dateMatch = planDate >= startDate && planDate <= endDate;
        }
        
        const typeMatch = !this.exerciseTypeFilter || plan.exerciseType === this.exerciseTypeFilter;
        
        return dateMatch && typeMatch;
      });
    },
    
    resetFilter() {
      this.dateRange = [];
      this.exerciseTypeFilter = '';
      this.filteredHealthPlans = [...this.healthPlans]; // 重置为所有数据
    }
  }
};
</script>

<style scoped lang="scss">
.daily-health {
  padding: 20px;
}

/* 添加页面头部样式 */
.page-header {
  background: linear-gradient(135deg, #42b983, #2c9e6a);
  color: white;
  border-radius: 12px;
  padding: 25px 30px;
  margin-bottom: 30px;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  margin: 0 0 10px;
  color: white;
}

.page-subtitle {
  font-size: 14px;
  margin: 0;
  opacity: 0.9;
}

.box-card {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  border-radius: 12px;
  margin-bottom: 20px;
  border: none;
  
  &.stats-card {
    margin-top: 0; /* 修改顶部边距，移除多余空间 */
  }
}

// 添加健康表格样式
.health-table {
  ::v-deep {
    .el-table__header-wrapper {
      th {
        background-color: #f5f7fa;
        color: #606266;
        font-weight: 600;
        height: 40px;
        line-height: 24px;
        padding: 12px 0;
        text-align: center !important;
      }
      
      .el-table__header {
        display: table;
        width: 100% !important;
        table-layout: fixed;
      }
      
      thead {
        tr {
          display: table-row;
          width: 100%;
          text-align: center !important;
        }
        
        th .cell {
          text-align: center !important;
          width: 100% !important;
          padding: 0 !important;
        }
      }
    }
    
    .el-table__body-wrapper {
      td {
        font-size: 14px;
        padding: 12px 0;
        height: 60px;
        line-height: 24px;
      }
    }

    .el-table__row {
      height: 60px;
    }
    
    // 修复边框样式
    .el-table__header {
      border-bottom: 1px solid #EBEEF5;
    }

    .el-table--border::after, 
    .el-table--group::after, 
    .el-table::before {
      background-color: transparent;
    }
    
    // 调整条纹样式
    .el-table--striped .el-table__body tr.el-table__row--striped td {
      background-color: #f5f7fa;
    }

    .el-table__body tr:hover > td {
      background-color: #ecf5ff;
    }
  }
}

.stats-container {
  padding: 20px 0;
}

.stats-summary {
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;
  margin-bottom: 30px;
}

.stat-item {
  text-align: center;
  padding: 15px;
  border-radius: 10px;
  background-color: #f9f9f9;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  min-width: 150px;
  margin-bottom: 15px;
}

.stat-value {
  font-size: 24px;
  font-weight: bold;
  color: #409EFF;
  margin-bottom: 8px;
}

.stat-label {
  color: #606266;
  font-size: 14px;
}

.charts-container {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
  margin-top: 20px;
  
  @media (max-width: 992px) {
    grid-template-columns: 1fr;
  }
}

.chart {
  height: 350px;
  border-radius: 8px;
  background-color: #fff;
  padding: 10px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.stat-controls {
  float: right;
  display: flex;
  align-items: center;
  gap: 10px;
}

.dialog-hover {
  display: inline-block;
  width: 100px;
  text-align: right;
  margin-right: 10px;
}

.custom-dialog {
  ::v-deep .el-dialog__body {
    padding-top: 0;
  }
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 15px;
  padding: 10px 20px;
}

.channel-button, .edit-button {
  padding: 8px 20px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s;
}

.channel-button {
  border: 1px solid #dcdfe6;
  background-color: #fff;
  color: #606266;
  
  &:hover {
    color: #409EFF;
    border-color: #c6e2ff;
    background-color: #ecf5ff;
  }
}

.edit-button {
  border: 1px solid #409EFF;
  background-color: #409EFF;
  color: white;
  
  &:hover {
    background-color: #66b1ff;
    border-color: #66b1ff;
  }
}

.filter-container {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 10px;
}

.filter-item {
  display: flex;
  align-items: center;
  gap: 5px;
}

.filter-label {
  font-size: 14px;
  font-weight: 600;
}

.filter-buttons {
  display: flex;
  align-items: center;
  gap: 10px;
}

.card-header {
  position: relative;
  display: flex;
  align-items: center;
  padding: 10px 20px;
}

.header-title {
  font-size: 18px;
  font-weight: bold;
  margin-right: 20px;
  white-space: nowrap;
}

.header-filters {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  flex: 1;
  gap: 10px;

  .filter-item {
    .el-date-editor.el-input__inner {
      width: 240px;
    }
    .el-input {
      width: 120px;
    }
  }

  @media screen and (max-width: 1200px) {
    .filter-item {
      .el-date-editor.el-input__inner {
        width: 220px;
      }
    }
  }

  @media screen and (max-width: 992px) {
    .filter-item {
      .el-date-editor.el-input__inner {
        width: 200px;
      }
    }
  }
}

.filter-actions {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-left: 5px;
}

.add-record-btn {
  margin-left: auto;
  margin-right: 55px;
}
</style>