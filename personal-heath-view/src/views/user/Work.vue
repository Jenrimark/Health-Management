<template>
    <div class="health-report">
      <div class="report-container">
        <!-- 报告标题和时间范围 -->
        <div class="report-header">
          <h1 class="report-title">{{ reportTitle }}健康报告</h1>
          <div class="time-range">
            <i class="el-icon-date"></i>
            <span>{{ formatDate(reportData.timeRange.startTime) }} 至 {{ formatDate(reportData.timeRange.endTime) }}</span>
          </div>
        </div>
  
        <!-- 健康状态 - 左侧显示 -->
        <div class="health-status">
          <div class="status-text" :class="getStatusClass()">
            {{ getStatusText() }}
          </div>
        </div>
  
        <!-- 健康指标概览 -->
        <div class="section">
          <h3 class="section-title">健康指标概览</h3>
          <div class="metrics-grid" v-if="reportData.healthMetrics.length > 0">
            <div class="metric-item" v-for="(metric, index) in reportData.healthMetrics" :key="index">
              <div class="metric-name">{{ metric.modelName }}</div>
              <div class="metric-value" :style="{color: getMetricColor(metric)}">
                {{ metric.average.toFixed(1) }}<span class="unit">{{ metric.unit }}</span>
              </div>
              <div class="metric-range">
                参考范围: {{ metric.valueRange.split(',')[0] }}-{{ metric.valueRange.split(',')[1] }}{{ metric.unit }}
              </div>
            </div>
          </div>
          <div class="empty-state" v-else>
            <i class="el-icon-data-line"></i>
            <span>暂无数据</span>
          </div>
        </div>
  
        <!-- 健康警告 -->
        <div class="section" v-if="reportData.warnings && reportData.warnings.length > 0">
          <h3 class="section-title">健康警告</h3>
          <div class="warnings-list">
            <div class="warning-item" v-for="(warning, index) in reportData.warnings" :key="index">
              <i class="el-icon-warning"></i>
              <span>{{ warning }}</span>
            </div>
          </div>
        </div>
  
        <!-- 健康建议 -->
        <div class="section">
          <h3 class="section-title">健康建议</h3>
          <div class="advice-content" v-if="reportData.aiAdvice">
            <div class="advice-text" v-html="formatAdvice(cleanAdviceText(reportData.aiAdvice))"></div>
          </div>
          <div class="empty-state" v-else>
            <i class="el-icon-chat-dot-round"></i>
            <span>暂时无法获取健康建议</span>
          </div>
        </div>
  
        <!-- 操作按钮 -->
        <div class="action-buttons">
          <el-button 
            type="primary" 
            :loading="loading"
            @click="generateReport('week')"
            size="medium"
            class="action-button">
            生成周报
          </el-button>
          <el-button 
            type="success" 
            :loading="loading"
            @click="generateReport('month')"
            size="medium"
            class="action-button">
            生成月报
          </el-button>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: 'HealthReport',
    data() {
      return {
        loading: false,
        reportData: {
          healthMetrics: [],
          timeRange: {},
          warnings: [],
          aiAdvice: null
        },
        reportType: 'week'
      }
    },
    computed: {
      reportTitle() {
        return this.reportType === 'week' ? '周' : '月'
      }
    },
    methods: {
      async generateReport(type) {
        this.reportType = type
        this.loading = true
        try {
          const response = await this.$axios.get(`/user-health/report/${type}`)
          this.reportData = response.data.data
        } catch (error) {
          console.error('生成报告失败:', error)
          this.$message.error('生成报告失败，请稍后再试')
        } finally {
          this.loading = false
        }
      },
      formatDate(dateStr) {
        if (!dateStr || dateStr === 'Invalid Date') return '暂无数据'
        try {
          return new Date(dateStr).toLocaleDateString()
        } catch (e) {
          return '日期格式错误'
        }
      },
      formatAdvice(content) {
        if (!content) return ''
        return content.replace(/\n/g, '<br>')
      },
      cleanAdviceText(advice) {
        if (typeof advice === 'string') {
          return advice.replace(/[#*-]/g, '')
        } else if (advice.choices) {
          return advice.choices[0].message.content.replace(/[#*-]/g, '')
        }
        return ''
      },
      getMetricColor(metric) {
        const [min, max] = metric.valueRange.split(',').map(Number)
        const avg = metric.average
        if (avg < min || avg > max) return '#FF6B6B' // 异常值 - 红色
        return '#51CF66' // 正常值 - 绿色
      },
      getStatusClass() {
        if (!this.reportData.warnings || this.reportData.warnings.length === 0) {
          return 'status-good'
        } else if (this.reportData.warnings.length <= 2) {
          return 'status-warning'
        } else {
          return 'status-bad'
        }
      },
      getStatusText() {
        if (!this.reportData.warnings || this.reportData.warnings.length === 0) {
          return '健康状况良好'
        } else if (this.reportData.warnings.length <= 2) {
          return '健康状况需要注意'
        } else {
          return '健康状况不佳'
        }
      }
    },
    mounted() {
      this.generateReport('week')
    }
  }
  </script>
  
  <style >
  .health-report {
    display: flex;
    justify-content: center;
    min-height: 100vh;
    padding: 40px 20px;
    background: #f8fafc;
    font-family: 'Helvetica Neue', Arial, sans-serif;
  }
  
  .report-container {
    width: 100%;
    max-width: 900px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.03);
    padding: 40px;
  }
  
  .report-header {
    margin-bottom: 30px;
    
    .report-title {
      color: #2c3e50;
      font-size: 28px;
      font-weight: 600;
      margin-bottom: 10px;
    }
    
    .time-range {
      color: #7f8c8d;
      font-size: 16px;
      display: flex;
      align-items: center;
      
      i {
        margin-right: 8px;
      }
    }
  }
  
  .health-status {
    margin: 30px 0;
    
    .status-text {
      font-size: 22px;
      font-weight: 600;
      padding: 8px 0;
      
      &.status-good {
        color: #27ae60; 
      }
      
      &.status-warning {
        color: #f39c12; 
      }
      
      &.status-bad {
        color: #e74c3c; 
      }
    }
  }
  
  .section {
    margin-bottom: 40px;
    
    .section-title {
      color: #2c3e50;
      font-size: 20px;
      font-weight: 600;
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 1px solid #ecf0f1;
    }
  }
  
  .metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
  }
  
  .metric-item {
    background: white;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    border: 1px solid #f1f3f5;
    
    .metric-name {
      color: #7f8c8d;
      font-size: 15px;
      margin-bottom: 10px;
    }
    
    .metric-value {
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 8px;
      
      .unit {
        font-size: 14px;
        color: #95a5a6;
        margin-left: 5px;
        font-weight: 400;
      }
    }
    
    .metric-range {
      font-size: 13px;
      color: #95a5a6;
    }
  }
  
  .warnings-list {
    .warning-item {
      background: #fff8e6;
      border-left: 4px solid #f39c12;
      padding: 12px 15px;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      
      i {
        color: #f39c12;
        margin-right: 10px;
        font-size: 18px;
      }
      
      span {
        color: #e67e22;
        font-size: 15px;
      }
    }
  }
  
  .advice-content {
    .advice-text {
      color: #495057;
      font-size: 15px;
      line-height: 1.8;
      
      br {
        content: "";
        display: block;
        margin: 10px 0;
      }
    }
  }
  
  .empty-state {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    color: #95a5a6;
    padding: 20px 0;
    
    i {
      font-size: 24px;
      margin-bottom: 10px;
      color: #bdc3c7;
    }
    
    span {
      font-size: 15px;
    }
  }
  
  .action-buttons {
    display: flex;
    gap: 15px;
    margin-top: 40px;
    
    .action-button {
      padding: 12px 25px;
      border-radius: 6px;
      font-weight: 500;
      transition: all 0.2s ease;
      
      &:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      }
    }
  }
  
  @media (max-width: 768px) {
    .report-container {
      padding: 30px;
    }
    
    .metrics-grid {
      grid-template-columns: 1fr;
    }
    
    .action-buttons {
      flex-direction: column;
      
      .action-button {
        width: 100%;
      }
    }
  }
  </style>