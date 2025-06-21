<template>
  <div class="health-app-container">
    <!-- 主内容区域 -->
    <div class="main-content">
      <!-- 左侧记录面板（包含饮食记录和健康计划） -->
      <div class="record-panel">
        <!-- 饮食记录部分 -->
        <div class="panel-header">
          <h2><i class="el-icon-notebook-2"></i> 今日饮食记录</h2>
          <el-button 
            type="primary" 
            size="small" 
            icon="el-icon-plus" 
            @click="recordGourmet"
            class="add-button">
            新增记录
          </el-button>
        </div>

        <!-- 添加记录卡片 -->
        <div 
          class="empty-record-card" 
          v-if="dietHitoryList.length === 0"
          @click="recordGourmet">
          <div class="empty-content">
            <i class="el-icon-upload"></i>
            <p>点击添加今日第一条饮食记录</p>
          </div>
        </div>

        <!-- 记录列表 -->
        <div class="record-list" v-else>
          <div 
            class="record-item"
            v-for="(dietHistory, index) in dietHitoryList" 
            :key="index"
            :style="{'background-color': getRandomPastelColor(index)}">
            <div class="food-info">
              <div class="food-name">{{ getCookbookName(dietHistory) }}</div>
              <div class="food-detail">
                <span>{{ dietHistory.detail || '无备注' }}</span>
                <span class="food-quantity">{{ dietHistory.value }}g</span>
              </div>
            </div>
            <div class="action-buttons">
              <el-button 
                size="mini" 
                circle 
                icon="el-icon-close" 
                @click.stop="removeCookbook(dietHistory)"
                class="delete-btn">
              </el-button>
            </div>
          </div>

          <div class="submit-section">
            <el-button 
              type="success" 
              size="medium" 
              icon="el-icon-check" 
              @click="record" 
              :disabled="dietHitoryList.length === 0"
              class="submit-btn">
              提交今日记录
            </el-button>
          </div>
        </div>
        <div class="recipe-recommendation-card">
          <div class="panel-header">
            <h3><i class="el-icon-food"></i> 地区季节食谱推荐</h3>
          </div>
          
          <div class="recommendation-controls">
            <el-select 
              v-model="selectedRegion" 
              placeholder="选择地区" 
              size="small"
              @change="fetchSeasons">
              <el-option
                v-for="region in regions"
                :key="region.id"
                :label="region.name"
                :value="region.id">
              </el-option>
            </el-select>
            
            <el-select 
              v-model="selectedSeason" 
              placeholder="选择季节" 
              size="small"
              :disabled="!selectedRegion">
              <el-option
                v-for="season in seasons"
                :key="season.id"
                :label="season.name"
                :value="season.id">
              </el-option>
            </el-select>
            
            <el-button 
              type="primary" 
              size="small"
              @click="getRecommendations"
              :disabled="!selectedRegion || !selectedSeason">
              获取推荐
            </el-button>
          </div>
          
          <div v-if="recommendations.length > 0" class="recommendation-results">
            <div class="meal-section" v-for="meal in groupedRecommendations" :key="meal.type">
              <h4>{{ getMealTypeName(meal.type) }}</h4>
              <div class="meal-recommendations">
                <el-card 
                  v-for="recipe in meal.recipes" 
                  :key="recipe.id"
                  class="recipe-card"
                  shadow="hover"
                  @click.native="addToDiet(recipe)">
                  <div class="recipe-content">
                    <img :src="recipe.image || defaultFoodImage" class="recipe-image">
                    <div class="recipe-info">
                      <div class="recipe-name">{{ recipe.name }}</div>
                      <div class="recipe-desc">{{ recipe.description }}</div>
                    </div>
                  </div>
                </el-card>
              </div>
            </div>
          </div>
          
          <div v-else class="empty-recommendation">
            <i class="el-icon-info"></i>
            <p>请选择地区和季节获取推荐食谱</p>
          </div>
        </div>

        <!-- 健康计划模块 -->
        <div class="health-plan-card">
          <div class="panel-header">
            <h3><i class="el-icon-aim"></i> 今日健康目标</h3>
            <el-button 
              type="text" 
              size="mini" 
              @click="navigateToHealthPlan"
              class="view-all-btn">
              查看全部
            </el-button>
          </div>
          
          <div v-if="latestHealthPlan" class="plan-details">
            <div class="plan-metric">
              <div class="metric-icon">
                <i class="el-icon-fire"></i>
              </div>
              <div class="metric-info">
                <div class="metric-value">{{ latestHealthPlan.targetCalories }} kcal</div>
                <div class="metric-label">目标热量</div>
              </div>
            </div>
            
            <div class="plan-metric">
              <div class="metric-icon">
                <i class="el-icon-bicycle"></i>
              </div>
              <div class="metric-info">
                <div class="metric-value">{{ latestHealthPlan.exerciseMinutes }} 分钟</div>
                <div class="metric-label">运动目标</div>
              </div>
            </div>
            
            <div class="plan-metric">
              <div class="metric-icon">
                <i class="el-icon-data-analysis"></i>
              </div>
              <div class="metric-info">
                <div class="metric-value">{{ latestHealthPlan.exerciseType }}</div>
                <div class="metric-label">运动方式</div>
              </div>
            </div>
            
            <div class="plan-metric">
              <div class="metric-icon">
                <i class="el-icon-stopwatch"></i>
              </div>
              <div class="metric-info">
                <div class="metric-value">{{ latestHealthPlan.caloriesBurned }} kcal</div>
                <div class="metric-label">消耗热量</div>
              </div>
            </div>
          </div>
          
          <div v-else class="empty-plan">
            <i class="el-icon-warning-outline"></i>
            <p>尚未设置健康计划</p>
            <el-button 
              type="text" 
              size="mini" 
              @click="navigateToHealthPlan"
              class="setup-btn">
              立即设置
            </el-button>
          </div>
        </div>
      </div>

      <!-- 右侧数据分析面板 -->
      <div class="analysis-panel">
        <!-- 历史记录 -->
        <div class="history-section">
          <div class="panel-header">
            <h2><i class="el-icon-data-line"></i> 饮食历史分析</h2>
            <div class="filter-controls">

            </div>
          </div>

          <el-table
            :data="tableData"
            style="width: 100%"
            stripe
            border
            class="compact-table"
            :header-cell-style="{background: '#f5f7fa', color: '#606266'}">
            <el-table-column 
              prop="cookbookCover" 
              label="封面" 
              width="80" 
              align="center">
              <template slot-scope="scope">
                <img :src="scope.row.cookbookCover" class="food-image" alt="食谱图片">
              </template>
            </el-table-column>
            <el-table-column 
              prop="cookbookTitle" 
              label="食谱名称" 
              width="150"
              show-overflow-tooltip>
            </el-table-column>
            <el-table-column 
              prop="detail" 
              label="备注" 
              width="100"
              show-overflow-tooltip>
            </el-table-column>
            <el-table-column 
              prop="value" 
              label="食用量" 
              width="90" 
              align="center">
              <template slot-scope="scope">
                <el-tag size="small">{{ scope.row.value }}g</el-tag>
              </template>
            </el-table-column>
            <el-table-column 
  prop="createTime" 
  label="记录时间" 
  width="140" 
  align="center">
  <template slot-scope="scope">
    {{ formatDate(scope.row.createTime) }}
  </template>
