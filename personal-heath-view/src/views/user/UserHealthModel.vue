<template>
    <div class="health-dashboard">
        <!-- Header Banner -->
        <div class="dashboard-header">
            <div class="dashboard-title">
                <h1>健康中心</h1>
                <p>健康生活，健康人生，从此刻开始！每一点改变，都值得被记录。</p>
                <div class="action-button" @click="toRecord">
                    <span>前去记录</span>
                    <i class="el-icon-right"></i>
                </div>
            </div>
        </div>

        <!-- Main Dashboard Container -->
        <div class="dashboard-container">
            <!-- Left Column - Health Trend Chart -->
            <div class="dashboard-column">
                <div class="dashboard-card primary-card">
                    <div class="card-header">
                        <h2>健康趋势</h2>
                        <el-select size="small" @change="modelChange" v-model="userHealthQueryDto.healthModelConfigId"
                            placeholder="选择指标项">
                            <el-option v-for="model in usersHealthModelConfig" :key="model.id" :label="model.name"
                                :value="model.id">
                            </el-option>
                        </el-select>
                    </div>
                    <div class="chart-container">
                        <LineChart @on-selected="onSelectedTime" height="350px" tag="" :values="values" :date="dates" />
                    </div>
                </div>
            </div>

            <!-- Right Column - Health Score and Metrics Combined -->
            <div class="dashboard-column">
                <div class="dashboard-card combined-card">
                    <div class="card-header">
                        <h2>健康评估</h2>
                        <el-button type="primary" size="small" class="calculate-btn" @click="showCalculationDetails">计算详情</el-button>
                    </div>
                    <div class="combined-content">
                        <div class="score-section">
                            <div class="score-container">
                                <div class="score-ball" :class="scoreClass">
                                    <span class="score-text">{{ healthScore }}</span>
                                    <div class="score-highlight"></div>
                                </div>
                                <div class="score-description">{{ scoreDescription }}</div>
                            </div>
                        </div>
                        <div class="health-metrics">
                            <div class="metric-item">
                                <div class="metric-icon">
                                    <i class="el-icon-data-analysis"></i>
                                </div>
                                <div class="metric-content">
                                    <div class="metric-title">BMI指数</div>
                                    <div class="metric-value">{{ bmiValue || '-- --' }}</div>
                                    <div class="metric-desc">{{ bmiDescription }}</div>
                                </div>
                            </div>
                            <div class="metric-item">
                                <div class="metric-icon">
                                    <i class="el-icon-pie-chart"></i>
                                </div>
                                <div class="metric-content">
                                    <div class="metric-title">体脂率</div>
                                    <div class="metric-value">{{ bodyFatRate || '-- --' }}%</div>
                                    <div class="metric-desc">{{ bodyFatDescription }}</div>
                                </div>
                            </div>
                            <div class="metric-item">
                                <div class="metric-icon">
                                    <i class="el-icon-s-data"></i>
                                </div>
                                <div class="metric-content">
                                    <div class="metric-title">基础代谢率</div>
                                    <div class="metric-value">{{ bmrValue || '-- --' }} kcal</div>
                                    <div class="metric-desc">每日消耗的最低热量</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Second Row Layout -->
        <div class="dashboard-container">
            <!-- Left Column - Exercise and Diet Summary (1/3 width) -->
            <div class="dashboard-column summary-column">
                <!-- 健康指标摘要卡片 -->
                <div class="dashboard-card summary-highlight-card">
                    <div class="card-header">
                        <h2>健康指标摘要</h2>
                        <el-button type="text" class="custom-text-button" @click="toRecord">记录指标 <i class="el-icon-plus"></i></el-button>
                    </div>
                    <div class="summary-highlights-content">
                        <div class="summary-highlight-item">
                            <div class="highlight-icon weight-icon">
                                <i class="el-icon-shopping-cart-full"></i>
                            </div>
                            <div class="highlight-info">
                                <div class="highlight-title">最新体重</div>
                                <div class="highlight-value">{{ latestWeightValue || '-- --' }} kg</div>
                            </div>
                            <div class="highlight-change" :class="weightTrend === 'up' ? 'trend-up' : weightTrend === 'down' ? 'trend-down' : ''">
                                <i v-if="weightTrend === 'up'" class="el-icon-top"></i>
                                <i v-if="weightTrend === 'down'" class="el-icon-bottom"></i>
                                {{ weightChange || '无变化' }}
                            </div>
                        </div>
                        <div class="summary-highlight-item">
                            <div class="highlight-icon heart-icon">
                                <i class="el-icon-watch"></i>
                            </div>
                            <div class="highlight-info">
                                <div class="highlight-title">心率状况</div>
                                <div class="highlight-value">{{ latestHeartRate || '-- --' }} 次/分</div>
                            </div>
                            <div class="highlight-desc">{{ heartRateStatus }}</div>
                        </div>
                        <div class="summary-highlight-item">
                            <div class="highlight-icon sleep-icon">
                                <i class="el-icon-moon-night"></i>
                            </div>
                            <div class="highlight-info">
                                <div class="highlight-title">睡眠质量</div>
                                <div class="highlight-value">{{ sleepHours || '-- --' }} 小时</div>
                            </div>
                            <div class="highlight-desc">{{ sleepQuality }}</div>
                        </div>
                        <div class="summary-highlight-item">
                            <div class="highlight-icon pressure-icon">
                                <i class="el-icon-odometer"></i>
                            </div>
                            <div class="highlight-info">
                                <div class="highlight-title">血压</div>
                                <div class="highlight-value">{{ bloodPressure || '-- --' }}</div>
                            </div>
                            <div class="highlight-desc">{{ bloodPressureStatus }}</div>
                        </div>
                    </div>
                </div>

                <!-- Exercise Summary -->
                <div class="dashboard-card summary-card">
                    <div class="card-header">
                        <h2>运动摘要</h2>
                        <el-button type="text" @click="$router.push('/daily-health')">查看详情 <i class="el-icon-right"></i></el-button>
                    </div>
                    <div class="summary-content">
                        <!-- 图表先显示 -->
                        <div class="summary-chart">
                            <div ref="exerciseChart" class="chart-container-responsive"></div>
                        </div>
                        <!-- 数据竖向排列 -->
                        <div class="summary-stats vertical">
                            <div class="summary-stat-item">
                                <div class="stat-icon exercise-icon">
                                    <i class="el-icon-position"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value">{{ latestExerciseStats.steps || '0' }}</div>
                                    <div class="stat-label">今日步数</div>
                                </div>
                            </div>
                            <div class="summary-stat-item">
                                <div class="stat-icon time-icon">
                                    <i class="el-icon-time"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value">{{ latestExerciseStats.minutes || '0' }}</div>
                                    <div class="stat-label">运动时长(分钟)</div>
                                </div>
                            </div>
                            <div class="summary-stat-item">
                                <div class="stat-icon calories-icon">
                                    <i class="el-icon-pie-chart"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value">{{ latestExerciseStats.calories || '0' }}</div>
                                    <div class="stat-label">消耗热量(kcal)</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Diet Summary -->
                <div class="dashboard-card summary-card">
                    <div class="card-header">
                        <h2>饮食摘要</h2>
                        <el-button type="text" @click="$router.push('/dietHistory')">查看详情 <i class="el-icon-right"></i></el-button>
                    </div>
                    <div class="summary-content">
                        <!-- 图表先显示 -->
                        <div class="summary-chart">
                            <div ref="dietChart" class="chart-container-responsive"></div>
                        </div>
                        <!-- 数据竖向排列 -->
                        <div class="summary-stats vertical">
                            <div class="summary-stat-item">
                                <div class="stat-icon calorie-icon">
                                    <i class="el-icon-food"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value">{{ latestDietStats.calories || '0' }}</div>
                                    <div class="stat-label">今日摄入(kcal)</div>
                                </div>
                            </div>
                            <div class="summary-stat-item">
                                <div class="stat-icon protein-icon">
                                    <i class="el-icon-sugar"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value">{{ latestDietStats.protein || '0' }}g</div>
                                    <div class="stat-label">蛋白质</div>
                                </div>
                            </div>
                            <div class="summary-stat-item">
                                <div class="stat-icon water-icon">
                                    <i class="el-icon-potato-strips"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value">{{ latestDietStats.water || '0' }}ml</div>
                                    <div class="stat-label">饮水量</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column - Health Records Table (2/3 width) -->
            <div class="dashboard-column data-column">
                <div class="dashboard-card table-card">
                    <div class="card-header">
                        <h2>健康指标数据</h2>
                        <div class="filter-group">
                            <el-select size="small" @change="fetchFreshData" v-model="healthModelConfigId" placeholder="选择模型项">
                                <el-option :key="null" label="全部" :value="null">
                                </el-option>
                                <el-option v-for="model in usersHealthModelConfig" :key="model.id" :label="model.name"
                                    :value="model.id">
                                </el-option>
                            </el-select>
                            <el-date-picker size="small" @change="timeChange" style="margin-left: 10px;" v-model="searchTime"
                                type="daterange" range-separator="至" start-placeholder="记录开始" end-placeholder="记录结束">
                            </el-date-picker>
                        </div>
                    </div>
                    <div class="table-container">
                        <el-table row-key="id" 
                                  @selection-change="handleSelectionChange" 
                                  :data="filteredTableData"
                                  class="custom-table" 
                                  size="small" 
                                  :cell-style="{padding: '5px 0'}"
                                  :header-cell-style="{background: '#f9f9f9', color: '#333', fontWeight: 600, padding: '8px 0'}">
                            <el-table-column prop="name" width="120" label="指标项">
                                <template slot-scope="scope">
                                    <span class="indicator-name"><i class="el-icon-paperclip"></i>{{ scope.row.name }}</span>
                                </template>
                            </el-table-column>
                            <el-table-column prop="value" min-width="148" label="数值" sortable>
                                <template slot-scope="scope">
                                    <span class="indicator-value">{{ scope.row.value }}&nbsp;{{ scope.row.unit }}</span>
                                </template>
                            </el-table-column>
                            <el-table-column prop="symbol" width="88" label="模型符号"></el-table-column>
                            <el-table-column prop="name" width="108" label="状态">
                                <template slot-scope="scope">
                                    <div class="status-indicator" :class="statusCheck(scope.row) ? 'status-normal' : 'status-abnormal'">
                                        <i :class="statusCheck(scope.row) ? 'el-icon-success' : 'el-icon-warning'"></i>
                                        <span>{{ statusCheck(scope.row) ? '正常' : '异常' }}</span>
                                    </div>
                                </template>
                            </el-table-column>
                            <el-table-column prop="createTime" width="178" label="记录时间" sortable></el-table-column>
                            <el-table-column label="操作" width="70" fixed="right">
                                <template slot-scope="scope">
                                    <el-button type="text" @click="handleDelete(scope.row)">删除</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                        <el-pagination class="custom-pagination" @size-change="handleSizeChange"
                            @current-change="handleCurrentChange" :current-page="currentPage" :page-sizes="[10, 20]"
                            :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                            :total="totalItems"></el-pagination>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import LineChart from '@/components/LineChart.vue';
import * as echarts from 'echarts';

