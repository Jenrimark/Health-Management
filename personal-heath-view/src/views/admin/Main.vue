<template>
    <div style="box-sizing: border-box;overflow-y: auto;overflow-x: hidden;padding: 10px;">
        <!-- 用户数据概览卡片区域 -->
        <el-row :gutter="20" class="data-overview">
            <el-col :span="6">
                <el-card shadow="hover" class="data-card">
                    <div class="card-title">总注册用户</div>
                    <div class="card-content">
                        <span class="card-value">{{ totalUsers }}</span>
                        <span class="card-trend" :class="userGrowth > 0 ? 'up' : 'down'">
                            {{ userGrowth > 0 ? '+' : '' }}{{ userGrowth }}%
                            <i :class="userGrowth > 0 ? 'el-icon-top' : 'el-icon-bottom'"></i>
                        </span>
                    </div>
                    <div class="card-footer">与上周相比</div>
                </el-card>
            </el-col>
            <el-col :span="6">
                <el-card shadow="hover" class="data-card">
                    <div class="card-title">近7天活跃用户</div>
                    <div class="card-content">
                        <span class="card-value">{{ activeUsers }}</span>
                        <span class="card-trend" :class="activeGrowth > 0 ? 'up' : 'down'">
                            {{ activeGrowth > 0 ? '+' : '' }}{{ activeGrowth }}%
                            <i :class="activeGrowth > 0 ? 'el-icon-top' : 'el-icon-bottom'"></i>
                        </span>
                    </div>
                    <div class="card-footer">占总用户{{ activeRate }}%</div>
                </el-card>
            </el-col>
            <el-col :span="6">
                <el-card shadow="hover" class="data-card">
                    <div class="card-title">今日新增用户</div>
                    <div class="card-content">
                        <span class="card-value">{{ newUsers }}</span>
                        <span class="card-trend" :class="newGrowth > 0 ? 'up' : 'down'">
                            {{ newGrowth > 0 ? '+' : '' }}{{ newGrowth }}%
                            <i :class="newGrowth > 0 ? 'el-icon-top' : 'el-icon-bottom'"></i>
                        </span>
                    </div>
                    <div class="card-footer">与昨日相比</div>
                </el-card>
            </el-col>
            <el-col :span="6">
                <el-card shadow="hover" class="data-card">
                    <div class="card-title">系统访问量</div>
                    <div class="card-content">
                        <span class="card-value">{{ visitCount }}</span>
                        <span class="card-trend" :class="visitGrowth > 0 ? 'up' : 'down'">
                            {{ visitGrowth > 0 ? '+' : '' }}{{ visitGrowth }}%
                            <i :class="visitGrowth > 0 ? 'el-icon-top' : 'el-icon-bottom'"></i>
                        </span>
                    </div>
                    <div class="card-footer">日均访问量</div>
                </el-card>
            </el-col>
        </el-row>

        <!-- 主要图表区域 -->
        <el-row :gutter="20" style="margin-top: 20px;">
            <!-- 左侧图表和数据区域 -->
            <el-col :span="16">
                <el-card shadow="hover">
                    <div slot="header" class="clearfix">
                        <span>用户增长趋势</span>
                        <el-select v-model="userChartTimeRange" size="mini" style="float: right; width: 120px;">
                            <el-option label="近7天" value="7"></el-option>
                            <el-option label="近30天" value="30"></el-option>
                            <el-option label="近365天" value="365"></el-option>
                        </el-select>
                    </div>
                    <LineChart height="290px" tag="用户增长" @on-selected="userDatesSelected" :values="userValues"
                        :date="userDates" />
                </el-card>

                <el-card shadow="hover" style="margin-top: 20px;">
                    <div slot="header" class="clearfix">
                        <span>健康指标数据</span>
                        <el-select v-model="modelChartTimeRange" size="mini" style="float: right; width: 120px;">
                            <el-option label="近7天" value="7"></el-option>
                            <el-option label="近30天" value="30"></el-option>
                            <el-option label="近365天" value="365"></el-option>
                        </el-select>
                    </div>
                    <LineChart height="290px" tag="健康指标" @on-selected="modelDatesSelected" :values="modelValues"
                        :date="modelDates" />
                </el-card>

                <!-- 内容互动数据表格 -->
                <el-card shadow="hover" style="margin-top: 20px;">
                    <div slot="header" class="clearfix">
                        <span>内容互动数据</span>
                        <el-radio-group v-model="contentDataType" size="mini" style="float: right;">
                            <el-radio-button label="article">文章</el-radio-button>
                            <el-radio-button label="video">视频</el-radio-button>
                            <el-radio-button label="search">搜索</el-radio-button>
                        </el-radio-group>
                    </div>
                    
                    <!-- 阅读量TOP10表格 -->
                    <div v-if="contentDataType === 'article' || contentDataType === 'video'">
                        <el-table :data="topContentList" style="width: 100%" size="small" height="350">
                            <el-table-column type="index" width="50" label="排名"></el-table-column>
                            <el-table-column prop="title" label="标题" show-overflow-tooltip></el-table-column>
                            <el-table-column prop="viewCount" label="阅读量" width="100" sortable></el-table-column>
                            <el-table-column prop="likeCount" label="点赞" width="80"></el-table-column>
                            <el-table-column prop="commentCount" label="评论" width="80"></el-table-column>
                            <el-table-column prop="interactionRate" label="互动率" width="100">
                                <template slot-scope="scope">
                                    <el-progress :percentage="scope.row.interactionRate" :color="getInteractionColor(scope.row.interactionRate)"></el-progress>
                                </template>
                            </el-table-column>
                        </el-table>
                        
                        <!-- 互动量统计图表 -->
                        <div class="interaction-summary">
                            <div class="stat-item">
                                <div class="stat-number">{{totalViews}}</div>
                                <div class="stat-label">总浏览量</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">{{totalLikes}}</div>
                                <div class="stat-label">总点赞</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">{{totalComments}}</div>
                                <div class="stat-label">总评论</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">{{avgInteractionRate}}%</div>
                                <div class="stat-label">平均互动率</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 热门搜索词云图 -->
                    <div v-if="contentDataType === 'search'" class="search-cloud-container">
                        <div ref="wordCloudChart" style="width: 100%; height: 350px;"></div>
                    </div>
                </el-card>
            </el-col>

            <!-- 右侧饼图和数据区域 -->
            <el-col :span="8">
                <el-card shadow="hover">
                    <div slot="header" class="clearfix">
                        <span>用户分布</span>
                    </div>
                    <PieChart fontColor="rgb(51,51,51)" bag="rgb(248,248,248)" :values="pieValues" :types="pieTypes" />
                </el-card>

                <!-- 健康数据统计卡片 -->
                <el-card shadow="hover" style="margin-top: 20px;">
                    <div slot="header" class="clearfix">
                        <span>健康风险预警</span>
                    </div>
                    <div class="health-risk-container">
                        <div class="risk-item">
                            <el-progress type="dashboard" :percentage="bmiAbnormalRate" :color="healthStatusColors"></el-progress>
                            <div class="risk-label">BMI超标率</div>
                        </div>
                        <div class="risk-item">
                            <el-progress type="dashboard" :percentage="bloodPressureAbnormalRate" :color="healthStatusColors"></el-progress>
                            <div class="risk-label">血压异常率</div>
                        </div>
                        <div class="risk-item">
                            <el-progress type="dashboard" :percentage="bloodSugarAbnormalRate" :color="healthStatusColors"></el-progress>
                            <div class="risk-label">血糖异常率</div>
                        </div>
                    </div>
                    <div class="high-risk-alert" v-if="highRiskUserCount > 0">
                        <i class="el-icon-warning"></i>
                        <span>{{ highRiskUserCount }}位用户健康指标异常，需关注</span>
                        <el-button size="mini" type="text">导出名单</el-button>
                    </div>
                </el-card>

                <!-- 系统状态卡片 -->
                <el-card shadow="hover" style="margin-top: 20px;">
                    <div slot="header" class="clearfix">
                        <span>系统状态</span>
                    </div>
                    <div class="system-status">
                        <div class="status-item">
                            <div class="status-label">CPU使用率</div>
                            <el-progress :percentage="cpuUsage" :color="systemStatusColors"></el-progress>
                        </div>
                        <div class="status-item">
                            <div class="status-label">内存占用</div>
                            <el-progress :percentage="memoryUsage" :color="systemStatusColors"></el-progress>
                        </div>
                        <div class="status-item">
                            <div class="status-label">接口成功率</div>
                            <el-progress :percentage="apiSuccessRate" :color="systemStatusColors"></el-progress>
                        </div>
                    </div>
                </el-card>

                <!-- 通知消息面板 -->
                <el-card shadow="hover" style="margin-top: 20px;">
                    <div slot="header" class="clearfix">
                        <span>最新通知</span>
                    </div>
                    <div class="message-list">
                        <div v-for="(message,index) in messageList" :key="index" class="message-item">
                            <div class="message-title">{{ message.receiverName }}</div>
                            <div class="message-content">{{ parseText(message.content) }}</div>
                            <div class="message-time">{{ message.createTime }}</div>
                            <el-divider v-if="index < messageList.length - 1"></el-divider>
                        </div>
                        <div v-if="messageList.length === 0" class="no-data">
                            暂无通知消息
                        </div>
                    </div>
                </el-card>
            </el-col>
        </el-row>
    </div>