</el-table-column>
            <el-table-column 
              label="操作" 
              width="120" 
              align="center"
              fixed="right">
              <template slot-scope="scope">
                <el-button 
                  type="text"
                  size="mini" 
                  @click="handleEdit(scope.row)"
                  style="color: #409EFF;padding: 4px 0;font-size: 12px;">
                  修改
                </el-button>
                <el-popconfirm
                  title="确定删除这条记录吗？"
                  @confirm="handleDelete(scope.row)">
                  <el-button 
                    slot="reference" 
                    type="text"
                    size="mini" 
                    style="color: #409EFF;padding: 4px 0;font-size: 12px;">
                    删除
                  </el-button>
                </el-popconfirm>
              </template>
            </el-table-column>
          </el-table>

          <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="currentPage"
            :page-sizes="[10, 20, 50]"
            :page-size="pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="totalItems"
            class="pagination">
          </el-pagination>
        </div>

        <!-- 营养分析 -->
        <div class="nutrition-section">
          <div class="panel-header">
            <h2><i class="el-icon-pie-chart"></i> 营养摄入趋势</h2>
            <el-select
              v-model="dietQueryDto.nutrimentId"
              placeholder="选择营养素..."
              @change="loadNutrimentData"
              size="small"
              class="nutrient-select">
              <el-option
                v-for="item in nutrimentItems"
                :key="item.id"
                :label="item.name"
                :value="item.id">
              </el-option>
            </el-select>
          </div>

          <div class="chart-container">
            <LineChart
              tag="营养摄入趋势"
              height="300px"
              @on-selected="onSelected"
              :values="values"
              :date="dates"
              class="nutrition-chart"/>
          </div>
        </div>
      </div>
    </div>

    <!-- 添加/编辑对话框 -->
    <el-dialog
  :show-close="false"
  :visible.sync="dialogDietOperaion"
  width="40%"
  center>
  <div style="padding:16px 20px;">
    <p>{{ data.id ? '编辑饮食记录' : '添加饮食记录' }}</p>
    
    <div style="margin-block: 10px;">
      <span class="dialog-hover">食谱选择</span>
      <el-select
        v-model="dieHistory.cookbookId"
        placeholder="请选择食谱"
        filterable
        style="width: 100%;">
        <el-option
          v-for="item in cookbooks"
          :key="item.id"
          :label="item.name"
          :value="item.id">
          <div style="display: flex; align-items: center;">
            <img :src="item.cover" style="width: 30px; height: 30px; margin-right: 10px; border-radius: 4px;">
            <span>{{ item.name }}</span>
          </div>
        </el-option>
      </el-select>
    </div>
    
    <div style="margin-block: 10px;">
      <span class="dialog-hover">备注信息</span>
      <el-input
        type="textarea"
        :rows="3"
        placeholder="请输入备注（可选）"
        v-model="dieHistory.detail"
        style="width: 100%;">
      </el-input>
    </div>
    
    <div style="margin-block: 10px;">
      <span class="dialog-hover">食用量</span>
      <el-input-number
        v-model="dieHistory.value"
        :min="1"
        :max="1000"
        :step="10"
        controls-position="right"
        placeholder="请输入食用量"
        style="width: 200px;">
      </el-input-number>
    </div>
  </div>
  
  <span slot="footer" class="dialog-footer" style="margin-top: 10px;">
    <span class="channel-button" @click="cannel">
      取消操作
    </span>
    <span class="edit-button" @click="data.id ? updateOperation() : addOperation()">
      确 定
    </span>
  </span>