export default {
    components: { LineChart },
    data() {
        return {
            usersHealthModelConfig: [],
            modelConfigList: [],
            userHealthQueryDto: {}, // 查询的参数
            values: [],//折线图
            dates: [],//折线图
            tableData: [],
            selectedRows: [],
            currentPage: 1,
            pageSize: 20,
            totalItems: 0,
            searchTime: [],
            healthModelConfigId: null,
            healthScore: 85, // 身体健康评分
            bmiValue: null,
            bmiDescription: '',
            bodyFatRate: null,
            bodyFatDescription: '',
            bmrValue: null,
            // 新增数据字段
            latestExerciseStats: {
                steps: 0,
                minutes: 0,
                calories: 0,
            },
            latestDietStats: {
                calories: 0,
                protein: 0,
                water: 0,
            },
            exerciseChart: null,
            dietChart: null,
            latestWeightValue: null,
            weightTrend: null,
            weightChange: null,
            latestHeartRate: null,
            heartRateStatus: '',
            sleepHours: null,
            sleepQuality: '',
            bloodPressure: null,
            bloodPressureStatus: '',
        }
    },
    computed: {
        scoreClass() {
            // 根据分数返回不同的样式类
            if (this.healthScore >= 90) {
                return 'score-excellent';
            } else if (this.healthScore >= 75) {
                return 'score-good';
            } else if (this.healthScore >= 60) {
                return 'score-average';
            } else {
                return 'score-poor';
            }
        },
        scoreDescription() {
            // 根据分数返回不同的描述文字
            if (this.healthScore >= 90) {
                return '优秀 - 您的健康状况非常好！';
            } else if (this.healthScore >= 75) {
                return '良好 - 您的健康状况良好。';
            } else if (this.healthScore >= 60) {
                return '一般 - 您的健康状况需要改善。';
            } else {
                return '较差 - 请注意您的健康状况。';
            }
        },
        // 过滤健康指标数据，不显示自动计算的三个指标
        filteredTableData() {
            // 需要隐藏的指标名称
            const hiddenMetrics = ['BMI', 'BMI指数', '身体质量指数', '体脂率', '体脂百分比', '基础代谢率', 'BMR'];
            
            // 过滤数据
            return this.tableData.filter(item => {
                // 如果数据项的名称在需要隐藏的列表中，则不显示
                return !hiddenMetrics.some(metric => 
                    item.name && item.name.toLowerCase().includes(metric.toLowerCase())
                );
            });
        }
    },
    created() {
        this.loadHealthModelConfig();//从后端API中获取
        this.fetchFreshData(); //从后端获取最新的健康记录数据并更新页面显示
        this.calculateHealthScore(); // 计算健康评分
        this.calculateHealthMetrics(false); // 计算健康指标但不显示弹窗
        this.fetchExerciseData(); // 获取运动数据
        this.fetchDietData(); // 获取饮食数据
        this.loadHealthSummary(); // 加载健康摘要数据
    },
    mounted() {
        this.$nextTick(() => {
            this.initExerciseChart();
            this.initDietChart();
        });
    },
    beforeDestroy() {
        // 移除窗口resize事件监听器
        window.removeEventListener('resize', this.resizeExerciseChart);
        window.removeEventListener('resize', this.resizeDietChart);
        
        // 销毁图表实例
        if(this.exerciseChart) {
            this.exerciseChart.dispose();
            this.exerciseChart = null;
        }
        if(this.dietChart) {
            this.dietChart.dispose();
            this.dietChart = null;
        }
    },
    methods: {
        timeChange() {
            this.currentPage = 1;
            this.fetchFreshData();
        },
        handleDelete(row) {
            this.selectedRows.push(row);
            this.batchDelete();
        },
        // 处理用户输入的值，是正常的还是异常的，给个状态
        statusCheck(data) {
            // 用户输入的值
            const inputValue = data.value;
            // 正常值范围
            const valueRange = data.valueRange;
            if (valueRange !== null && inputValue !== null) {
                const aryValueRange = valueRange.split(',');
                const minValue = aryValueRange[0];
                const maxValue = aryValueRange[1];
                return (Number(inputValue) >= Number(minValue) && Number(inputValue) <= Number(maxValue))
            }
        },
        // 批量删除数据
        async batchDelete() {
            if (!this.selectedRows.length) {
                this.$message(`未选中任何数据`);
                return;
            }
            const confirmed = await this.$swalConfirm({
                title: '删除健康记录数据',
                text: `删除后不可恢复，是否继续？`,
                icon: 'warning',
            });
            if (confirmed) {
                try {
                    let ids = this.selectedRows.map(entity => entity.id);
                    const response = await this.$axios.post(`/user-health/batchDelete`, ids);
                    if (response.data.code === 200) {
                        this.$swal.fire({
                            title: '删除提示',
                            text: response.data.msg,
                            icon: 'success',
                            showConfirmButton: false,
                            timer: 2000,
                        });
                        this.fetchFreshData();
                        return;
                    }
                } catch (e) {
                    this.$swal.fire({
                        title: '错误提示',
                        text: e,
                        icon: 'error',
                        showConfirmButton: false,
                        timer: 2000,
                    });
                    console.error(`用户健康记录信息删除异常：`, e);
                }
            }
        },
        // 点击查询之后，执行的一个函数
        handleFilter() {
            this.currentPage = 1;
            this.fetchFreshData();
        },
        // 加载用户自己的健康记录数据
        async fetchFreshData() {
            try {
                let startTime = null;
                let endTime = null;
                if (this.searchTime != null && this.searchTime.length === 2) {
                    const [startDate, endDate] = await Promise.all(this.searchTime.map(date => date.toISOString()));
                    startTime = `${startDate.split('T')[0]}T00:00:00`;
                    endTime = `${endDate.split('T')[0]}T23:59:59`;
                }
                const userInfo = sessionStorage.getItem('userInfo');
                const userEntitySave = JSON.parse(userInfo);
                // 请求参数
                const params = {
                    current: this.currentPage,
                    size: this.pageSize,
                    startTime: startTime,
                    endTime: endTime,
                    healthModelConfigId: this.healthModelConfigId,
                    userId: userEntitySave.id
                };
                
                console.log('获取最新数据，参数:', params);
                
                // 添加时间戳参数避免缓存
                const timestamp = new Date().getTime();
                const response = await this.$axios.post(`/user-health/query?t=${timestamp}`, params);
                const { data } = response;
                this.tableData = data.data;
                this.totalItems = data.total;
                this.calculateHealthScore(); // 重新计算健康评分
                
                // 返回结果用于链式调用
                return data;
            } catch (error) {
                console.error('查询用户健康记录信息异常:', error);
                throw error; // 抛出异常以便调用者处理
            }
        },
        // 点击输入框里面的清除按钮
        handleFilterClear() {
            this.filterText = '';
            this.handleFilter();
        },
        // 多选框选中
        handleSelectionChange(selection) {
            this.selectedRows = selection;
        },
        // 条件重置
        resetQueryCondition() {
            this.searchTime = [];
            this.healthModelConfigId = null;
            this.fetchFreshData();
        },
        // 当前页切换
        handleSizeChange(val) {
            this.pageSize = val;
            this.currentPage = 1;
            this.fetchFreshData();
        },
        // 当前页跳转
        handleCurrentChange(val) {
            this.currentPage = val;
            this.fetchFreshData();
        },
        // 折线图 查询用户具体记录的值，指定时间范围内
        loadUserModelHavaRecord() {
            this.$axios.get(`/user-health/timeQuery/${this.userHealthQueryDto.healthModelConfigId}/${this.userHealthQueryDto.time}`).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    // 拿到的数据，要做可视化处理
                    this.values = data.data.map(entity => entity.value).reverse();
                    this.dates = data.data.map(entity => entity.createTime).reverse();
                    this.calculateHealthMetrics(false); // 获取最新数据并更新计算指标
                }
            })
        },
        // 模型选中方法
        modelChange(day) {
            this.userHealthQueryDto.healthModelConfigId = day;
            this.loadUserModelHavaRecord();
        },
        // 表格里面的具体模型选中
        modelUserChange() {
            // 如果想用户直接选中，数据直接回来，就要用到这一个方法
            this.fetchFreshData();
        },
        // 查询用户自己配置的模型以及全局模型
        loadHealthModelConfig() {
            this.$axios.post("/health-model-config/modelList").then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.usersHealthModelConfig = data.data;
                    this.modelConfigList = data.data;
                    this.defaultLoad(); //触发默认加载
                }
            })
        },
        // 默认加载
        defaultLoad() {
            const weightModel = this.usersHealthModelConfig.find(model => model.name === '体重');
            if (weightModel) {
                this.userHealthQueryDto.healthModelConfigId = weightModel.id;
                this.userHealthQueryDto.time = 365;
                this.loadUserModelHavaRecord();
            }
        },
        // 折线图  选择指定事件范围之后，返回的一个回调
        onSelectedTime(time) {
            this.userHealthQueryDto.time = time;
            this.loadUserModelHavaRecord();
        },
        // 组件里面返回的数据
        timeSelected() {

        },
        toRecord() {
            this.$router.push('/record');
        },
        // 计算健康评分
        calculateHealthScore() {
            // 显示加载提示
            const loading = this.$loading({
                lock: true,
                text: '正在计算健康评分...',
                spinner: 'el-icon-loading',
                background: 'rgba(0, 0, 0, 0.7)'
            });
            
            // 获取用户信息
            const userInfo = JSON.parse(sessionStorage.getItem('userInfo'));
            if (!userInfo) {
                this.$message.error('未获取到用户信息，请先登录');
                loading.close();
                return;
            }
            
            const userId = userInfo.id;
            const userAge = userInfo.age || 30; // 默认年龄为30岁
            const userGender = userInfo.gender; // 0表示女性，1表示男性
            
            // 获取所有健康指标的最新记录
            this.$axios.post(`/user-health/query`, {
                current: 1,
                size: 1000, // 设置较大的数量以确保获取全部记录
                userId: userId
            }).then(response => {
                const { data } = response;
                if (data.code === 200 && data.data && data.data.length > 0) {
                    const allHealthData = data.data;
                    
                    // 根据健康模型配置ID对记录进行分组，只保留每组中最新的一条记录
                    const modelConfigMap = {};
                    const latestRecords = [];
                    
                    // 按健康模型配置ID分组
                    allHealthData.forEach(record => {
                        const modelId = record.health_model_config_id || record.healthModelConfigId;
                        if (!modelId) return;
                        
                        if (!modelConfigMap[modelId]) {
                            modelConfigMap[modelId] = [];
                        }
                        modelConfigMap[modelId].push(record);
                    });
                    
                    // 对每个分组，按时间排序并取最新的一条
                    Object.keys(modelConfigMap).forEach(modelId => {
                        const records = modelConfigMap[modelId];
                        if (records.length === 0) return;
                        
                        // 按创建时间降序排序
                        records.sort((a, b) => {
                            const dateA = new Date(a.createTime || a.create_time);
                            const dateB = new Date(b.createTime || b.create_time);
                            return dateB - dateA; // 降序，最新的在前
                        });
                        
                        // 取每组最新的一条记录
                        latestRecords.push(records[0]);
                    });
                    
                    console.log('每个指标的最新记录:', latestRecords);
                    
                    // 为每个记录根据年龄和性别调整正常值范围
                    latestRecords.forEach(record => {
                        if (!record.valueRange) return;
                        
                        // 获取原始正常值范围
                        const originalRange = record.valueRange.split(',');
                        if (originalRange.length !== 2) return;
                        
                        let minValue = parseFloat(originalRange[0]);
                        let maxValue = parseFloat(originalRange[1]);
                        
                        // 根据指标类型、用户年龄和性别调整范围
                        // 只针对用户提供的指标列表进行调整
                        const modelName = record.name ? record.name.toLowerCase() : '';
                        const symbol = record.symbol ? record.symbol.toLowerCase() : '';
                        
                        // 1. 夜间血压 (72,145 mmHg)
                        if (modelName.includes('夜间血压') || (modelName.includes('血压') && modelName.includes('夜'))) {
                            if (userAge > 60) {
                                maxValue = maxValue * 1.05; // 上限放宽至152 mmHg (+5%)
                            } else if (userAge < 18) {
                                minValue = minValue * 0.95; // 下限降至68 mmHg (-5%)
                                maxValue = maxValue * 0.95; // 上限降至138 mmHg (-5%)
                            }
                            
                            // 女性血压标准略低
                            if (userGender === 0) { // 女性
                                minValue = minValue * 0.97;
                                maxValue = maxValue * 0.98;
                            }
                        }
                        
                        // 2. 运动心率 (75,197 次/分)
                        if (modelName.includes('运动心率') || (modelName.includes('心率') && modelName.includes('运动'))) {
                            if (userAge < 18) {
                                minValue = minValue * 0.9; // 下限降至68 (-10%)
                                maxValue = maxValue * 1.1; // 上限升至217 (+10%)
                            } else if (userAge > 60) {
                                minValue = minValue * 0.95; // 下限降至71 (-5%)
                            }
                            
                            // 女性心率一般略高
                            if (userGender === 0) { // 女性
                                minValue = minValue * 0.98; // 略微降低下限
                                maxValue = maxValue * 1.02; // 略微提高上限
                            }
                        }
                        
                        // 3. 刷牙记录 (1,2 次) - 无需根据年龄性别调整
                        
                        // 4. 每日睡眠时长 (5,10 小时)
                        if (modelName.includes('睡眠时长') || modelName.includes('睡眠')) {
                            if (userAge < 18) {
                                minValue = minValue * 1.2; // 下限提高至6小时 (+20%)
                                maxValue = maxValue * 1.1; // 上限提高至11小时 (+10%)
                            } else if (userAge > 60) {
                                minValue = minValue * 0.9; // 下限降至4.5小时 (-10%)
                                maxValue = maxValue * 0.9; // 上限降至9小时 (-10%)
                            }
                        }
                        
                        // 5. 谷丙转氨酶 (108,258 U/L)
                        if (modelName.includes('谷丙转氨酶') || symbol === 'alt') {
                            if (userAge > 60) {
                                maxValue = maxValue * 1.05; // 上限放宽至271 U/L (+5%)
                            }
                            
                            // 女性标准略低
                            if (userGender === 0) { // 女性
                                minValue = minValue * 0.95;
                                maxValue = maxValue * 0.95;
                            }
                        }
                        
                        // 6. 每日喝水量 (1000,2000 ml)
                        if (modelName.includes('喝水量') || modelName.includes('饮水量')) {
                            if (userAge < 18) {
                                minValue = 800; // 下限调整为800ml
                                maxValue = 1800; // 上限调整为1800ml
                            } else if (userAge > 60) {
                                minValue = 1100; // 下限调整为1100ml
                                maxValue = 2100; // 上限调整为2100ml
                            }
                            
                            // 男性需水量略高
                            if (userGender === 1) { // 男性
                                minValue = minValue * 1.05; 
                                maxValue = maxValue * 1.05;
                            }
                        }
                        
                        // 7. 体重 (根据身高计算BMI标准)
                        if (modelName.includes('体重') || symbol === 'weight') {
                            // 如果存在身高数据，可以计算BMI标准范围内的体重
                            const height = userInfo.height; // 厘米
                            if (height && height > 0) {
                                const heightInMeters = height / 100;
                                
                                // 根据年龄段和性别调整BMI范围
                                let minBMI = 18.5;
                                let maxBMI = 24;
                                
                                if (userAge > 60) {
                                    minBMI = 18;
                                    maxBMI = 25; // 老年人BMI范围更宽松
                                }
                                
                                if (userGender === 0) { // 女性
                                    maxBMI = maxBMI * 0.98; // 女性BMI上限略低
                                }
                                
                                // 根据调整后的BMI范围计算体重范围
                                minValue = minBMI * (heightInMeters * heightInMeters);
                                maxValue = maxBMI * (heightInMeters * heightInMeters);
                            }
                        }
                        
                        // 8. 身高 (0,500 cm) - 仅作为参考值，不需调整标准范围
                        
                        // 9. 内脏脂肪等级 (1,9 级)
                        if (modelName.includes('内脏脂肪') || symbol === 'vfl') {
                            if (userAge > 50) {
                                maxValue = maxValue * 1.05; // 上限放宽至9.5级 (+5%)
                            }
                            
                            // 女性内脏脂肪标准略低
                            if (userGender === 0) { // 女性
                                minValue = minValue * 0.9;
                                maxValue = maxValue * 0.95;
                            }
                        }
                        
                        // 10. 肌肉 (20,60 千克)
                        if (modelName.includes('肌肉') || symbol === 'mm') {
                            if (userAge > 50) {
                                minValue = minValue * 0.95; // 下限降低5%
                                maxValue = maxValue * 0.9; // 上限降低10%
                            }
                            
                            // 女性肌肉范围约为男性的70-80%
                            if (userGender === 0) { // 女性
                                minValue = minValue * 0.75;
                                maxValue = maxValue * 0.8;
                            }
                        }
                        
                        // 11. 蛋白质 (65,180 克)
                        if (modelName.includes('蛋白质') || symbol === 'pro') {
                            if (userAge > 60) {
                                minValue = 60; // 下限调整为60克
                                maxValue = 165; // 上限调整为165克
                            } else if (userAge < 18) {
                                minValue = 70; // 下限调整为70克
                                maxValue = 190; // 上限调整为190克
                            }
                            
                            // 女性蛋白质需求约为男性的85-90%
                            if (userGender === 0) { // 女性
                                minValue = minValue * 0.85;
                                maxValue = maxValue * 0.9;
                            }
                        }
                        
                        // 12. 脂肪 (7000,20000 克/百分比)
                        if (modelName.includes('脂肪') && !modelName.includes('内脏脂肪') || symbol === 'bf') {
                            if (userAge > 50) {
                                maxValue = maxValue * 1.08; // 上限放宽8%
                            }
                            
                            // 女性体脂率正常范围高于男性
                            if (userGender === 0) { // 女性
                                minValue = minValue * 1.3; // 女性体脂下限高约30%
                                maxValue = maxValue * 1.3; // 女性体脂上限高约30%
                            }
                        }
                        
                        // 13. 身体总水分 (40,60 千克)
                        if (modelName.includes('总水分') || modelName.includes('水分') || symbol === 'tbw') {
                            if (userAge > 60) {
                                minValue = 38; // 下限调整为38千克
                                maxValue = 57; // 上限调整为57千克
                            }
                            
                            // 女性水分含量约为男性的85-90%
                            if (userGender === 0) { // 女性
                                minValue = minValue * 0.85;
                                maxValue = maxValue * 0.9;
                            }
                        }
                        
                        // 14. 硫酸母 (200,300 mcg) - 无明显年龄性别差异
                        
                        // 15. 体温 (36,38 °C)
                        if (modelName.includes('体温') || (symbol && symbol.includes('摄氏度'))) {
                            // 年龄差异不明显
                            // 女性体温可能因生理周期有轻微波动，但基础范围相同
                        }
                        
                        // 16. 血脂 (2,5 毫摩尔/升)
                        if (modelName.includes('血脂') || modelName.includes('胆固醇')) {
                            if (userAge > 55) {
                                maxValue = maxValue * 1.06; // 上限放宽至5.3 (+6%)
                            }
                            
                            // 女性HDL胆固醇标准高于男性
                            if (userGender === 0 && modelName.includes('高密度')) { // 女性HDL
                                minValue = minValue * 1.15;
                                maxValue = maxValue * 1.15;
                            }
                        }
                        
                        // 17. 心率 (60,100 次/分) - 静息心率
                        if ((modelName.includes('心率') && !modelName.includes('运动')) || symbol === 'bpm') {
                            if (userAge < 18) {
                                minValue = 55; // 下限调整为55
                                maxValue = 110; // 上限调整为110
                            } else if (userAge > 60) {
                                minValue = 55; // 下限可降至55
                            }
                            
                            // 女性静息心率平均值略高于男性
                            if (userGender === 0) { // 女性
                                minValue = minValue * 1.02;
                                maxValue = maxValue * 1.05;
                            }
                        }
                        
                        // 18. 空腹血糖 (4,6 毫摩尔/升)
                        if (modelName.includes('血糖') && (modelName.includes('空腹') || !modelName.includes('餐后'))) {
                            if (userAge > 60) {
                                maxValue = maxValue * 1.03; // 上限放宽至6.2 (+3%)
                            }
                            // 性别差异不明显
                        }
                        
                        // 更新记录的调整后范围
                        record.adjustedValueRange = [minValue, maxValue];
                    });
                    
                    // 使用调整后的范围检查异常指标数量
                    const checkStatus = (record) => {
                        const inputValue = parseFloat(record.value);
                        
                        // 使用调整后的范围(如果有)，否则使用原始范围
                        if (record.adjustedValueRange) {
                            const [minValue, maxValue] = record.adjustedValueRange;
                            return inputValue >= minValue && inputValue <= maxValue;
                        } else if (record.valueRange) {
                            const aryValueRange = record.valueRange.split(',');
                            const minValue = parseFloat(aryValueRange[0]);
                            const maxValue = parseFloat(aryValueRange[1]);
                            return inputValue >= minValue && inputValue <= maxValue;
                        }
                        
                        return true; // 如果没有范围信息，默认为正常
                    };
                    
                    // 统计异常指标数量
                    const abnormalCount = latestRecords.filter(record => !checkStatus(record)).length;
                    const totalCount = latestRecords.length;
                    
                    if (totalCount > 0) {
                        // 基础健康评分计算
                        const normalRate = (totalCount - abnormalCount) / totalCount;
                        let baseScore = Math.round(normalRate * 100);
                        
                        // 添加加权调整
                        // 对重要指标赋予更高权重
                        const weightedAdjustment = this.calculateWeightedAdjustment(latestRecords, checkStatus);
                        
                        // 最终评分
                        this.healthScore = Math.min(100, Math.max(0, Math.round(baseScore + weightedAdjustment)));
                        
                        console.log(`健康评分计算: 基础分数=${baseScore}, 加权调整=${weightedAdjustment}, 最终分数=${this.healthScore}`);
                    } else {
                        // 没有健康记录，给出默认评分
                        this.healthScore = 85;
                        console.log('未找到健康记录，使用默认评分85分');
                    }
                } else {
                    // 没有健康记录，给出默认评分
                    this.healthScore = 85;
                    console.log('未找到健康记录，使用默认评分85分');
                }
                
                // 关闭加载提示
                loading.close();
            }).catch(error => {
                console.error('获取健康记录失败:', error);
                this.healthScore = 85; // 出错时使用默认评分
                loading.close();
                this.$message.error('获取健康记录失败，使用默认评分');
            });
        },

        // 计算不同指标的加权调整值
        calculateWeightedAdjustment(records, statusCheckFn) {
            // 定义不同指标类型的权重 - 只包含用户提供的健康指标
            const weights = {
                // 血压相关
                '夜间血压': 3.5,
                '血压': 3,
                
                // 心率相关
                '运动心率': 2.5,
                '心率': 2.5,
                
                // 基础生活习惯
                '刷牙记录': 1,
                '睡眠时长': 3,
                '喝水量': 2,
                
                // 身体基本指标
                '体重': 2.5,
                '身高': 1,
                
                // 肝功能
                '谷丙转氨酶': 3,
                'alt': 3,
                
                // 身体成分
                '内脏脂肪': 3,
                '肌肉': 2,
                '蛋白质': 2,
                '脂肪': 2.5,
                '身体总水分': 2,
                
                // 血液指标
                '血脂': 3,
                '血糖': 3.5,
                '空腹血糖': 3.5,
                '胆固醇': 3,
                
                // 其他生理指标
                '硫酸母': 1.5,
                '体温': 2,
            };
            
            let weightedSum = 0;
            let totalWeight = 0;
            
            records.forEach(record => {
                if (!record.name) return;
                
                // 找到匹配的权重
                let weight = 1; // 默认权重
                const recordName = record.name.toLowerCase();
                const recordSymbol = record.symbol ? record.symbol.toLowerCase() : '';
                
                // 先检查是否可以通过名称直接匹配
                for (const [key, value] of Object.entries(weights)) {
                    if (recordName.includes(key.toLowerCase())) {
                        weight = value;
                        break;
                    }
                }
                
                // 如果通过名称没找到，尝试通过symbol匹配
                if (weight === 1 && recordSymbol) {
                    for (const [key, value] of Object.entries(weights)) {
                        if (key.toLowerCase() === recordSymbol) {
                            weight = value;
                            break;
                        }
                    }
                }
                
                // 计算该指标的贡献
                const isNormal = statusCheckFn(record);
                const contribution = isNormal ? 0 : -weight; // 异常指标会减分，权重越高，扣分越多
                
                weightedSum += contribution;
                totalWeight += weight;
                
                console.log(`指标: ${record.name}, 权重: ${weight}, 是否正常: ${isNormal}, 贡献值: ${contribution}`);
            });
            
            // 如果没有记录，返回0
            if (totalWeight === 0) return 0;
            
            // 计算最终加权调整值 (最大影响±20分)
            const maxAdjustment = 20;
            const adjustment = (weightedSum / totalWeight) * maxAdjustment;
            
            console.log(`加权总和: ${weightedSum}, 总权重: ${totalWeight}, 最终调整值: ${adjustment}`);
            
            return adjustment;
        },
        
        // 安全地获取记录的值
        getRecordValue(record) {
            if (!record) return null;
            
            // 打印记录以便调试
            console.log('获取值的记录:', record);
            
            // 尝试各种可能的值属性名
            if (record.value !== undefined) return record.value;
            
            // 根据API返回的可能字段名
            if (record.val !== undefined) return record.val;
            if (record.recordValue !== undefined) return record.recordValue;
            if (record.v !== undefined) return record.v;
            if (record.data !== undefined && typeof record.data !== 'object') return record.data;
            
            // 尝试通过属性名称中包含"value"或"val"的字段获取值
            for (const key in record) {
                if (record.hasOwnProperty(key) && 
                    (key.toLowerCase().includes('value') || key.toLowerCase().includes('val')) && 
                    typeof record[key] !== 'object' &&
                    record[key] !== null) {
                    console.log('通过名称匹配找到值属性:', key, record[key]);
                    return record[key];
                }
            }
            
            // 如果找不到值属性，返回第一个非对象非数组的数值型属性
            for (const key in record) {
                if (record.hasOwnProperty(key) && 
                    typeof record[key] !== 'object' && 
                    typeof record[key] !== 'boolean' &&
                    !isNaN(parseFloat(record[key])) &&
                    key !== 'id' && 
                    key !== 'userId' && 
                    key !== 'health_model_config_id' &&
                    key !== 'healthModelConfigId' &&
                    key !== 'createTime') {
                    console.log('找到可能的数值属性:', key, record[key]);
                    return record[key];
                }
            }
            
            // 最后尝试任何非空的字符串属性
            for (const key in record) {
                if (record.hasOwnProperty(key) && 
                    typeof record[key] === 'string' &&
                    record[key].trim() !== '' &&
                    key !== 'id' && 
                    key !== 'userId' && 
                    key !== 'createTime' &&
                    key !== 'name' &&
                    key !== 'unit' &&
                    key !== 'symbol') {
                    console.log('找到可能的字符串属性:', key, record[key]);
                    return record[key];
                }
            }
            
            console.log('无法找到值属性!');
            return null;
        },
        
        // 根据不同的可能属性名查找健康记录
        findHealthRecord(data, modelId) {
            if (!data || !Array.isArray(data) || data.length === 0) return null;
            
            // 优先使用health_model_config_id
            let record = data.find(item => item.health_model_config_id === modelId);
            
            // 如果没找到，尝试其他可能的属性名
            if (!record) {
                record = data.find(item => 
                    item.healthModelConfigId === modelId ||
                    item.modelId === modelId || 
                    item.configId === modelId
                );
            }
            
            return record;
        },
        
        // 分析健康记录数据，用于排查问题
        analyzeHealthRecords(records) {
            if (!records || !Array.isArray(records) || records.length === 0) {
                console.log('没有健康记录数据可供分析');
                return;
            }
            
            console.log('========== 健康记录数据结构分析 ==========');
            console.log(`共有 ${records.length} 条记录`);
            
            // 提取所有字段名
            const allFields = new Set();
            records.forEach(record => {
                Object.keys(record).forEach(key => allFields.add(key));
            });
            
            console.log('所有可能的字段名:', Array.from(allFields));
            
            // 统计不同模型ID的分布
            const modelIdCount = {};
            records.forEach(record => {
                const id = record.health_model_config_id || record.healthModelConfigId;
                if (id) {
                    modelIdCount[id] = (modelIdCount[id] || 0) + 1;
                }
            });
            
            console.log('模型ID分布:', modelIdCount);
            
            // 分析名称和ID的对应关系
            const modelNameMap = {};
            records.forEach(record => {
                const id = record.health_model_config_id || record.healthModelConfigId;
                const name = record.name;
                if (id && name) {
                    if (!modelNameMap[id]) modelNameMap[id] = {};
                    modelNameMap[id][name] = (modelNameMap[id][name] || 0) + 1;
                }
            });
            
            console.log('模型ID与名称的对应关系:', modelNameMap);
            
            // 分析几个关键记录的完整数据
            console.log('几个典型记录的数据结构:');
            // 尝试找身高记录
            const heightRecord = records.find(r => (r.name && r.name.includes('身高')) || 
                (r.health_model_config_id === 1 || r.healthModelConfigId === 1));
            
            // 尝试找体重记录
            const weightRecord = records.find(r => (r.name && r.name.includes('体重')));
            
            if (heightRecord) {
                console.log('身高记录示例:', heightRecord);
            }
            
            if (weightRecord) {
                console.log('体重记录示例:', weightRecord);
            }
            
            console.log('========== 分析结束 ==========');
        },
        
        // 显示计算详情
        showCalculationDetails() {
            // 显示加载提示
            const loading = this.$loading({
                lock: true,
                text: '正在获取最新健康数据...',
                spinner: 'el-icon-loading',
                background: 'rgba(0, 0, 0, 0.7)'
            });
            
            // 强制刷新数据，使用setTimeout确保UI先更新
            setTimeout(() => {
                // 先重新获取表格数据
                this.fetchFreshData().then(() => {
                    // 然后重新计算健康指标并显示详情弹窗
                    this.calculateHealthMetrics(true);
                }).catch(err => {
                    console.error('获取数据失败:', err);
                    this.$message.error('获取数据失败，请重试');
                }).finally(() => {
                    loading.close();
                });
            }, 100);
        },
        
        // 计算健康指标的方法
        async calculateHealthMetrics(showDetails = false) {
            try {
                const userInfo = JSON.parse(sessionStorage.getItem('userInfo'));
                
                if (!userInfo) {
                    this.$message.error('未获取到用户信息，请先登录');
                    return;
                }
                
                try {
                    // 添加时间戳避免缓存
                    const timestamp = new Date().getTime();
                    // 直接获取所有健康记录
                    const response = await this.$axios.post(`/user-health/query?t=${timestamp}`, {
                        current: 1,
                        size: 500, // 增大获取数量确保获取全部记录
                        userId: userInfo.id
                    });
                    
                    const allHealthData = response.data.data;
                    
                    console.log('获取到的最新健康数据:', allHealthData);
                    console.log('数据记录总数:', allHealthData ? allHealthData.length : 0);
                    
                    if (!allHealthData || !Array.isArray(allHealthData) || allHealthData.length === 0) {
                        this.$message.error('未获取到健康记录数据');
                        return;
                    }
                    
                    // 分析健康数据结构
                    this.analyzeHealthRecords(allHealthData);
                    
                    // 分别找出身高和体重的最新记录
                    let heightRecords = allHealthData.filter(record => {
                        const id = record.health_model_config_id || record.healthModelConfigId;
                        return id == 1;  // 修正：身高ID为1
                    });
                    
                    // 查找体重模型ID - 优先从配置中获取
                    let weightModelId = null;
                    const weightModelName = '体重';
                    
                    // 1. 从配置中查找体重模型
                    const weightModel = this.usersHealthModelConfig.find(model => 
                        model.name === weightModelName || 
                        model.name === '用户体重' ||
                        (model.name && model.name.includes('体重'))
                    );
                    
                    if (weightModel) {
                        weightModelId = weightModel.id;
                        console.log('从配置中找到体重模型ID:', weightModelId);
                    } else {
                        console.log('从配置中未找到体重模型，尝试从已有记录推断');
                        
                        // 2. 尝试从已有记录推断体重ID
                        // 查找名称包含"体重"的记录
                        const weightNameRecords = allHealthData.filter(record => 
                            record.name && record.name.includes('体重')
                        );
                        
                        if (weightNameRecords.length > 0) {
                            // 获取最常见的ID
                            const idCounts = {};
                            weightNameRecords.forEach(record => {
                                const id = record.health_model_config_id || record.healthModelConfigId;
                                if (id) {
                                    idCounts[id] = (idCounts[id] || 0) + 1;
                                }
                            });
                            
                            // 找出出现最多的ID
                            let maxCount = 0;
                            let mostCommonId = null;
                            for (const id in idCounts) {
                                if (idCounts[id] > maxCount) {
                                    maxCount = idCounts[id];
                                    mostCommonId = id;
                                }
                            }
                            
                            if (mostCommonId) {
                                weightModelId = mostCommonId;
                                console.log('从记录中推断体重模型ID:', weightModelId);
                            }
                        }
                        
                        // 3. 如果仍未找到，使用常见的体重ID
                        if (!weightModelId) {
                            weightModelId = 20; // 默认常用ID
                            console.log('无法推断体重ID，使用默认ID:', weightModelId);
                        }
                    }
                    
                    console.log('最终确定的体重模型ID:', weightModelId);
                    
                    // 输出所有记录的模型ID分布，用于调试
                    console.log('所有健康模型记录的ID分布:');
                    const idCounts = {};
                    allHealthData.forEach(record => {
                        const id = record.health_model_config_id || record.healthModelConfigId;
                        if (id) {
                            idCounts[id] = (idCounts[id] || 0) + 1;
                        }
                    });
                    console.log(idCounts);
                    
                    let weightRecords = allHealthData.filter(record => {
                        const id = record.health_model_config_id || record.healthModelConfigId;
                        // 尝试多种可能的ID
                        return id == weightModelId || id == 20 || id == 2;  // 尝试多个可能的体重ID
                    });
                    
                    console.log('身高记录数:', heightRecords.length);
                    console.log('体重记录数:', weightRecords.length);
                    
                    // 如果通过ID没找到体重记录，尝试通过名称查找
                    if (weightRecords.length === 0) {
                        console.log('通过ID未找到体重记录，尝试通过名称查找...');
                        weightRecords = allHealthData.filter(record => {
                            // 通过名称或标签查找与体重相关的记录
                            return (record.name && record.name.includes('体重')) || 
                                  (record.symbol && record.symbol === 'weight');
                        });
                        
                        if (weightRecords.length > 0) {
                            console.log('通过名称找到体重记录:', weightRecords.length, '条');
                        } else {
                            // 最后尝试找数值合理的记录
                            console.log('尝试通过数值范围查找可能的体重记录...');
                            weightRecords = allHealthData.filter(record => {
                                // 获取记录值
                                const value = this.getRecordValue(record);
                                if (!value) return false;
                                
                                // 转为数字
                                const numValue = parseFloat(value);
                                // 体重一般在30-300kg范围内
                                return !isNaN(numValue) && numValue > 30 && numValue < 300;
                            });
                            
                            if (weightRecords.length > 0) {
                                console.log('通过数值范围找到可能的体重记录:', weightRecords.length, '条');
                            }
                        }
                        
                        console.log('通过名称找到的体重记录数:', weightRecords.length);
                    }
                    
                    if (!heightRecords.length) {
                        this.$message.error('未找到身高记录(ID=1)，无法计算');
                        return;
                    }
                    
                    if (!weightRecords.length) {
                        // 使用更友好的错误提示
                        this.$message.error(`未找到体重记录，请先添加体重数据。尝试过的ID: ${weightModelId}, 20, 2`);
                        
                        // 显示现有的模型配置，帮助诊断
                        console.log('可用的健康模型配置:', this.usersHealthModelConfig);
                        
                        // 遍历健康数据，查找可能有用的线索
                        console.log('现有健康数据的模型ID和名称:');
                        const modelSamples = [];
                        allHealthData.slice(0, 10).forEach(record => {
                            modelSamples.push({
                                id: record.health_model_config_id || record.healthModelConfigId,
                                name: record.name,
                                value: record.value
                            });
                        });
                        console.log(modelSamples);
                        
                        return;
                    }
                    
                    // 按时间降序排序，取第一条记录
                    heightRecords.sort((a, b) => {
                        const dateA = new Date(a.createTime || a.create_time);
                        const dateB = new Date(b.createTime || b.create_time);
                        return dateB - dateA; // 降序
                    });
                    
                    weightRecords.sort((a, b) => {
                        const dateA = new Date(a.createTime || a.create_time);
                        const dateB = new Date(b.createTime || b.create_time);
                        return dateB - dateA; // 降序
                    });
                    
                    // 获取最新记录的值
                    const latestHeightRecord = heightRecords[0];
                    const latestWeightRecord = weightRecords[0];
                    
                    console.log('最新身高记录:', latestHeightRecord);
                    console.log('最新体重记录:', latestWeightRecord);
                    
                    // 如果仍然找不到体重记录，尝试寻找标题含有"体重"的记录
                    if (!latestWeightRecord && allHealthData.length > 0) {
                        console.log('尝试通过名称搜索体重记录...');
                        const possibleWeightRecords = allHealthData.filter(record => {
                            return record.name && record.name.includes('体重');
                        });
                        
                        if (possibleWeightRecords.length > 0) {
                            console.log('通过名称找到可能的体重记录:', possibleWeightRecords.length, '条');
                            possibleWeightRecords.sort((a, b) => {
                                const dateA = new Date(a.createTime || a.create_time);
                                const dateB = new Date(b.createTime || b.create_time);
                                return dateB - dateA; // 降序
                            });
                            const possibleWeightRecord = possibleWeightRecords[0];
                            console.log('可能的体重记录:', possibleWeightRecord);
                            weightRecords = [possibleWeightRecord];
                        }
                    }
                    
                    // 确保能够获取到值
                    let heightValue = this.getRecordValue(latestHeightRecord);
                    let weightValue = this.getRecordValue(latestWeightRecord);
                    
                    // 检查值是否有效
                    if (!heightValue) {
                        console.error('身高记录缺少value字段:', latestHeightRecord);
                        for (const key in latestHeightRecord) {
                            console.log(`身高记录字段${key}:`, latestHeightRecord[key]);
                        }
                        this.$message.error('身高数据格式异常，无法计算');
                        return;
                    }
                    
                    if (!weightValue) {
                        console.error('体重记录缺少value字段:', latestWeightRecord);
                        for (const key in latestWeightRecord) {
                            console.log(`体重记录字段${key}:`, latestWeightRecord[key]);
                        }
                        this.$message.error('体重数据格式异常，无法计算');
                        return;
                    }
                    
                    // 显示原始值
                    console.log('身高原始值:', heightValue);
                    console.log('体重原始值:', weightValue);
                    
                    // 转换为数字
                    heightValue = parseFloat(heightValue);
                    weightValue = parseFloat(weightValue);
                    
                    if (isNaN(heightValue) || isNaN(weightValue)) {
                        this.$message.error('数据格式错误，无法计算');
                        return;
                    }
                    
                    // 身高单位可能是米，需要转换为厘米
                    if (heightValue < 3) {
                        console.log('身高小于3，转换为厘米:', heightValue, '->', heightValue * 100);
                        heightValue = heightValue * 100;
                    }
                    
                    // 获取用户年龄和性别
                    const age = userInfo.age || 25;
                    const gender = userInfo.gender;
                    
                    console.log('计算使用的数据 - 身高:', heightValue, '厘米, 体重:', weightValue, '千克, 年龄:', age, '性别:', gender ? '男' : '女');
                    
                    // 计算健康指标
                    this.calculateBMI(heightValue, weightValue);
                    this.calculateBodyFatRate(gender, age, heightValue, weightValue);
                    this.calculateBMR(gender, age, heightValue, weightValue);
                    
                    console.log('计算完成，结果:', {
                        bmi: this.bmiValue,
                        bodyFat: this.bodyFatRate,
                        bmr: this.bmrValue
                    });
                    
                    // 使用右下角小提示替代全屏消息
                    this.$notify({
                        title: '指标已更新',
                        message: '健康指标计算已完成',
                        position: 'bottom-right',
                        duration: 1500,
                        type: 'success',
                        showClose: false
                    });
                    
                    // 准备详细的计算信息
                    const detailInfo = `
                    <div style="text-align: left; font-family: monospace;">
                    <h3>计算过程</h3>
                    <p><b>使用的数据:</b></p>
                    <ul>
                    <li>身高: ${heightValue} 厘米</li>
                    <li>体重: ${weightValue} 千克</li>
                    <li>年龄: ${age} 岁</li>
                    <li>性别: ${gender ? '男' : '女'}</li>
                    </ul>
                    <p><b>计算结果:</b></p>
                    <ul>
                    <li>BMI: ${this.bmiValue} (${this.bmiDescription})</li>
                    <li>体脂率: ${this.bodyFatRate}% (${this.bodyFatDescription})</li>
                    <li>基础代谢率: ${this.bmrValue} kcal</li>
                    </ul>
                    <p><b>计算公式:</b></p>
                    <ul>
                    <li>BMI = 体重(${weightValue}kg) / (身高(${heightValue/100}m)²) = ${this.bmiValue}</li>
                    <li>体脂率 = 1.2 × BMI + 0.23 × 年龄 - 5.4 - 10.8 × ${gender ? '1' : '0'} = ${this.bodyFatRate}%</li>
                    <li>基础代谢率(${gender ? '男' : '女'}) = ${gender ? 
                      `(13.7 × ${weightValue}) + (5.0 × ${heightValue}) - (6.8 × ${age}) + 66` : 
                      `(9.6 × ${weightValue}) + (1.8 × ${heightValue}) - (4.7 × ${age}) + 655`} = ${this.bmrValue} kcal</li>
                    </ul>
                    </div>
                    `;
                    
                    // 只有当showDetails为true时才显示详情弹窗
                    if (showDetails) {
                        // 弹窗显示详细计算过程
                        this.$alert(detailInfo, '健康指标计算详情', {
                            dangerouslyUseHTMLString: true,
                            customClass: 'calculation-details-dialog',
                            closeOnClickModal: true,
                            closeOnPressEscape: true,
                            confirmButtonText: '我知道了'
                        });
                    }
                    
                } catch (error) {
                    console.error('获取健康数据异常:', error);
                    this.$message.error('获取健康数据失败: ' + (error.message || '未知错误'));
                }
            } catch (error) {
                console.error('健康计算总异常:', error);
                this.$message.error('计算健康指标失败: ' + (error.message || '未知错误'));
            }
        },
        
        // 计算BMI
        calculateBMI(height, weight) {
            if (!height || !weight) return;
            
            // 转换为数字并确保有效
            const h = parseFloat(height) / 100; // 转换为米
            const w = parseFloat(weight);
            
            // 计算BMI
            const bmi = w / (h * h);
            
            if (isNaN(bmi) || bmi <= 0) {
                console.error('BMI计算错误:', { height, weight, bmi });
                return;
            }
            
            this.bmiValue = bmi.toFixed(1);
            
            // 设置BMI描述
            if (bmi < 18.5) {
                this.bmiDescription = '体重过轻';
            } else if (bmi < 24) {
                this.bmiDescription = '体重正常';
            } else if (bmi < 28) {
                this.bmiDescription = '超重';
            } else {
                this.bmiDescription = '肥胖';
            }
        },
        
        // 计算体脂率
        calculateBodyFatRate(gender, age, height, weight) {
            if (gender === undefined || !age || !height || !weight) return;
            
            // 转换为数字
            const h = parseFloat(height) / 100; // 转换为米
            const w = parseFloat(weight);
            const a = parseInt(age);
            
            // 计算BMI
            const bmi = w / (h * h);
            
            if (isNaN(bmi) || bmi <= 0) {
                console.error('体脂率计算错误 - BMI无效:', { height, weight, bmi });
                return;
            }
            
            // 体脂率计算公式：1.2 * BMI + 0.23 * 年龄 - 5.4 - 10.8 * 性别(男:1,女:0)
            const genderFactor = gender ? 1 : 0;
            const bodyFat = (1.2 * bmi) + (0.23 * a) - 5.4 - (10.8 * genderFactor);
            
            if (isNaN(bodyFat)) {
                console.error('体脂率计算错误:', { bmi, age, gender, bodyFat });
                return;
            }
            
            this.bodyFatRate = bodyFat.toFixed(1);
            
            // 设置体脂率描述
            if (gender) { // 男性
                if (bodyFat < 10) {
                    this.bodyFatDescription = '偏低';
                } else if (bodyFat < 20) {
                    this.bodyFatDescription = '健康';
                } else if (bodyFat < 25) {
                    this.bodyFatDescription = '超重';
                } else {
                    this.bodyFatDescription = '肥胖';
                }
            } else { // 女性
                if (bodyFat < 15) {
                    this.bodyFatDescription = '偏低';
                } else if (bodyFat < 25) {
                    this.bodyFatDescription = '健康';
                } else if (bodyFat < 30) {
                    this.bodyFatDescription = '超重';
                } else {
                    this.bodyFatDescription = '肥胖';
                }
            }
        },
        
        // 计算基础代谢率
        calculateBMR(gender, age, height, weight) {
            if (gender === undefined || !age || !height || !weight) return;
            
            // 转换为数字
            const h = parseFloat(height);
            const w = parseFloat(weight);
            const a = parseInt(age);
            
            if (isNaN(h) || isNaN(w) || isNaN(a)) {
                console.error('BMR计算错误 - 无效输入:', { height, weight, age });
                return;
            }
            
            // 基础代谢率计算公式
            let bmr;
            
            if (gender) { // 男性
                bmr = (13.7 * w) + (5.0 * h) - (6.8 * a) + 66;
            } else { // 女性
                bmr = (9.6 * w) + (1.8 * h) - (4.7 * a) + 655;
            }
            
            if (isNaN(bmr)) {
                console.error('BMR计算错误:', { height, weight, age, gender, bmr });
                return;
            }
            
            this.bmrValue = Math.round(bmr);
        },
        
        // 新增获取运动数据方法
        fetchExerciseData() {
            // 实际项目中这里应该调用API获取运动数据
            // 这里使用模拟数据
            this.latestExerciseStats = {
                steps: 6500,
                minutes: 45,
                calories: 320,
            };
            
            // 更新图表数据
            this.$nextTick(() => {
                if (this.exerciseChart) {
                    this.updateExerciseChart();
                }
            });
        },
        
        // 新增获取饮食数据方法
        fetchDietData() {
            // 实际项目中这里应该调用API获取饮食数据
            // 这里使用模拟数据
            this.latestDietStats = {
                calories: 1800,
                protein: 65,
                water: 1500,
            };
            
            // 更新图表数据
            this.$nextTick(() => {
                if (this.dietChart) {
                    this.updateDietChart();
                }
            });
        },
        
        // 初始化运动图表
        initExerciseChart() {
            if (!this.$refs.exerciseChart) return;
            
            // 确保容器已经渲染完成并有尺寸
            setTimeout(() => {
                this.exerciseChart = echarts.init(this.$refs.exerciseChart);
                this.updateExerciseChart();
                
                // 监听窗口大小变化，自适应调整图表大小
                window.addEventListener('resize', this.resizeExerciseChart);
            }, 100);
        },
        
        // 响应式调整运动图表大小
        resizeExerciseChart() {
            if (this.exerciseChart) {
                this.exerciseChart.resize();
            }
        },
        
        // 更新运动图表数据
        updateExerciseChart() {
            const option = {
                tooltip: {
                    trigger: 'axis',
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    top: '10%',
                    containLabel: true
                },
                xAxis: {
                    type: 'category',
                    data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
                    axisLine: { show: false },
                    axisTick: { show: false },
                },
                yAxis: {
                    type: 'value',
                    axisLine: { show: false },
                    axisTick: { show: false },
                    splitLine: { show: false }
                },
                series: [{
                    data: [5000, 7200, 3600, 8000, 5600, 6200, 6500],
                    type: 'line',
                    smooth: true,
                    symbol: 'circle',
                    symbolSize: 8,
                    itemStyle: {
                        color: '#4CAF50'
                    },
                    lineStyle: {
                        color: '#4CAF50',
                        width: 3
                    },
                    areaStyle: {
                        color: {
                            type: 'linear',
                            x: 0,
                            y: 0,
                            x2: 0,
                            y2: 1,
                            colorStops: [{
                                offset: 0,
                                color: 'rgba(76, 175, 80, 0.3)'
                            }, {
                                offset: 1,
                                color: 'rgba(76, 175, 80, 0.05)'
                            }]
                        }
                    }
                }]
            };
            this.exerciseChart.setOption(option);
        },
        
        // 初始化饮食图表
        initDietChart() {
            if (!this.$refs.dietChart) return;
            
            // 确保容器已经渲染完成并有尺寸
            setTimeout(() => {
                this.dietChart = echarts.init(this.$refs.dietChart);
                this.updateDietChart();
                
                // 监听窗口大小变化，自适应调整图表大小
                window.addEventListener('resize', this.resizeDietChart);
            }, 100);
        },
        
        // 响应式调整饮食图表大小
        resizeDietChart() {
            if (this.dietChart) {
                this.dietChart.resize();
            }
        },
        
        // 更新饮食图表数据
        updateDietChart() {
            const option = {
                tooltip: {
                    trigger: 'item'
                },
                series: [
                    {
                        name: '营养分布',
                        type: 'pie',
                        radius: ['40%', '70%'],
                        center: ['50%', '50%'],
                        avoidLabelOverlap: false,
                        itemStyle: {
                            borderRadius: 10,
                            borderColor: '#fff',
                            borderWidth: 2
                        },
                        label: {
                            show: false,
                            position: 'center'
                        },
                        emphasis: {
                            label: {
                                show: true,
                                fontSize: '14',
                                fontWeight: 'bold'
                            }
                        },
                        labelLine: {
                            show: false
                        },
                        data: [
                            { value: 35, name: '蛋白质', itemStyle: { color: '#FF9800' } },
                            { value: 45, name: '碳水化合物', itemStyle: { color: '#2196F3' } },
                            { value: 20, name: '脂肪', itemStyle: { color: '#F44336' } }
                        ]
                    }
                ]
            };
            this.dietChart.setOption(option);
        },
        
        // 加载健康摘要数据
        async loadHealthSummary() {
            try {
                // 从健康数据中提取体重信息
                await this.extractWeightData();
                
                // 提取心率信息
                await this.extractHeartRateData();
                
                // 提取睡眠信息
                await this.extractSleepData();
                
                // 提取血压信息
                await this.extractBloodPressureData();
            } catch (error) {
                console.error('加载健康摘要数据失败:', error);
            }
        },
        
        // 提取体重数据
        async extractWeightData() {
            try {
                // 查找体重相关的健康模型
                const weightModel = this.usersHealthModelConfig.find(model => 
                    model.name === '体重' || model.name.includes('体重')
                );
                
                if (weightModel) {
                    // 获取体重数据
                    const response = await this.$axios.get(`/user-health/timeQuery/${weightModel.id}/30`);
                    const { data } = response;
                    if (data.code === 200 && data.data.length > 0) {
                        // 获取最新体重数据
                        const weightData = data.data;
                        const latestWeight = weightData[0];
                        
                        // 设置最新体重值
                        this.latestWeightValue = parseFloat(latestWeight.value);
                        
                        // 计算变化趋势
                        if (weightData.length > 1) {
                            const previousWeight = parseFloat(weightData[1].value);
                            const diff = this.latestWeightValue - previousWeight;
                            this.weightChange = Math.abs(diff).toFixed(1) + ' kg';
                            if (diff > 0) {
                                this.weightTrend = 'up';
                            } else if (diff < 0) {
                                this.weightTrend = 'down';
                            } else {
                                this.weightTrend = null;
                            }
                        }
                    }
                }
            } catch (error) {
                console.error('提取体重数据失败:', error);
            }
        },
        
        // 提取心率数据
        async extractHeartRateData() {
            try {
                // 查找心率相关的健康模型
                const heartRateModel = this.usersHealthModelConfig.find(model => 
                    model.name === '心率' || model.name.includes('心率') || model.name.includes('脉搏')
                );
                
                if (heartRateModel) {
                    // 获取心率数据
                    const response = await this.$axios.get(`/user-health/timeQuery/${heartRateModel.id}/7`);
                    const { data } = response;
                    if (data.code === 200 && data.data.length > 0) {
                        // 获取最新心率数据
                        const latestHeartRate = data.data[0];
                        this.latestHeartRate = parseFloat(latestHeartRate.value);
                        
                        // 简单评估心率状况
                        if (this.latestHeartRate < 60) {
                            this.heartRateStatus = '偏低';
                        } else if (this.latestHeartRate > 100) {
                            this.heartRateStatus = '偏高';
                        } else {
                            this.heartRateStatus = '正常范围';
                        }
                    }
                } else {
                    // 模拟数据
                    this.latestHeartRate = 75;
                    this.heartRateStatus = '正常范围';
                }
            } catch (error) {
                console.error('提取心率数据失败:', error);
                // 模拟数据
                this.latestHeartRate = 75;
                this.heartRateStatus = '正常范围';
            }
        },
        
        // 提取睡眠数据
        async extractSleepData() {
            try {
                // 查找睡眠相关的健康模型
                const sleepModel = this.usersHealthModelConfig.find(model => 
                    model.name === '睡眠' || model.name.includes('睡眠') || model.name.includes('睡眠时长')
                );
                
                if (sleepModel) {
                    // 获取睡眠数据
                    const response = await this.$axios.get(`/user-health/timeQuery/${sleepModel.id}/7`);
                    const { data } = response;
                    if (data.code === 200 && data.data.length > 0) {
                        // 获取最新睡眠数据
                        const latestSleep = data.data[0];
                        this.sleepHours = parseFloat(latestSleep.value);
                        
                        // 评估睡眠质量
                        if (this.sleepHours < 6) {
                            this.sleepQuality = '睡眠不足';
                        } else if (this.sleepHours > 9) {
                            this.sleepQuality = '睡眠过多';
                        } else {
                            this.sleepQuality = '睡眠良好';
                        }
                    }
                } else {
                    // 模拟数据
                    this.sleepHours = 7.5;
                    this.sleepQuality = '睡眠良好';
                }
            } catch (error) {
                console.error('提取睡眠数据失败:', error);
                // 模拟数据
                this.sleepHours = 7.5;
                this.sleepQuality = '睡眠良好';
            }
        },
        
        // 提取血压数据
        async extractBloodPressureData() {
            try {
                // 查找血压相关的健康模型
                const bpModel = this.usersHealthModelConfig.find(model => 
                    model.name === '血压' || model.name.includes('血压') || model.name.includes('收缩压')
                );
                
                if (bpModel) {
                    // 获取血压数据
                    const response = await this.$axios.get(`/user-health/timeQuery/${bpModel.id}/7`);
                    const { data } = response;
                    if (data.code === 200 && data.data.length > 0) {
                        // 获取最新血压数据
                        const latestBP = data.data[0];
                        // 假设血压值存储为"收缩压/舒张压"格式
                        this.bloodPressure = latestBP.value;
                        
                        // 评估血压状况
                        const bpParts = this.bloodPressure.split('/');
                        if (bpParts.length === 2) {
                            const systolic = parseFloat(bpParts[0]);
                            const diastolic = parseFloat(bpParts[1]);
                            
                            if (systolic < 90 || diastolic < 60) {
                                this.bloodPressureStatus = '低血压';
                            } else if (systolic > 140 || diastolic > 90) {
                                this.bloodPressureStatus = '高血压';
                            } else {
                                this.bloodPressureStatus = '正常范围';
                            }
                        }
                    }
                } else {
                    // 模拟数据
                    this.bloodPressure = '120/80';
                    this.bloodPressureStatus = '正常范围';
                }
            } catch (error) {
                console.error('提取血压数据失败:', error);
                // 模拟数据
                this.bloodPressure = '120/80';
                this.bloodPressureStatus = '正常范围';
            }
        },
    }
};
</script>

