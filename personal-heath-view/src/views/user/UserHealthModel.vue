<template>
    <div>
        <div style="border-radius: 5px;padding: 20px 0 60px 0;width: 100%;background-color: #fafafa;">
            <div style="height: 100px;line-height: 100px;text-align: center;font-size: 24px;">
                健康生活，健康人生，从此刻开始！
            </div>
            <div style="height: 50px;line-height: 50px;text-align: center;font-size: 30px;font-weight: bolder;">
                每一点改变，都值得被记录。
                <span @click="toRecord"
                    style="cursor: pointer;;padding: 5px 10px;background-color: #000;border-radius: 5px;color: #fff;">
                    前去记录
                    <i class="el-icon-right"></i>
                </span>
            </div>
        </div>
        <div style="display: flex;justify-content: space-between;padding: 20px 50px;">
            <div style="flex: 1;min-width: 50%;margin-right: 20px;">
                <div style="margin-bottom: 20px;">
                    <!-- 选择具体的指标模型 -->
                    <el-select size="small" @change="modelChange" v-model="userHealthQueryDto.healthModelConfigId"
                        placeholder="请选择">
                        <el-option v-for="model in usersHealthModelConfig" :key="model.id" :label="model.name"
                            :value="model.id">
                        </el-option>
                    </el-select>
                </div>
                <div>
                    <LineChart @on-selected="onSelectedTime" height="500px" tag="" :values="values" :date="dates" />
                </div>
                <!-- 添加身体评分可视化组件 -->
                <div class="score-container">
                    <div class="score-title">身体健康评分</div>
                    <div class="score-ball" :class="scoreClass">
                        <span class="score-text">{{ healthScore }}</span>
                    </div>
                    <div class="score-description">{{ scoreDescription }}</div>
                </div>

                <!-- 添加健康指标计算数据 -->
                <div class="health-metrics-container">
                    <h3>健康指标计算</h3>
                    <el-button type="primary" size="small" class="calculate-btn" @click="showCalculationDetails">计算详情</el-button>
                    <div class="health-metrics">
                        <div class="metric-item">
                            <div class="metric-title">BMI指数</div>
                            <div class="metric-value">{{ bmiValue || '-- --' }}</div>
                            <div class="metric-desc">{{ bmiDescription }}</div>
                        </div>
                        <div class="metric-item">
                            <div class="metric-title">体脂率</div>
                            <div class="metric-value">{{ bodyFatRate || '-- --' }}%</div>
                            <div class="metric-desc">{{ bodyFatDescription }}</div>
                        </div>
                        <div class="metric-item">
                            <div class="metric-title">基础代谢率</div>
                            <div class="metric-value">{{ bmrValue || '-- --' }} kcal</div>
                            <div class="metric-desc">每日消耗的最低热量</div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="flex: 1;min-width: 50%;">
                <h2 style="padding-left: 20px;border-left: 2px solid rgb(43, 121, 203);">健康指标数据</h2>
                <el-row style="padding: 10px;margin-left: 10px;">
                    <el-row style="display: flex;justify-content: left;align-items: center;gap: 10px;">
                        <el-select size="small" @change="fetchFreshData" v-model="healthModelConfigId" placeholder="请选择模型项">
                            <el-option :key="null" label="全部" :value="null">
                            </el-option>
                            <el-option v-for="model in usersHealthModelConfig" :key="model.id" :label="model.name"
                                :value="model.id">
                            </el-option>
                        </el-select>
                        <el-date-picker size="small" @change="timeChange" style="width: 220px;" v-model="searchTime"
                            type="daterange" range-separator="至" start-placeholder="记录开始" end-placeholder="记录结束">
                        </el-date-picker>
                    </el-row>
                </el-row>
                <el-row style="margin: 0 20px;border-top: 1px solid rgb(245,245,245);">
                    <el-table row-key="id" @selection-change="handleSelectionChange" :data="filteredTableData">
                        <el-table-column prop="name" label="指标项">
                            <template slot-scope="scope">
                                <span><i class="el-icon-paperclip" style="margin-right: 3px;"></i>{{ scope.row.name
                                    }}</span>
                            </template>
                        </el-table-column>
                        <el-table-column prop="value" width="148" label="数值" sortable>
                            <template slot-scope="scope">
                                <span style="font-weight: 800;">{{ scope.row.value }}&nbsp;{{ scope.row.unit }}</span>
                            </template>
                        </el-table-column>
                        <el-table-column prop="symbol" width="108" label="模型符号"></el-table-column>
                        <!-- <el-table-column prop="valueRange" width="128" label="阈值"></el-table-column> -->
                        <el-table-column prop="name" width="88" label="状态">
                            <template slot-scope="scope">
                                <i v-if="!statusCheck(scope.row)" style="margin-right: 5px;" class="el-icon-warning"></i>
                                <i v-else style="margin-right: 5px;color: rgb(253, 199, 50);" class="el-icon-success"></i>
                                <el-tooltip v-if="!statusCheck(scope.row)" class="item" effect="dark"
                                    content="异常指标，提醒用户及时处理" placement="bottom-end">
                                    <span style="text-decoration: underline;text-decoration-style: dashed;">异常</span>
                                </el-tooltip>
                                <span v-else>正常</span>
                            </template>
                        </el-table-column>
                        <el-table-column prop="createTime" width="178" label="记录时间" sortable></el-table-column>
                        <el-table-column label="操作" width="80">
                            <template slot-scope="scope">
                                <span class="text-button" @click="handleDelete(scope.row)">删除</span>
                            </template>
                        </el-table-column>
                    </el-table>
                    <el-pagination style="margin: 20px 0;" @size-change="handleSizeChange"
                        @current-change="handleCurrentChange" :current-page="currentPage" :page-sizes="[10, 20]"
                        :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                        :total="totalItems"></el-pagination>
                </el-row>
            </div>
        </div>
    </div>