</el-dialog>
  </div>
</template>

<script>
import LineChart from "@/components/LineChart";

export default {
  name: "DietHistory",
  components: { LineChart },
  data() {
    return {
      dieHistory: {},
      dialogDietOperaion: false,
      cookbooks: [],
      dietHitoryList: [],
      data: {},
      filterText: '',
      currentPage: 1,
      pageSize: 20,
      totalItems: 0,
      dietQueryDto: { day: 365 },
      tableData: [],
      delectedRows: [],
      searchTime: [],
      dietHistoryQueryDto: {},
      nutrimentUseList: [],
      values: [],
      dates: [],
      nutrimentItems: [],
      latestHealthPlan: null, // 新增的健康计划数据
      pastelColors: [
        '#FFD3B6', '#DCEDC1', '#A8E6CF', '#D4E4F7', 
        '#E3C1FF', '#FFC8DD', '#B5EAD7', '#C7CEEA'
      ],
      selectedRegion: null,
      selectedSeason: null,
      regions: [],
      seasons: [],
      recommendations: [],
      defaultFoodImage: 'https://via.placeholder.com/60x60?text=Food',
      mealTypes: {
        1: '早餐',
        2: '午餐',
        3: '晚餐'
      }
    };
  },
  computed: {
    groupedRecommendations() {
      const grouped = {};
      this.recommendations.forEach(recipe => {
        if (!grouped[recipe.mealType]) {
          grouped[recipe.mealType] = {
            type: recipe.mealType,
            recipes: []
          };
        }
        grouped[recipe.mealType].recipes.push(recipe);
      });
      return Object.values(grouped);
    }
  },
  created() {
    this.fetchFreshData();
    this.fetchCookbookList();
    this.loadNutrimentData();
    this.fetchNutrimentListItem();
    this.fetchLatestHealthPlan(); // 新增：获取最新健康计划
    this.fetchRegions();
  },
  methods: {
    fetchRegions() {
      this.$axios.get('/recipes/regions').then(res => {
        this.regions = res.data.data;
      }).catch(error => {
        console.error('获取地区列表失败:', error);
        this.$message.error('获取地区列表失败');
      });
    },
    
    fetchSeasons() {
      this.$axios.get('/recipes/seasons').then(res => {
        this.seasons = res.data.data;
        this.selectedSeason = null;
      }).catch(error => {
        console.error('获取季节列表失败:', error);
        this.$message.error('获取季节列表失败');
      });
    },
    
    getRecommendations() {
      const params = {
        regionId: this.selectedRegion,
        seasonId: this.selectedSeason
      };
      this.$axios.post('/recipes/query', params).then(res => {
        this.recommendations = res.data.data;
            console.log('Received recommendations:', this.recommendations);
        this.$message.success('已获取推荐食谱');
      }).catch(error => {
        console.error('获取推荐食谱失败:', error);
        this.$message.error('获取推荐食谱失败');
      });
    },
    
    getMealTypeName(type) {
      return this.mealTypes[type] || '未知餐型';
    },
    
    addToDiet(recipe) {
      this.dieHistory = {
        cookbookId: recipe.id,
        detail: `${recipe.name} (${recipe.description})`,
        value: 200 // 默认200克
      };
      this.dialogDietOperaion = true;
    },

    // 新增方法：获取最新健康计划
    async fetchLatestHealthPlan() {
      try {
        const response = await this.$axios.get('/health-plans/latest');
        this.latestHealthPlan = response.data.data;
      } catch (error) {
        console.error('获取健康计划失败:', error);
      }
    },
    formatDate(date) {
    if (!date) return '';
    const d = new Date(date);
    const year = d.getFullYear();
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  },
    
    // 新增方法：导航到健康计划页面
    navigateToHealthPlan() {
      this.$router.push('/daily-health');
    },
    
    getRandomPastelColor(index) {
      return this.pastelColors[index % this.pastelColors.length];
    },
    async fetchNutrimentListItem() {
      try {
        const response = await this.$axios.get(`/nutriment/querySelectedItemsUser`);
        if (response.data.code === 200) {
          this.nutrimentItems = response.data.data;
        }
      } catch (error) {
        console.log(error);
      }
    },
    onSelected(day) {
      this.dietQueryDto.day = day;
      this.loadNutrimentData();
    },
    record() {
      this.$axios.post(`/dietHistory/save`, this.dietHitoryList).then(res => {
        const { data } = res;
        if (data.code === 200) {
          this.$notify({
            title: '记录成功',
            message: '今日饮食记录已保存',
            type: 'success',
            duration: 2000,
            customClass: 'success-notification'
          });
          this.dietHitoryList = [];
          this.fetchFreshData();
        }
      }).catch(error => {
        console.log("新增饮食信息异常：", error);
      })
    },
    removeCookbook(dieHistory) {
      this.dietHitoryList = this.dietHitoryList.filter(entity => entity.cookbookId !== dieHistory.cookbookId);
      this.$message({
        message: '已移除该饮食记录',
        type: 'info',
        duration: 1500
      });
    },
    getCookbookName(dieHistory) {
      const cookbook = this.cookbooks.find(entity => entity.id === dieHistory.cookbookId);
      return cookbook ? cookbook.name : '未知食谱';
    },
    fetchCookbookList() {
      this.$axios.get(`/cookbook/querySelectedItemsAll`).then(res => {
        const { data } = res;
        if (data.code === 200) {
          this.cookbooks = data.data;
        }
      }).catch(error => {
        console.log("查询食谱信息异常：", error);
      })
    },
   addOperation() {
    // 验证必填字段
    if (!this.dieHistory.cookbookId || !this.dieHistory.value) {
        this.$notify({
            duration: 1000,
            title: '饮食记录',
            message: '请填写所有必填字段（食谱和食用量）',
            type: 'error'
        });
        return;
    }
    
    this.dietHitoryList.push(this.dieHistory);
    this.cannel();
    this.$message({
        message: '饮食记录已添加',
        type: 'success',
        duration: 1500
    });
},
    cannel() {
      this.dieHistory = {};
      this.data = {};
      this.dialogDietOperaion = false;
    },
    recordGourmet() {
      this.dieHistory = {};
      this.dialogDietOperaion = true;
    },
    async fetchFreshData() {
      try {
        let startTime = null;
        let endTime = null;
        if (this.searchTime != null && this.searchTime.length === 2) {
          const [startDate, endDate] = await Promise.all(this.searchTime.map(date => date.toISOString()));
          startTime = `${startDate.split('T')[0]}T00:00:00`;
          endTime = `${endDate.split('T')[0]}T23:59:59`;
        }
        
        const params = {
          current: this.currentPage,
          size: this.pageSize,
          key: this.filterText,
          startTime: startTime,
          endTime: endTime,
          ...this.dietHistoryQueryDto
        };
        
        const response = await this.$axios.post('/dietHistory/queryUser', params);
        const { data } = response;
        this.tableData = data.data;
        this.totalItems = data.total;
      } catch (error) {
        this.$message.error("获取饮食记录失败");
        console.error('获取饮食记录异常:', error);
      }
    },
    handleEdit(row) {
      this.data = { ...row };
      this.dieHistory = { ...row };
      this.dialogDietOperaion = true;
    },
    handleDelete(row) {
      this.delectedRows = [row];
      this.batchDelete();
    },
    async batchDelete() {
      try {
        let ids = this.delectedRows.map(entity => entity.id);
        const response = await this.$axios.post(`/dietHistory/batchDelete`, ids);
        if (response.data.code === 200) {
          this.$notify({
            title: '删除成功',
            message: '饮食记录已删除',
            type: 'success',
            duration: 2000,
            customClass: 'success-notification'
          });
          this.fetchFreshData();
        }
      } catch (error) {
        this.$message.error("删除饮食记录异常");
        console.error(`删除饮食记录异常：`, error);
      }
    },
    handleFilter() {
      this.currentPage = 1;
      this.fetchFreshData();
    },
    handleFilterClear() {
      this.filterText = '';
      this.handleFilter();
    },
    handleSizeChange(val) {
      this.pageSize = val;
      this.currentPage = 1;
      this.fetchFreshData();
    },
    handleCurrentChange(val) {
      this.currentPage = val;
      this.fetchFreshData();
    },
    loadNutrimentData() {
      this.$axios.post(`/dietHistory/queryDietNutrimentInfo`, this.dietQueryDto).then(res => {
        const { data } = res;
        if (data.code === 200) {
          this.nutrimentUseList = data.data;
          this.dates = this.nutrimentUseList.map(entity => entity.time);
          this.values = this.nutrimentUseList.map(entity => entity.value);
        }
      }).catch(error => {
        console.log("查询营养素摄入信息异常：", error);
      })
    }
  }
};
</script>