<style scoped lang="scss">
.health-dashboard {
    font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;
    background-color: #f5f7fa;
    padding-bottom: 30px;
}

/* Header Banner */
.dashboard-header {
    padding: 40px 0;
    background: linear-gradient(135deg, #42b983 0%, #33a06f 100%);
    color: white;
    text-align: center;
    border-radius: 0 0 20px 20px;
    margin-bottom: 30px;
    box-shadow: 0 6px 20px rgba(66, 185, 131, 0.2);
    position: relative;
    overflow: hidden;
    
    &::before {
        content: '';
        position: absolute;
        top: -10%;
        left: -10%;
        width: 120%;
        height: 120%;
        background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="rgba(255,255,255,0.05)"/></svg>');
        background-size: 100px 100px;
        opacity: 0.4;
        animation: pulse 8s infinite linear;
    }
    
    @keyframes pulse {
        0% {
            opacity: 0.3;
            transform: scale(1);
        }
        50% {
            opacity: 0.5;
            transform: scale(1.05);
        }
        100% {
            opacity: 0.3;
            transform: scale(1);
        }
    }
}

.dashboard-title {
    position: relative;
    z-index: 1;
    
    h1 {
        font-size: 36px;
        margin-bottom: 10px;
        font-weight: 600;
        letter-spacing: 2px;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    p {
        font-size: 16px;
        margin-bottom: 30px;
        opacity: 0.9;
        max-width: 600px;
        margin-left: auto;
        margin-right: auto;
    }
}

.action-button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 12px 26px;
    background-color: rgba(255, 255, 255, 0.2);
    border-radius: 30px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 16px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    
    &:hover {
        background-color: rgba(255, 255, 255, 0.3);
        transform: translateY(-3px) scale(1.02);
        box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
    }
    
    i {
        margin-left: 8px;
        font-weight: bold;
        transition: transform 0.3s ease;
    }
    
    &:hover i {
        transform: translateX(4px);
    }
}

/* Dashboard Layout */
.dashboard-container {
    display: flex;
    gap: 20px;
    margin: 0 30px 0;
    
    @media screen and (max-width: 1200px) {
        flex-direction: column;
    }
}

/* 确保第二行容器内容完整显示 */
.dashboard-container:nth-child(3) {
    flex-wrap: wrap;
    margin-bottom: 30px;
    position: relative;
    z-index: 1;
}

/* 调整第二行的左右列宽比例为更接近截图效果 */
.summary-column {
    flex: 0.8; /* 减小摘要列的宽度比例 */
    max-width: 22%; /* 减小摘要部分的最大宽度 */
    margin-right: 20px; /* 保持与第一行相同的间距 */
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.data-column {
    flex: 5.2; /* 增加数据列的宽度比例 */
    min-width: calc(78% - 20px); /* 增加健康指标数据部分的宽度 */
    position: relative;
    z-index: 1;
    display: flex; /* 确保内容能够填充整个高度 */
    flex-direction: column;
}

.dashboard-column {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 20px;
    min-width: 0; /* 防止内容溢出 */
}

/* 调整摘要列的间距 */
.summary-column {
    gap: 12px; /* 减小摘要卡片之间的间距 */
}

/* Cards */
.dashboard-card {
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    padding: 20px;
    transition: all 0.3s ease;
    
    &:hover {
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
    }
}

.primary-card {
    flex: 1.5;
}

.score-card, .metrics-card {
    flex: 1;
}

.table-card {
    flex: 1;
    height: 100%; /* 确保表格卡片占满整个高度 */
}

.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    
    h2 {
        font-size: 16px;
        font-weight: 600;
        color: #333;
        margin: 0;
        position: relative;
        padding-left: 12px;
        
        &:before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            height: 16px;
            width: 3px;
            background: #42b983;
            border-radius: 2px;
        }
    }
    
    .el-button--text {
        color: #42b983;
        font-size: 14px;
        padding: 5px 10px;
        border-radius: 15px;
        transition: all 0.3s ease;
        
        &:hover {
            background-color: rgba(66, 185, 131, 0.1);
            color: #2c9e6a;
        }
        
        i {
            margin-left: 4px;
            font-size: 12px;
            font-weight: bold;
        }
    }
}