</template>
<script>
import LineChart from "@/components/LineChart"
import PieChart from "@/components/PieChart"
import { timeAgo } from "@/utils/data"
import * as echarts from 'echarts'
// 注意：在实际项目中需要安装echarts-wordcloud插件
// npm install echarts-wordcloud
// 这里模拟已安装，如果实际运行时需要确保已安装此插件
// import 'echarts-wordcloud'

export default {
    components: { LineChart, PieChart },
    data() {
        return {
            // 图表数据
            userValues: [],
            userDates: [],
            modelDates: [],
            modelValues: [],
            pieValues: [],
            pieTypes: [],
            messageList: [],
            
            // 时间范围控制
            userChartTimeRange: '365',
            modelChartTimeRange: '365',
            
            // 用户概览数据
            totalUsers: 0,
            userGrowth: 0,
            activeUsers: 0,
            activeGrowth: 0,
            activeRate: 0,
            newUsers: 0,
            newGrowth: 0,
            visitCount: 0,
            visitGrowth: 0,
            
            // 健康指标数据
            bmiAbnormalRate: 25,
            bloodPressureAbnormalRate: 18,
            bloodSugarAbnormalRate: 15,
            highRiskUserCount: 28,
            
            // 系统状态数据
            cpuUsage: 35,
            memoryUsage: 48,
            apiSuccessRate: 99.5,
            
            // 颜色配置
            healthStatusColors: [
                {color: '#67c23a', percentage: 20},
                {color: '#e6a23c', percentage: 50},
                {color: '#f56c6c', percentage: 100},
            ],
            systemStatusColors: [
                {color: '#67c23a', percentage: 60},
                {color: '#e6a23c', percentage: 80},
                {color: '#f56c6c', percentage: 100}
            ],
            contentDataType: 'article',
            topContentList: [],
            totalViews: 0,
            totalLikes: 0,
            totalComments: 0,
            avgInteractionRate: 0
        }
    },
    created() {
        // 加载仪表盘数据
        this.loadDashboardData();
        // 加载用户增长图表数据
        this.userDatesSelected(this.userChartTimeRange);
        // 加载健康指标图表数据
        this.modelDatesSelected(this.modelChartTimeRange);
        // 加载用户分布数据
        this.loadPieCharts();
        // 加载消息列表
        this.loadMessages();
        // 加载内容互动数据
        this.loadContentInteractionData();
    },
    mounted() {
        // 如果初始内容类型是search，则初始化词云图
        if (this.contentDataType === 'search') {
            this.$nextTick(() => {
                this.initWordCloud();
            });
        }
    },
    watch: {
        userChartTimeRange(val) {
            this.userDatesSelected(val);
        },
        modelChartTimeRange(val) {
            this.modelDatesSelected(val);
        },
        contentDataType(val) {
            this.loadContentInteractionData();
            if (val === 'search') {
                this.$nextTick(() => {
                    this.initWordCloud();
                });
            }
        }
    },
    methods: {
        // 加载仪表盘统计数据
        loadDashboardData() {
            // 这里应该调用实际的API获取数据
            // 目前使用模拟数据
            this.totalUsers = 2548;
            this.userGrowth = 5.2;
            this.activeUsers = 986;
            this.activeGrowth = 2.8;
            this.activeRate = Math.round((this.activeUsers / this.totalUsers) * 100);
            this.newUsers = 35;
            this.newGrowth = -2.1;
            this.visitCount = 1286;
            this.visitGrowth = 8.3;
            
            // 可以用实际API替换
            // this.$axios.get('/dashboard/stats').then(response => {
            //     const { data } = response;
            //     if (data.code === 200) {
            //         const stats = data.data;
            //         this.totalUsers = stats.totalUsers;
            //         // ... 设置其他统计数据
            //     }
            // });
        },
        parseText(text) {
            // 使用正则表达式判断文本是否符合由分号分隔且至少有三项的结构
            const pattern = /^([^;]+;){2}[^;]+$/;
            if (pattern.test(text)) {
                // 使用分号分割文本
                const parts = text.split(';');
                // 返回第三项内容
                return parts[2];
            }
            // 若不满足条件则返回原文本
            return text;
        },
        time(createTime) {
            return timeAgo(createTime);
        },
        // 加载资讯
        loadMessages () {
            const messageQueryDto = {
                current: 1,
                size: 4
            }
            this.$axios.post(`/message/query`, messageQueryDto).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.messageList = data.data;
                }
            })
        },
        loadPieCharts() {
            this.$axios.get(`/views/staticControls`).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.pieValues = data.data.map(entity => entity.count);
                    this.pieTypes = data.data.map(entity => entity.name);
                }
            })
        },
        modelDatesSelected(time) {
            this.$axios.get(`/user-health/daysQuery/${time}`).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.modelValues = data.data.map(entity => entity.count);
                    this.modelDates = data.data.map(entity => entity.name);
                }
            })
        },
        userDatesSelected(time) {
            this.$axios.get(`/user/daysQuery/${time}`).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.userValues = data.data.map(entity => entity.count);
                    this.userDates = data.data.map(entity => entity.name);
                }
            })
        },
        getInteractionColor(interactionRate) {
            if (interactionRate < 20) {
                return '#67c23a';
            } else if (interactionRate < 50) {
                return '#e6a23c';
            } else {
                return '#f56c6c';
            }
        },
        loadContentInteractionData() {
            // 根据内容类型加载不同的数据
            if (this.contentDataType === 'article' || this.contentDataType === 'video') {
                // 模拟从API获取数据
                // 实际使用时应该调用真实API
                // this.$axios.get(`/content/interaction/${this.contentDataType}`).then(response => {
                //     const { data } = response;
                //     if (data.code === 200) {
                //         this.topContentList = data.data.list;
                //         this.totalViews = data.data.totalViews;
                //         this.totalLikes = data.data.totalLikes;
                //         this.totalComments = data.data.totalComments;
                //         this.avgInteractionRate = data.data.avgInteractionRate;
                //     }
                // });

                // 模拟数据
                const contentType = this.contentDataType === 'article' ? '文章' : '视频';
                this.topContentList = [
                    { title: `健康${contentType}1：每日饮食指南`, viewCount: 1532, likeCount: 326, commentCount: 58, interactionRate: 25 },
                    { title: `健康${contentType}2：减肥运动计划`, viewCount: 1423, likeCount: 298, commentCount: 45, interactionRate: 24 },
                    { title: `健康${contentType}3：血压管理方法`, viewCount: 1287, likeCount: 267, commentCount: 39, interactionRate: 23 },
                    { title: `健康${contentType}4：糖尿病饮食控制`, viewCount: 1156, likeCount: 234, commentCount: 41, interactionRate: 24 },
                    { title: `健康${contentType}5：心脏保健指南`, viewCount: 1078, likeCount: 213, commentCount: 36, interactionRate: 23 },
                    { title: `健康${contentType}6：睡眠质量提升`, viewCount: 986, likeCount: 178, commentCount: 32, interactionRate: 21 },
                    { title: `健康${contentType}7：颈椎病防治`, viewCount: 876, likeCount: 165, commentCount: 28, interactionRate: 22 },
                    { title: `健康${contentType}8：眼部健康保护`, viewCount: 754, likeCount: 142, commentCount: 25, interactionRate: 22 },
                    { title: `健康${contentType}9：肠胃健康调理`, viewCount: 687, likeCount: 121, commentCount: 19, interactionRate: 20 },
                    { title: `健康${contentType}10：心理健康维护`, viewCount: 621, likeCount: 112, commentCount: 17, interactionRate: 21 }
                ];

                // 计算总和
                this.totalViews = this.topContentList.reduce((sum, item) => sum + item.viewCount, 0);
                this.totalLikes = this.topContentList.reduce((sum, item) => sum + item.likeCount, 0);
                this.totalComments = this.topContentList.reduce((sum, item) => sum + item.commentCount, 0);
                
                // 计算平均互动率
                const totalInteractionRate = this.topContentList.reduce((sum, item) => sum + item.interactionRate, 0);
                this.avgInteractionRate = Math.round(totalInteractionRate / this.topContentList.length);
            } else if (this.contentDataType === 'search') {
                // 对于搜索词云，我们只需准备数据
                // 词云图会在watch中触发initWordCloud方法
            }
        },
        initWordCloud() {
            // 使用导入的echarts
            // 模拟搜索关键词数据
            // 实际使用时应该从API获取
            const searchWords = [
                { name: '减肥', value: 10000 },
                { name: '血压', value: 8500 },
                { name: '糖尿病', value: 8000 },
                { name: '健康饮食', value: 7800 },
                { name: '运动计划', value: 7500 },
                { name: '心脏健康', value: 7300 },
                { name: '睡眠质量', value: 6800 },
                { name: '颈椎病', value: 6500 },
                { name: '眼部保健', value: 6300 },
                { name: '肠胃健康', value: 6000 },
                { name: '心理健康', value: 5800 },
                { name: '瑜伽', value: 5500 },
                { name: '低碳水饮食', value: 5300 },
                { name: '高血脂', value: 5000 },
                { name: '健步走', value: 4800 },
                { name: '水果蔬菜', value: 4500 },
                { name: '蛋白质摄入', value: 4300 },
                { name: '维生素', value: 4000 },
                { name: '骨质疏松', value: 3800 },
                { name: '体重管理', value: 3500 }
            ];

            try {
                // 初始化词云图
                const chartDom = this.$refs.wordCloudChart;
                if (chartDom) {
                    const myChart = echarts.init(chartDom);
                    
                    // 注意：以下是模拟词云图的配置
                    // 实际使用时请确保echarts-wordcloud插件已正确安装
                    // 由于词云图插件需要单独安装，这里使用饼图替代模拟词云效果
                    const option = {
                        title: {
                            text: '热门健康搜索词',
                            left: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: '{a} <br/>{b} : {c} ({d}%)'
                        },
                        series: [
                            {
                                name: '搜索热词',
                                type: 'pie',
                                radius: '60%',
                                center: ['50%', '50%'],
                                data: searchWords.map(item => ({
                                    name: item.name,
                                    value: item.value
                                })),
                                emphasis: {
                                    itemStyle: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                },
                                label: {
                                    show: true,
                                    formatter: '{b}'
                                }
                            }
                        ]
                    };
                    
                    myChart.setOption(option);
                    
                    // 处理窗口调整大小
                    window.addEventListener('resize', function() {
                        myChart.resize();
                    });
                }
            } catch (error) {
                console.error('初始化词云图出错:', error);
            }
        }
    },
};
</script>
<style scoped lang="scss">
.data-overview {
    .data-card {
        height: 120px;
        margin-bottom: 10px;
        
        .card-title {
            font-size: 14px;
            color: #606266;
            margin-bottom: 15px;
        }
        
        .card-content {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            margin-bottom: 10px;
            
            .card-value {
                font-size: 28px;
                font-weight: bold;
                color: #303133;
            }
            
            .card-trend {
                font-size: 14px;
                padding: 2px 5px;
                border-radius: 4px;
                
                &.up {
                    color: #67c23a;
                    background-color: rgba(103, 194, 58, 0.1);
                }
                
                &.down {
                    color: #f56c6c;
                    background-color: rgba(245, 108, 108, 0.1);
                }
            }
        }
        
        .card-footer {
            font-size: 12px;
            color: #909399;
        }
    }
}