<style scoped lang="scss">
.health-app-container {
  background-color: #f8fafc;
  padding: 20px;
  min-height: calc(100vh - 40px);
  font-family: 'Helvetica Neue', Arial, sans-serif;
}

.main-content {
  display: flex;
  gap: 20px;
  max-width: 1400px;
  margin: 0 auto;
}

/* 左侧记录面板 */
.record-panel {
  flex: 1;
  min-width: 350px;
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  padding: 20px;
  height: fit-content;
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 1px solid #ebeef5;
  
  h2 {
    color: #303133;
    font-size: 18px;
    font-weight: 600;
    margin: 0;
    display: flex;
    align-items: center;
    
    i {
      margin-right: 10px;
      color: #409EFF;
      font-size: 20px;
    }
  }
}

.add-button {
  background: linear-gradient(135deg, #409EFF, #66b1ff);
  border: none;
  box-shadow: 0 2px 6px rgba(64, 158, 255, 0.3);
}

.empty-record-card {
  background-color: #f5f7fa;
  border: 2px dashed #dcdfe6;
  border-radius: 10px;
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s;
  
  &:hover {
    border-color: #409EFF;
    background-color: #ecf5ff;
    
    .empty-content {
      color: #409EFF;
    }
  }
  
  .empty-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    color: #909399;
    transition: all 0.3s;
    
    i {
      font-size: 40px;
      margin-bottom: 15px;
    }
    
    p {
      font-size: 16px;
      margin: 0;
    }
  }
}