.chart-container {
    height: 350px;
}

/* Score Ball */
.combined-content {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    gap: 20px;
    height: calc(100% - 60px);
}

.score-section {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
}

.score-container {
    display: flex;
    flex-direction: column;
    align-items: center;
}

@media screen and (max-width: 1300px) {
    .combined-content {
        flex-direction: column;
    }
}

.score-ball {
    width: 200px;
    height: 200px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
    transition: all 0.5s ease;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
    position: relative;
    overflow: hidden;
    background-size: 400% 400%;
    animation: gradientMove 10s ease infinite;
    
    /* 外发光效果 */
    &::before {
        content: '';
        position: absolute;
        width: 100%;
        height: 100%;
        border-radius: 50%;
        background: inherit;
        filter: blur(15px);
        opacity: 0.6;
        z-index: -1;
    }
    
    /* 添加顶部高光 */
    &::after {
        content: '';
        position: absolute;
        top: 5%;
        left: 10%;
        width: 80%;
        height: 40%;
        background: linear-gradient(to bottom, rgba(255,255,255,0.25), rgba(255,255,255,0));
        border-radius: 50% 50% 50% 50% / 60% 60% 40% 40%;
    }
    
    &:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
    }
}

.score-text {
    font-size: 76px;
    font-weight: 800;
    color: white;
    text-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    position: relative;
    z-index: 2;
    font-family: 'Arial', sans-serif;
    letter-spacing: -2px;
    animation: float 3s ease-in-out infinite;
}