.health-risk-container {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    
    .risk-item {
        text-align: center;
        
        .risk-label {
            margin-top: 10px;
            font-size: 14px;
            color: #606266;
        }
    }
}

.high-risk-alert {
    padding: 10px;
    background-color: #fdf6ec;
    border-radius: 4px;
    color: #e6a23c;
    display: flex;
    align-items: center;
    
    i {
        margin-right: 5px;
        font-size: 16px;
    }
    
    span {
        flex: 1;
    }
}

.system-status {
    .status-item {
        margin-bottom: 15px;
        
        .status-label {
            margin-bottom: 5px;
            font-size: 14px;
            color: #606266;
        }
    }
}

.message-list {
    max-height: 250px;
    overflow-y: auto;
    
    .message-item {
        margin-bottom: 10px;
        
        .message-title {
            font-size: 16px;
            font-weight: 600;
            color: #303133;
            margin-bottom: 5px;
        }
        
        .message-content {
            font-size: 14px;
            color: #606266;
            margin-bottom: 5px;
            line-height: 1.4;
        }
        
        .message-time {
            font-size: 12px;
            color: #909399;
        }
    }
    
    .no-data {
        text-align: center;
        color: #909399;
        padding: 20px 0;
    }
}

.clearfix:after {
    clear: both;
    content: ".";
    display: block;
    height: 0;
    visibility: hidden;
}

.el-card {
    margin-bottom: 10px;
}

.interaction-summary {
    display: flex;
    justify-content: space-between;
    margin-top: 10px;
    
    .stat-item {
        text-align: center;
        
        .stat-number {
            font-size: 24px;
            font-weight: bold;
            color: #303133;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 14px;
            color: #909399;
        }
    }
}

.search-cloud-container {
    margin-top: 10px;
}
</style>