.record-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.record-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px;
  border-radius: 8px;
  transition: all 0.3s;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  }
}

.food-info {
  flex: 1;
  
  .food-name {
    font-size: 16px;
    font-weight: 500;
    color: #303133;
    margin-bottom: 5px;
  }
  
  .food-detail {
    display: flex;
    justify-content: space-between;
    color: #909399;
    font-size: 14px;
    
    .food-quantity {
      color: #409EFF;
      font-weight: 300;
      margin-left: 10px;
    }
  }
}

.action-buttons {
  margin-left: 15px;
  
  .delete-btn {
    color: #f56c6c;
    background-color: rgba(245, 108, 108, 0.1);
    border: none;
    
    &:hover {
      background-color: rgba(245, 108, 108, 0.2);
    }
  }
}

.submit-section {
  margin-top: 20px;
  text-align: center;
  
  .submit-btn {
    width: 100%;
    background: linear-gradient(135deg, #67C23A, #85ce61);
    border: none;
    box-shadow: 0 2px 6px rgba(103, 194, 58, 0.3);
  }
}

/* 健康计划卡片样式 */
.health-plan-card {
  background: linear-gradient(135deg, #f6f9fc, #eef2f7);
  border-radius: 12px;
  padding: 20px;
  margin-top: 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
  border: 1px solid #ebeef5;
  
  .panel-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    
    h3 {
      color: #303133;
      font-size: 16px;
      font-weight: 600;
      margin: 0;
      display: flex;
      align-items: center;
      
      i {
        margin-right: 8px;
        color: #67C23A;
      }
    }
    
    .view-all-btn {
      color: #409EFF;
      padding: 4px 8px;
    }
  }
}

.plan-details {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 15px;
}

.plan-metric {
  display: flex;
  align-items: center;
  background: white;
  padding: 12px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  transition: all 0.3s;
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  }
  
  .metric-icon {
    width: 36px;
    height: 36px;
    background: linear-gradient(135deg, #f0f9eb, #e1f3d8);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 12px;
    
    i {
      color: #67C23A;
      font-size: 18px;
    }
  }
  
  .metric-info {
    flex: 1;
    
    .metric-value {
      font-size: 16px;
      font-weight: 600;
      color: #303133;
      margin-bottom: 2px;
    }
    
    .metric-label {
      font-size: 12px;
      color: #909399;
    }
  }
}

.empty-plan {
  text-align: center;
  padding: 20px;
  color: #909399;
  
  i {
    font-size: 40px;
    color: #E6A23C;
    margin-bottom: 10px;
    display: block;
  }
  
  p {
    margin: 8px 0 15px;
    font-size: 14px;
  }
  
  .setup-btn {
    color: #409EFF;
    font-size: 13px;
  }
}

/* 右侧分析面板 */
.analysis-panel {
  flex: 2;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.history-section {
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  padding: 20px;
}

.filter-controls {
  display: flex;
  gap: 10px;
  
  .date-picker {
    width: 280px;
  }
  
  .search-input {
    width: 220px;
  }
}

.compact-table {
  margin-top: 15px;
  border-radius: 8px;
  overflow: hidden;
  font-size: 13px;  
  
  .food-image {
    width: 50px;
    height: 50px;
    border-radius: 6px;
    object-fit: cover;
  }
  
  .el-table__body-wrapper {
    max-height: 400px;
    overflow-y: auto;
  }
  
  .el-button--text {
    font-size: 12px;  
  }
}
  
.pagination {
  margin-top: 20px;
  justify-content: flex-end;
}

.nutrition-section {
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  padding: 20px;
}

.nutrient-select {
  width: 200px;
}

.chart-container {
  margin-top: 10px;
  background-color: #fff;
  border-radius: 8px;
  padding: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

/* 对话框样式 */
.diet-dialog {
  .dialog-content {
    padding: 0 20px;
  }
  
  .form-item {
    margin-bottom: 20px;
    
    label {
      display: flex;
      align-items: center;
      margin-bottom: 8px;
      color: #606266;
      font-size: 14px;
      font-weight: 500;
      
      i {
        margin-right: 8px;
        font-size: 16px;
      }
    }
  }
  
  .full-width-select, .full-width-input {
    width: 100%;
  }
  
  .food-option {
    display: flex;
    align-items: center;
    
    .option-image {
      width: 30px;
      height: 30px;
      border-radius: 4px;
      margin-right: 10px;
      object-fit: cover;
    }
  }
  
  .dialog-footer {
    .cancel-btn {
      padding: 10px 20px;
    }
    
    .confirm-btn {
      padding: 10px 20px;
      background: linear-gradient(135deg, #409EFF, #66b1ff);
      border: none;
      box-shadow: 0 2px 6px rgba(64, 158, 255, 0.3);
    }
  }
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .main-content {
    flex-direction: column;
  }
  
  .record-panel, .analysis-panel {
    width: 100%;
  }
  
  .filter-controls {
    flex-direction: column;
    
    .date-picker, .search-input {
      width: 100%;
    }
  }
}

@media (max-width: 768px) {
  .plan-details {
    grid-template-columns: 1fr;
  }
}
</style>

<style>
/* 全局通知样式 */
.success-notification {
  background: linear-gradient(135deg, #67C23A, #85ce61) !important;
  color: white !important;
  border: none !important;
  box-shadow: 0 4px 12px rgba(103, 194, 58, 0.3) !important;
}

.el-notification__title, .el-notification__content {
  color: white !important;
}
.recipe-recommendation-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px;
  margin-top: 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  
  h3 {
    color: #303133;
    font-size: 16px;
    font-weight: 600;
    margin: 0;
    display: flex;
    align-items: center;
    
    i {
      margin-right: 8px;
      color: #67C23A;
    }
  }
}

.recommendation-controls {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
  
  .el-select {
    flex: 1;
  }
}

.recommendation-results {
  .meal-section {
    margin-bottom: 20px;
    
    h4 {
      color: #606266;
      font-size: 14px;
      margin-bottom: 10px;
      padding-left: 5px;
      border-left: 3px solid #67C23A;
    }
  }
}

.meal-recommendations {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 15px;
}

.recipe-card {
  cursor: pointer;
  transition: transform 0.3s;
  
  &:hover {
    transform: translateY(-3px);
  }
  
  .recipe-content {
    display: flex;
    align-items: center;
  }
}

.recipe-image {
  width: 60px;
  height: 60px;
  border-radius: 6px;
  object-fit: cover;
  margin-right: 12px;
}

.recipe-info {
  flex: 1;
  
  .recipe-name {
    font-size: 14px;
    font-weight: 500;
    margin-bottom: 4px;
    color: #303133;
  }
  
  .recipe-desc {
    font-size: 12px;
    color: #909399;
    line-height: 1.4;
  }
}

.empty-recommendation {
  text-align: center;
  padding: 30px;
  color: #909399;
  
  i {
    font-size: 40px;
    color: #E6A23C;
    margin-bottom: 10px;
    display: block;
  }
  
  p {
    margin: 8px 0 15px;
    font-size: 14px;
  }
}

@media (max-width: 768px) {
  .recommendation-controls {
    flex-direction: column;
  }
  
  .meal-recommendations {
    grid-template-columns: 1fr;
  }
}
</style>