</template>

<script>
import LineChart from '@/components/LineChart.vue';
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
            // 这里是计算健康评分的逻辑，可以根据后端数据或本地计算
            // 示例逻辑：根据用户的健康记录数据计算
            // 实际项目中，您可能需要根据各种指标（如BMI、血压、血糖等）综合计算
            if (this.tableData.length > 0) {
                // 统计异常指标的数量
                const abnormalCount = this.tableData.filter(item => !this.statusCheck(item)).length;
                // 根据异常指标数量计算评分
                const totalCount = this.tableData.length;
                const normalRate = (totalCount - abnormalCount) / totalCount;
                this.healthScore = Math.round(normalRate * 100);
            } else {
                // 默认评分
                this.healthScore = 85;
            }
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
    }
};
</script>

<style scoped lang="scss">
.status-success {
    display: inline-block;
    padding: 1px 5px;
    border-radius: 2px;
    background-color: rgb(201, 237, 249);
    color: rgb(111, 106, 196);
    font-size: 12px;
}

.status-error {
    display: inline-block;
    padding: 1px 5px;
    border-radius: 2px;
    background-color: rgb(233, 226, 134);
    color: rgb(131, 138, 142);
    color: rgb(111, 106, 196);
    font-size: 12px;
}

h2 {
    font-size: 24px;
    color: #333;
    margin-bottom: 20px;
}

.el-table {
    width: 100%;
    border-collapse: collapse;
}

.el-table-column {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center;
}

.el-pagination {
    text-align: right;
    margin-top: 20px;
}

.el-select {
    width: 200px;
}

.el-date-picker {
    width: 200px;
}

.el-input {
    width: 200px;
}

.el-button {
    margin-left: 10px;
}

.item-model {
    padding: 10px;
    border-bottom: 1px solid #f1f1f1;
    cursor: pointer;
}

.item-model:hover {
    background-color: #f5f5f5;
}

.dialog-title {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 20px;
}

.input-title {
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
}



/* 身体评分可视化组件样式 */
.score-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 30px;
    padding: 20px;
}

.score-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #333;
}

.score-ball {
    width: 240px;
    height: 240px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.score-text {
    font-size: 72px;
    font-weight: bold;
    color: #fff;
}

.score-description {
    font-size: 16px;
    text-align: center;
    color: #666;
}

.score-excellent {
    background: linear-gradient(to bottom right, #4caf50, #2e7d32);
}

.score-good {
    background: linear-gradient(to bottom right, #2196f3, #1565c0);
}

.score-average {
    background: linear-gradient(to bottom right, #ff9800, #e65100);
}

.score-poor {
    background: linear-gradient(to bottom right, #f44336, #b71c1c);
}

/* 健康指标计算数据样式 */
.health-metrics-container {
    margin-top: 30px;
    padding: 20px;
    position: relative;
}

.calculate-btn {
    position: absolute;
    top: 20px;
    right: 20px;
}

.health-metrics {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 20px;
}

.metric-item {
    text-align: center;
}

.metric-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
}

.metric-value {
    font-size: 24px;
    font-weight: bold;
    color: #333;
}

.metric-desc {
    font-size: 14px;
    color: #666;
}
</style>