.score-description {
    font-size: 16px;
    text-align: center;
    color: #555;
    max-width: 220px;
    font-weight: 600;
    background-color: white;
    padding: 12px 18px;
    border-radius: 30px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    margin-top: 10px;
    transition: all 0.3s ease;
    
    &:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.15);
    }
}

.score-excellent {
    background: linear-gradient(45deg, #4caf50, #8bc34a);
}

.score-good {
    background: linear-gradient(45deg, #2196f3, #03a9f4, #4fc3f7);
}

.score-average {
    background: linear-gradient(45deg, #ff9800, #ffb74d);
}

.score-poor {
    background: linear-gradient(45deg, #f44336, #ff7043);
}

/* 现代动画效果 */
@keyframes gradientMove {
    0% {
        background-position: 0% 50%;
    }
    50% {
        background-position: 100% 50%;
    }
    100% {
        background-position: 0% 50%;
    }
}

@keyframes float {
    0% {
        transform: translateY(0px);
    }
    50% {
        transform: translateY(-5px);
    }
    100% {
        transform: translateY(0px);
    }
}

@keyframes appear {
    0% {
        opacity: 0;
        transform: scale(0.8);
    }
    100% {
        opacity: 1;
        transform: scale(1);
    }
}

/* 添加高亮光晕元素样式 */
.score-highlight {
    position: absolute;
    top: -30%;
    left: -30%;
    width: 160%;
    height: 160%;
    background: radial-gradient(ellipse at center, rgba(255,255,255,0.3) 0%, rgba(255,255,255,0) 70%);
    pointer-events: none;
    z-index: 2;
    animation: shine 4s infinite;
}

@keyframes shine {
    0% {
        opacity: 0;
        transform: translateX(-100%) translateY(-100%) rotate(0deg);
    }
    20% {
        opacity: 0.2;
    }
    35% {
        opacity: 0.3;
    }
    50% {
        opacity: 0;
        transform: translateX(100%) translateY(100%) rotate(40deg);
    }
    100% {
        opacity: 0;
        transform: translateX(100%) translateY(100%) rotate(40deg);
    }
}

/* 添加加载动画 */
.score-container {
    animation: appear 0.8s cubic-bezier(0.26, 0.53, 0.74, 1.48);
}

/* Health Metrics */
.health-metrics {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.metric-item {
    display: flex;
    align-items: center;
    padding: 10px;
    border-radius: 8px;
    background-color: #f9f9f9;
    transition: all 0.3s ease;
    
    &:hover {
        background-color: #f0f0f0;
        transform: translateX(5px);
    }
}

.metric-icon {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: rgba(66, 185, 131, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;
    margin-right: 15px;
    
    i {
        font-size: 24px;
        color: #42b983;
    }
}

.metric-content {
    flex: 1;
}

.metric-title {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 5px;
    color: #333;
}

.metric-value {
    font-size: 20px;
    font-weight: 600;
    margin-bottom: 2px;
    color: #42b983;
}

.metric-desc {
    font-size: 12px;
    color: #999;
}

/* Table */
.table-container {
    overflow-x: auto;
}

.custom-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    
    .el-table__header {
        th {
            background-color: #f9f9f9;
            color: #333;
            font-weight: 600;
        }
    }
    
    .el-table__row {
        transition: all 0.3s ease;
        
        &:hover {
            background-color: #f0f7f4;
        }
    }
}

.indicator-name {
    display: flex;
    align-items: center;
    font-size: 13px;
    
    i {
        margin-right: 5px;
        color: #42b983;
        font-size: 14px;
    }
}

.indicator-value {
    font-weight: 600;
    color: #333;
    font-size: 13px;
}

.status-indicator {
    display: inline-flex;
    align-items: center;
    padding: 2px 6px;
    border-radius: 12px;
    font-size: 12px;
    white-space: nowrap;
    
    i {
        margin-right: 4px;
        font-size: 13px;
    }
}

.status-normal {
    background-color: rgba(76, 175, 80, 0.1);
    color: #4caf50;
}

.status-abnormal {
    background-color: rgba(244, 67, 54, 0.1);
    color: #f44336;
}

.custom-pagination {
    margin-top: 12px;
    margin-bottom: 0;
    display: flex;
    justify-content: flex-end;
    padding: 8px 0;
}

/* Filter */
.filter-group {
    display: flex;
    align-items: center;
}

/* Combined Card */
.combined-card {
    height: 100%;
}

/* Table Card */
.table-card {
    height: 100%;
    display: flex;
    flex-direction: column;
    padding-bottom: 12px; /* 减少底部内边距 */
}

.table-container {
    flex: 1;
    overflow: auto;
    display: flex;
    flex-direction: column;
}

/* 第二行布局样式调整 */
.dashboard-container + .dashboard-container {
    margin-top: 20px;
}

.dashboard-container + .dashboard-container .dashboard-column {
    min-height: auto;
}

/* 确保表格区域可滚动 */
.custom-table {
    flex: 1;
    min-height: 350px; /* 确保表格有足够的最小高度 */
    overflow-y: auto;
}

.summary-card {
    width: 100%;
    height: auto;
    flex: 1;
    margin-bottom: 0;
    padding: 15px;
    position: relative;
    z-index: 2;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    display: flex;
    flex-direction: column;
}

.summary-content {
    display: flex;
    flex-direction: column;
    gap: 0;
    padding: 5px;
    align-items: center;
    justify-content: center;
    flex: 1; /* 使内容填充整个卡片高度 */
}

/* 响应式调整 */
@media screen and (max-width: 1400px) {
    .summary-stats.vertical {
        gap: 10px;
    }
    
    .stat-content .stat-value {
        font-size: 16px;
    }
    
    .stat-content .stat-label {
        font-size: 11px;
    }
}

.summary-stats {
    display: flex;
    justify-content: space-between;
}

/* 竖向排列的摘要统计 */
.summary-stats.vertical {
    flex-direction: row;
    justify-content: space-around;
    gap: 5px;
    margin: 15px auto 5px;
    padding: 0;
    width: 100%;
}

.summary-stat-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    background-color: #f9f9f9;
    border-radius: 8px;
    padding: 10px 5px;
    width: 30%;
    transition: all 0.2s ease;
    
    &:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
}

.stat-icon {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 8px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
    
    i {
        font-size: 18px;
        color: white;
    }
}

.exercise-icon {
    background: linear-gradient(135deg, #4CAF50, #2E7D32);
}

.time-icon {
    background: linear-gradient(135deg, #2196F3, #0D47A1);
}

.calories-icon {
    background: linear-gradient(135deg, #FF9800, #E65100);
}

.calorie-icon {
    background: linear-gradient(135deg, #E91E63, #880E4F);
}

.protein-icon {
    background: linear-gradient(135deg, #9C27B0, #4A148C);
}

.water-icon {
    background: linear-gradient(135deg, #03A9F4, #01579B);
}

.stat-content {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.stat-value {
    font-size: 18px;
    font-weight: 600;
    color: #333;
    margin-bottom: 2px;
}

.stat-label {
    font-size: 12px;
    color: #666;
    white-space: nowrap;
}

.summary-chart {
    margin: 15px auto 10px;
    overflow: hidden;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
}

.chart-container-responsive {
    width: 100%;
    height: 150px; /* 增加图表高度 */
    max-width: 280px;
    margin: 0 auto;
}

/* Responsive adjustments */
@media screen and (max-width: 768px) {
    .dashboard-header {
        padding: 30px 0;
    }
    
    .dashboard-title h1 {
        font-size: 24px;
    }
    
    .dashboard-container, .summary-section {
        margin: 0 15px 20px;
    }
    
    .summary-stats {
        flex-direction: column;
        gap: 15px;
    }
    
    .filter-group {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
    }
}

/* 健康指标摘要卡片样式 */
.health-summary-column {
    width: 100%;
}

.summary-highlight-card {
    margin-bottom: 12px;
    padding: 12px;
    height: auto;
    width: 100%; /* 确保宽度一致 */
    max-width: 320px; /* 限制最大宽度 */
    margin-left: auto;
    margin-right: auto;
    flex: 1;
    border-radius: 15px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    border-top: 3px solid #42b983;
    background: linear-gradient(to bottom, #ffffff, #fafafa);
}

.summary-highlights-content {
    display: flex;
    flex-direction: column;
    gap: 8px; /* 减少间距 */
    padding: 3px 0;
    width: 100%; /* 确保宽度 */
    overflow: visible; /* 允许内容溢出 */
}

/* 调整卡片头部样式 */
.summary-highlight-card .card-header {
    margin-bottom: 10px;
}

.summary-highlight-card .card-header h2 {
    font-size: 15px;
}

.summary-highlight-item {
    flex: none;
    width: calc(100% - 20px); /* 保持宽度不变 */
    max-width: 240px; /* 保持最大宽度不变 */
    margin: 0 auto; /* 居中显示 */
    padding: 15px 12px 15px 10px; /* 进一步增加上下内边距 */
    margin-bottom: 0;
    display: flex;
    align-items: center;
    justify-content: flex-start;
    border-radius: 10px;
    background: linear-gradient(to right, #f9f9f9, #f5f5f5);
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    overflow: visible;
    border-left: none;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    position: relative;
    
    &::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        border-radius: 10px; /* 减小圆角 */
        opacity: 0;
        background: linear-gradient(to right, rgba(255,255,255,0.1), rgba(255,255,255,0.2));
        transition: opacity 0.3s ease;
        pointer-events: none;
    }
    
    &:hover {
        background: linear-gradient(to right, #f0f0f0, #e8e8e8);
        transform: translateY(-2px);
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
        
        &::before {
            opacity: 1;
        }
        
        .highlight-icon {
            transform: scale(1.05);
        }
    }
    
    &:nth-child(1) {
        border-left: 4px solid #3498db; /* 增加左侧边框宽度 */
        .highlight-icon {
            background: linear-gradient(135deg, #3498db, #2980b9);
        }
    }
    
    &:nth-child(2) {
        border-left: 4px solid #e74c3c; /* 增加左侧边框宽度 */
        .highlight-icon {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
        }
    }
    
    &:nth-child(3) {
        border-left: 4px solid #9b59b6; /* 增加左侧边框宽度 */
        .highlight-icon {
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
        }
    }
    
    &:nth-child(4) {
        border-left: 4px solid #2ecc71; /* 增加左侧边框宽度 */
        .highlight-icon {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
        }
    }
}

.highlight-icon {
    width: 42px; /* 进一步增加图标尺寸 */
    height: 42px;
    min-width: 42px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-right: 12px; /* 增加右侧间距 */
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
    position: relative;
    overflow: hidden;
    transition: all 0.3s ease;
    
    &::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: radial-gradient(circle at 70% 70%, rgba(255, 255, 255, 0.3), transparent);
    }
    
    i {
        font-size: 20px; /* 增加图标字体大小 */
        color: white;
        position: relative;
        z-index: 1;
        text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
    }
}

.highlight-info {
    display: flex;
    flex-direction: column;
    flex: 1;
    min-width: 0;
    padding-right: 0; /* 移除右侧内边距 */
    margin-right: 5px; /* 添加右侧外边距 */
}

.highlight-title {
    font-size: 13px; /* 增加标题字体大小 */
    color: #666;
    white-space: nowrap;
    margin-bottom: 6px; /* 增加标题和值之间的间距 */
    font-weight: 500;
}

.highlight-value {
    font-size: 17px; /* 增加值的字体大小 */
    font-weight: 600;
    color: #333;
    white-space: nowrap;
    letter-spacing: 0.3px;
    line-height: 1.4; /* 增加行高 */
    margin-right: 8px;
}

.summary-highlights-content {
    display: flex;
    flex-direction: column;
    gap: 12px; /* 增加条条之间的间距 */
    padding: 5px 0;
    width: 100%;
    overflow: visible;
}

/* 调整卡片的整体尺寸 */
.summary-highlight-card {
    margin-bottom: 12px;
    padding: 12px;
    height: auto;
    width: 100%; /* 确保宽度一致 */
    max-width: 300px; /* 限制最大宽度 */
    margin-left: auto;
    margin-right: auto;
    flex: 1;
    border-radius: 15px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    border-top: 3px solid #42b983;
    background: linear-gradient(to bottom, #ffffff, #fafafa);
}

.highlight-desc, .highlight-change {
    font-size: 12px;
    color: #888;
    white-space: nowrap;
    min-width: 60px; /* 减小最小宽度 */
    text-align: right;
    overflow: visible; /* 确保文字可见 */
    padding: 3px 8px; /* 调整内边距 */
    border-radius: 12px; /* 调整圆角 */
    background-color: rgba(0, 0, 0, 0.03);
    transition: all 0.3s ease;
    margin-left: auto; /* 添加左侧外边距自动，将元素推到右侧 */
    margin-right: 8px; /* 增加右侧外边距，避免贴近右边线 */
    
    i {
        margin-right: 2px; /* 减小图标右侧间距 */
        font-size: 11px; /* 减小图标大小 */
    }
}

.trend-up {
    color: #e74c3c;
    background-color: rgba(231, 76, 60, 0.1);
}

.trend-down {
    color: #2ecc71;
    background-color: rgba(46, 204, 113, 0.1);
}

/* 根据不同的状态设置不同的背景色 */
.summary-highlight-item:nth-child(1) .highlight-desc,
.summary-highlight-item:nth-child(1) .highlight-change {
    background-color: rgba(52, 152, 219, 0.08);
}

.summary-highlight-item:nth-child(2) .highlight-desc {
    background-color: rgba(231, 76, 60, 0.08);
}

.summary-highlight-item:nth-child(3) .highlight-desc {
    background-color: rgba(155, 89, 182, 0.08);
}

.summary-highlight-item:nth-child(4) .highlight-desc {
    background-color: rgba(46, 204, 113, 0.08);
}

/* 移除原来的图标背景样式 */
.weight-icon, .heart-icon, .sleep-icon, .pressure-icon {
    background: none;
}

@media screen and (max-width: 1400px) {
    .summary-column {
        max-width: 24%; /* 在较小屏幕上略微增加宽度 */
    }
    
    .data-column {
        min-width: calc(76% - 20px);
    }
}

@media screen and (max-width: 1200px) {
    .summary-column {
        max-width: 100%;
        flex: 1;
    }
    
    .data-column {
        min-width: 100%;
        flex: 1;
    }
    
    .summary-highlight-card {
        max-width: 100%;
    }
}

@media screen and (max-width: 768px) {
    .summary-highlights-content {
        flex-direction: column;
    }
    
    .summary-highlight-item {
        width: 100%;
        padding: 10px 8px;
    }
    
    .highlight-icon {
        width: 32px;
        height: 32px;
        min-width: 32px;
        margin-right: 8px;
    }
    
    .highlight-info {
        padding-right: 5px;
    }
    
    .highlight-desc, .highlight-change {
        min-width: 60px;
        font-size: 12px;
    }
}

.weight-icon {
    background: linear-gradient(135deg, #3498db, #2980b9);
}

.heart-icon {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
}

.sleep-icon {
    background: linear-gradient(135deg, #9b59b6, #8e44ad);
}

.pressure-icon {
    background: linear-gradient(135deg, #2ecc71, #27ae60);
}

/* 自定义文本按钮样式 */
.custom-text-button {
    color: #42b983;
    font-size: 14px;
    padding: 5px 10px;
    border-radius: 15px;
    transition: all 0.3s ease;
    
    &:hover {
        background-color: rgba(66, 185, 131, 0.1);
        color: #2c9e6a;
    }
    
    i {
        margin-left: 4px;
        font-size: 12px;
        font-weight: bold;
    }
}

/* 卡片标题样式增强 */
.card-header h2 {
    font-size: 16px;
    font-weight: 600;
    color: #333;
    margin: 0;
    position: relative;
    padding-left: 12px;
    
    &:before {
        content: '';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        height: 16px;
        width: 3px;
        background: #42b983;
        border-radius: 2px;
    }
}
</style>