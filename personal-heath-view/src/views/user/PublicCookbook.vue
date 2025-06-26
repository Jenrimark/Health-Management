<template>
    <el-row style="background-color: #FFFFFF;padding: 5px 0;border-radius: 5px;">
        <el-row style="padding: 10px;margin-left: 5px;">
            <el-row style="display: flex;justify-content: space-between;align-items: center;margin-bottom: 15px;">
                <div style="display: flex;gap: 12px;">
                    <button class="custom-button nutrition-search-btn" @click="showFoodNutrientSearch">
                        <i class="el-icon-food"></i>
                        <span>食物营养成分查询</span>
                    </button>
                    <button class="custom-button portion-calc-btn" @click="showPortionCalculator">
                        <i class="el-icon-pie-chart"></i>
                        <span>食物份量营养计算</span>
                    </button>
                </div>
                <div style="display: flex;gap: 15px;">
                    <el-select class="styled-select" style="width: 120px;" @change="fetchFreshData" size="small"
                        v-model="cookbookQueryDto.categoryId" placeholder="菜系">
                        <el-option v-for="item in categories" :key="item.id" :label="item.name" :value="item.id">
                        </el-option>
                    </el-select>
                    <el-date-picker class="styled-date-picker" style="width: 240px;" @change="fetchFreshData" size="small" v-model="searchTime"
                        type="daterange" range-separator="至" start-placeholder="发布开始" end-placeholder="发布结束">
                    </el-date-picker>
                    <el-input class="styled-input" size="small" style="width: 180px;" v-model="cookbookQueryDto.title" placeholder="美食名"
                        clearable @clear="handleFilterClear" @keyup.enter.native="handleFilter">
                    </el-input>
                </div>
            </el-row>
        </el-row>
        <el-row style="margin: 0 22px;border-top: 1px solid rgb(245,245,245);">
            <el-table :stripe="true" :data="tableData" style="width: 100%">
                <el-table-column prop="userAvatar" width="68" label="头像">
                    <template slot-scope="scope">
                        <el-avatar :size="25" :src="scope.row.userAvatar" style="margin-top: 10px;"></el-avatar>
                    </template>
                </el-table-column>
                <el-table-column prop="userName" label="发布者" width="118"></el-table-column>
                <el-table-column prop="title" label="食谱名"></el-table-column>
                <el-table-column prop="categoryName" label="所属类别" width="118"></el-table-column>
                <el-table-column prop="createTime" label="创建时间" :sortable="true" width="168"></el-table-column>
                <el-table-column label="操作" width="180">
                    <template slot-scope="scope">
                        <div class="operation-buttons">
                            <div class="button-row">
                                <span class="text-button" @click="viewDetail(scope.row)">详情</span>
                                <span class="text-button" @click="viewNutriments(scope.row)">营养素</span>
                            </div>
                            <div class="button-row" v-if="currentUserId && scope.row.userId === currentUserId">
                                <span class="text-button" @click="editCookbook(scope.row)">修改</span>
                                <span class="text-button" @click="deleteCookbook(scope.row)">删除</span>
                            </div>
                        </div>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination style="margin:10px 0;float: right;" @size-change="handleSizeChange"
                @current-change="handleCurrentChange" :current-page="currentPage" :page-sizes="[20, 50]"
                :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                :total="totalItems"></el-pagination>
        </el-row>
        
        <!-- 食谱详情弹窗 -->
        <el-dialog :visible.sync="dialogVisible" custom-class="cookbook-detail-dialog" width="65%">
            <div class="cookbook-detail-header">
                <h2 class="cookbook-detail-title">食谱详情</h2>
                <p class="cookbook-detail-subtitle">精选食谱内容与营养信息</p>
            </div>
            <div v-if="currentCookbook" class="cookbook-detail-container">
                <div class="cookbook-detail-info">
                    <img :src="currentCookbook.cover" class="cookbook-detail-cover" v-if="currentCookbook.cover">
                    <div class="cookbook-detail-meta">
                        <h3>{{currentCookbook.title}}</h3>
                        <div class="cookbook-meta-items">
                            <div class="cookbook-meta-item">
                                <i class="el-icon-menu"></i>
                                <span>{{currentCookbook.categoryName}}</span>
                            </div>
                            <div class="cookbook-meta-item">
                                <i class="el-icon-user"></i>
                                <span>{{currentCookbook.userName}}</span>
                            </div>
                            <div class="cookbook-meta-item">
                                <i class="el-icon-time"></i>
                                <span>{{currentCookbook.createTime}}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="cookbook-detail-content" v-html="currentCookbook.content"></div>
            </div>
        </el-dialog>

        <!-- 营养素弹窗 -->
        <el-dialog :visible.sync="nutrimentDialogVisible" custom-class="nutriment-dialog" width="65%">
            <div class="nutriment-header">
                <h2 class="nutriment-title">食谱营养素信息</h2>
                <p class="nutriment-subtitle">每100克食物的营养成分详情</p>
            </div>
            <div v-if="cookbookNutrimentList.length === 0" class="nutriment-empty">
                <el-empty description="该食谱暂无营养素信息"></el-empty>
            </div>
            <div v-else class="nutriment-container">
                <div class="nutriment-card" v-for="(item, index) in cookbookNutrimentList" :key="index">
                    <div class="nutriment-card-header">
                        <span class="nutriment-name">{{item.nutrimentName}}</span>
                    </div>
                    <div class="nutriment-card-body">
                        <div class="nutriment-value">{{item.g100Value}}<span class="nutriment-unit">{{item.nutrimentUnit}}</span></div>
                    </div>
                </div>
            </div>
        </el-dialog>

        <!-- 食物营养成分查询弹窗 -->
        <el-dialog :visible.sync="foodNutrientSearchVisible" custom-class="cookbook-detail-dialog" width="70%">
            <div class="cookbook-detail-header">
                <h2 class="cookbook-detail-title">食物营养成分查询</h2>
                <p class="cookbook-detail-subtitle">查询食物的详细营养成分信息</p>
            </div>
            <div class="food-nutrient-search-container">
                <div class="food-search-section">
                    <div class="food-search-form">
                        <el-form :inline="true" :model="foodSearchForm" class="search-form">
                            <el-form-item label="食物名称">
                                <el-autocomplete
                                    v-model="foodSearchForm.name"
                                    :fetch-suggestions="queryFoodSuggestions"
                                    placeholder="请输入食物名称"
                                    @select="handleFoodSelect"
                                    style="width: 250px"
                                    clearable>
                                </el-autocomplete>
                            </el-form-item>
                            <el-form-item>
                                <button class="custom-button search-btn" @click="searchFoodNutrient">
                                    <i class="el-icon-search"></i>
                                    <span>查询</span>
                                </button>
                            </el-form-item>
                        </el-form>
                    </div>

                    <div v-if="showFoodSearchResults" class="food-search-results">
                        <div class="cookbook-detail-info">
                            <img :src="currentFoodInfo.image" class="cookbook-detail-cover" v-if="currentFoodInfo && currentFoodInfo.image">
                            <div class="cookbook-detail-meta">
                                <h3>{{currentFoodInfo.name}}</h3>
                                <div class="cookbook-meta-items">
                                    <div class="cookbook-meta-item">
                                        <i class="el-icon-menu"></i>
                                        <span>{{currentFoodInfo.category}}</span>
                                    </div>
                                </div>
                                <p class="food-description">{{currentFoodInfo.description}}</p>
                            </div>
                        </div>

                        <div class="nutrient-section">
                            <h4 class="nutrient-section-title">每100克{{currentFoodInfo.name}}的营养成分</h4>
                            <div class="nutrient-table-container">
                                <el-table :data="currentFoodNutrients" style="width: 100%">
                                    <el-table-column prop="name" label="营养素" width="150"></el-table-column>
                                    <el-table-column prop="value" label="含量"></el-table-column>
                                    <el-table-column prop="unit" label="单位" width="80"></el-table-column>
                                    <el-table-column prop="percentage" label="每日参考值%" width="120">
                                        <template slot-scope="scope">
                                            <el-progress :percentage="scope.row.percentage" :color="getProgressColor(scope.row.percentage)" :show-text="false"></el-progress>
                                            <span>{{scope.row.percentage}}%</span>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </el-dialog>

        <!-- 食物份量营养计算弹窗 -->
        <el-dialog :visible.sync="portionCalculatorVisible" custom-class="cookbook-detail-dialog" width="70%">
            <div class="cookbook-detail-header">
                <h2 class="cookbook-detail-title">食物份量营养计算</h2>
                <p class="cookbook-detail-subtitle">根据食物重量计算精确的营养成分</p>
            </div>
            <div class="portion-calculator-container">
                <div class="portion-calculator-form">
                    <el-form :model="portionCalculatorForm" label-width="120px">
                        <el-form-item label="选择食物">
                            <el-autocomplete
                                v-model="portionCalculatorForm.foodName"
                                :fetch-suggestions="queryFoodSuggestions"
                                placeholder="请输入食物名称"
                                @select="handlePortionFoodSelect"
                                style="width: 250px"
                                clearable>
                            </el-autocomplete>
                        </el-form-item>
                        <el-form-item label="食物重量(克)">
                            <el-input-number 
                                v-model="portionCalculatorForm.weight" 
                                :min="1" 
                                :max="10000"
                                @change="calculatePortionNutrients">
                            </el-input-number>
                        </el-form-item>
                        <el-form-item>
                            <button class="custom-button calc-btn" @click="calculatePortionNutrients">
                                <i class="el-icon-data-analysis"></i>
                                <span>计算</span>
                            </button>
                        </el-form-item>
                    </el-form>
                </div>

                <div v-if="showPortionResults" class="portion-calculator-results">
                    <div class="cookbook-detail-info">
                        <div class="cookbook-detail-meta">
                            <h3>{{portionCalculatorForm.weight}}克{{portionCalculatorForm.foodName}}的营养成分</h3>
                        </div>
                    </div>
                    
                    <div class="nutrition-summary">
                        <div class="summary-header">
                            <h4>总热量: <span class="calorie-value">{{totalCalories}}</span> 千卡</h4>
                        </div>
                        <div class="macronutrient-distribution">
                            <div class="macro-item">
                                <div class="macro-label">蛋白质</div>
                                <el-progress :percentage="proteinPercentage" color="#67C23A"></el-progress>
                                <div class="macro-value">{{proteinGrams}}克 ({{proteinPercentage}}%)</div>
                            </div>
                            <div class="macro-item">
                                <div class="macro-label">脂肪</div>
                                <el-progress :percentage="fatPercentage" color="#E6A23C"></el-progress>
                                <div class="macro-value">{{fatGrams}}克 ({{fatPercentage}}%)</div>
                            </div>
                            <div class="macro-item">
                                <div class="macro-label">碳水化合物</div>
                                <el-progress :percentage="carbPercentage" color="#409EFF"></el-progress>
                                <div class="macro-value">{{carbGrams}}克 ({{carbPercentage}}%)</div>
                            </div>
                        </div>
                    </div>

                    <div class="nutrient-section">
                        <h4 class="nutrient-section-title">详细营养素含量</h4>
                        <div class="nutrient-table-container">
                            <el-table :data="portionNutrients" style="width: 100%">
                                <el-table-column prop="name" label="营养素" width="150"></el-table-column>
                                <el-table-column prop="value" label="含量"></el-table-column>
                                <el-table-column prop="unit" label="单位" width="80"></el-table-column>
                                <el-table-column prop="percentage" label="每日参考值%" width="120">
                                    <template slot-scope="scope">
                                        <el-progress :percentage="scope.row.percentage" :color="getProgressColor(scope.row.percentage)" :show-text="false"></el-progress>
                                        <span>{{scope.row.percentage}}%</span>
                                    </template>
                                </el-table-column>
                            </el-table>
                        </div>
                    </div>
                </div>
            </div>
        </el-dialog>
    </el-row>
</template>

<script>
import { getHealthInfo } from "@/utils/storage";

export default {
    data() {
        return {
            filterText: '',
            currentPage: 1,
            pageSize: 20,
            totalItems: 0,
            tableData: [],
            searchTime: [],
            cookbookQueryDto: {}, // 搜索条件
            categories: [],
            dialogVisible: false,
            nutrimentDialogVisible: false,
            currentCookbook: null,
            cookbookNutrimentList: [],
            currentUserId: null, // 当前用户ID
            foodNutrientSearchVisible: false,
            foodSearchForm: {
                name: '',
            },
            currentFoodInfo: null,
            currentFoodNutrients: [],
            showFoodSearchResults: false,
            portionCalculatorVisible: false,
            portionCalculatorForm: {
                foodName: '',
                weight: 100,
            },
            showPortionResults: false,
            portionNutrients: [],
            totalCalories: 0,
            proteinPercentage: 0,
            fatPercentage: 0,
            carbPercentage: 0,
            proteinGrams: 0,
            fatGrams: 0,
            carbGrams: 0,
            // 食物数据库
            foodDatabase: [
                {
                    id: 1,
                    name: '白米饭',
                    image: '',
                    description: '煮熟的白米饭，主要提供碳水化合物和能量。',
                    category: '主食',
                    nutrients: [
                        { name: '热量', value: 116, unit: 'kcal', percentage: 6 },
                        { name: '蛋白质', value: 2.6, unit: 'g', percentage: 4 },
                        { name: '脂肪', value: 0.3, unit: 'g', percentage: 0 },
                        { name: '碳水化合物', value: 25.6, unit: 'g', percentage: 9 },
                        { name: '膳食纤维', value: 0.3, unit: 'g', percentage: 1 },
                        { name: '维生素B1', value: 0.02, unit: 'mg', percentage: 2 },
                        { name: '维生素B2', value: 0.01, unit: 'mg', percentage: 1 },
                        { name: '钾', value: 28, unit: 'mg', percentage: 1 },
                        { name: '镁', value: 13, unit: 'mg', percentage: 4 },
                        { name: '钙', value: 5, unit: 'mg', percentage: 1 },
                        { name: '铁', value: 0.2, unit: 'mg', percentage: 1 }
                    ]
                },
                {
                    id: 2,
                    name: '猪肉（瘦）',
                    image: '',
                    description: '瘦猪肉是优质蛋白质的来源，含有多种B族维生素和矿物质。',
                    category: '肉类',
                    nutrients: [
                        { name: '热量', value: 143, unit: 'kcal', percentage: 7 },
                        { name: '蛋白质', value: 20.3, unit: 'g', percentage: 34 },
                        { name: '脂肪', value: 6.2, unit: 'g', percentage: 9 },
                        { name: '碳水化合物', value: 0.5, unit: 'g', percentage: 0 },
                        { name: '维生素B1', value: 0.6, unit: 'mg', percentage: 50 },
                        { name: '维生素B2', value: 0.2, unit: 'mg', percentage: 15 },
                        { name: '维生素B6', value: 0.4, unit: 'mg', percentage: 24 },
                        { name: '烟酸', value: 3.8, unit: 'mg', percentage: 24 },
                        { name: '锌', value: 2.5, unit: 'mg', percentage: 23 },
                        { name: '铁', value: 1.5, unit: 'mg', percentage: 11 }
                    ]
                },
                {
                    id: 3,
                    name: '鸡蛋',
                    image: '',
                    description: '鸡蛋是优质蛋白质和多种维生素、矿物质的良好来源，尤其富含卵磷脂和胆碱。',
                    category: '蛋类',
                    nutrients: [
                        { name: '热量', value: 155, unit: 'kcal', percentage: 8 },
                        { name: '蛋白质', value: 12.7, unit: 'g', percentage: 21 },
                        { name: '脂肪', value: 11.1, unit: 'g', percentage: 16 },
                        { name: '碳水化合物', value: 0.7, unit: 'g', percentage: 0 },
                        { name: '维生素A', value: 228, unit: 'μg', percentage: 25 },
                        { name: '维生素D', value: 1.8, unit: 'μg', percentage: 18 },
                        { name: '维生素E', value: 1.1, unit: 'mg', percentage: 7 },
                        { name: '维生素B2', value: 0.45, unit: 'mg', percentage: 35 },
                        { name: '胆碱', value: 250, unit: 'mg', percentage: 45 },
                        { name: '叶酸', value: 24, unit: 'μg', percentage: 6 },
                        { name: '铁', value: 2.1, unit: 'mg', percentage: 15 },
                        { name: '硒', value: 30.7, unit: 'μg', percentage: 56 },
                        { name: '锌', value: 1.3, unit: 'mg', percentage: 12 }
                    ]
                },
                {
                    id: 4,
                    name: '西兰花',
                    image: '',
                    description: '西兰花富含维生素C、维生素K、叶酸和膳食纤维，具有很高的营养价值。',
                    category: '蔬菜',
                    nutrients: [
                        { name: '热量', value: 34, unit: 'kcal', percentage: 2 },
                        { name: '蛋白质', value: 2.8, unit: 'g', percentage: 5 },
                        { name: '脂肪', value: 0.4, unit: 'g', percentage: 1 },
                        { name: '碳水化合物', value: 6.6, unit: 'g', percentage: 2 },
                        { name: '膳食纤维', value: 2.6, unit: 'g', percentage: 10 },
                        { name: '维生素C', value: 89.2, unit: 'mg', percentage: 99 },
                        { name: '维生素K', value: 102, unit: 'μg', percentage: 85 },
                        { name: '叶酸', value: 63, unit: 'μg', percentage: 16 },
                        { name: '维生素A', value: 31, unit: 'μg', percentage: 3 },
                        { name: '钾', value: 316, unit: 'mg', percentage: 7 },
                        { name: '钙', value: 47, unit: 'mg', percentage: 5 }
                    ]
                },
                {
                    id: 5,
                    name: '香蕉',
                    image: '',
                    description: '香蕉富含钾、维生素B6和膳食纤维，是很好的能量来源。',
                    category: '水果',
                    nutrients: [
                        { name: '热量', value: 89, unit: 'kcal', percentage: 4 },
                        { name: '蛋白质', value: 1.1, unit: 'g', percentage: 2 },
                        { name: '脂肪', value: 0.3, unit: 'g', percentage: 0 },
                        { name: '碳水化合物', value: 22.8, unit: 'g', percentage: 8 },
                        { name: '膳食纤维', value: 2.6, unit: 'g', percentage: 10 },
                        { name: '维生素B6', value: 0.4, unit: 'mg', percentage: 24 },
                        { name: '维生素C', value: 8.7, unit: 'mg', percentage: 10 },
                        { name: '钾', value: 358, unit: 'mg', percentage: 8 },
                        { name: '镁', value: 27, unit: 'mg', percentage: 7 }
                    ]
                },
                {
                    id: 6,
                    name: '牛奶',
                    image: '',
                    description: '牛奶含有优质蛋白质、钙、维生素B2和B12，是钙的重要来源。',
                    category: '乳制品',
                    nutrients: [
                        { name: '热量', value: 60, unit: 'kcal', percentage: 3 },
                        { name: '蛋白质', value: 3.3, unit: 'g', percentage: 6 },
                        { name: '脂肪', value: 3.2, unit: 'g', percentage: 5 },
                        { name: '碳水化合物', value: 4.8, unit: 'g', percentage: 2 },
                        { name: '钙', value: 120, unit: 'mg', percentage: 12 },
                        { name: '维生素B2', value: 0.17, unit: 'mg', percentage: 13 },
                        { name: '维生素B12', value: 0.45, unit: 'μg', percentage: 19 },
                        { name: '维生素D', value: 0.2, unit: 'μg', percentage: 2 },
                        { name: '钾', value: 150, unit: 'mg', percentage: 3 },
                        { name: '磷', value: 93, unit: 'mg', percentage: 13 }
                    ]
                },
                {
                    id: 7,
                    name: '豆腐',
                    image: '',
                    description: '豆腐是植物蛋白的良好来源，富含钙、镁和铁等矿物质。',
                    category: '豆制品',
                    nutrients: [
                        { name: '热量', value: 76, unit: 'kcal', percentage: 4 },
                        { name: '蛋白质', value: 8.2, unit: 'g', percentage: 14 },
                        { name: '脂肪', value: 4.6, unit: 'g', percentage: 7 },
                        { name: '碳水化合物', value: 1.5, unit: 'g', percentage: 1 },
                        { name: '钙', value: 350, unit: 'mg', percentage: 35 },
                        { name: '铁', value: 3.4, unit: 'mg', percentage: 24 },
                        { name: '镁', value: 38, unit: 'mg', percentage: 10 },
                        { name: '锌', value: 0.6, unit: 'mg', percentage: 5 },
                        { name: '维生素E', value: 0.1, unit: 'mg', percentage: 1 }
                    ]
                },
                {
                    id: 8,
                    name: '燕麦',
                    image: '',
                    description: '燕麦富含可溶性膳食纤维β-葡聚糖，能够帮助降低胆固醇，是优质的谷物食品。',
                    category: '谷物',
                    nutrients: [
                        { name: '热量', value: 389, unit: 'kcal', percentage: 19 },
                        { name: '蛋白质', value: 16.9, unit: 'g', percentage: 28 },
                        { name: '脂肪', value: 6.9, unit: 'g', percentage: 10 },
                        { name: '碳水化合物', value: 66.3, unit: 'g', percentage: 22 },
                        { name: '膳食纤维', value: 10.6, unit: 'g', percentage: 42 },
                        { name: '维生素B1', value: 0.76, unit: 'mg', percentage: 63 },
                        { name: '铁', value: 4.7, unit: 'mg', percentage: 34 },
                        { name: '锌', value: 4, unit: 'mg', percentage: 36 },
                        { name: '镁', value: 177, unit: 'mg', percentage: 44 },
                        { name: '钾', value: 429, unit: 'mg', percentage: 9 }
                    ]
                },
                {
                    id: 9,
                    name: '三文鱼',
                    image: '',
                    description: '三文鱼富含Omega-3脂肪酸、高质量蛋白质和多种维生素，对心脏健康有益。',
                    category: '海鲜',
                    nutrients: [
                        { name: '热量', value: 208, unit: 'kcal', percentage: 10 },
                        { name: '蛋白质', value: 22.1, unit: 'g', percentage: 37 },
                        { name: '脂肪', value: 13.4, unit: 'g', percentage: 19 },
                        { name: 'Omega-3', value: 2.3, unit: 'g', percentage: 115 },
                        { name: '维生素D', value: 13.7, unit: 'μg', percentage: 137 },
                        { name: '维生素B12', value: 2.8, unit: 'μg', percentage: 117 },
                        { name: '硒', value: 46.8, unit: 'μg', percentage: 85 },
                        { name: '钾', value: 363, unit: 'mg', percentage: 8 },
                        { name: '磷', value: 250, unit: 'mg', percentage: 36 }
                    ]
                },
                {
                    id: 10,
                    name: '花生',
                    image: '',
                    description: '花生富含蛋白质、不饱和脂肪酸和多种维生素、矿物质，是良好的能量来源。',
                    category: '坚果',
                    nutrients: [
                        { name: '热量', value: 567, unit: 'kcal', percentage: 28 },
                        { name: '蛋白质', value: 25.8, unit: 'g', percentage: 43 },
                        { name: '脂肪', value: 49.2, unit: 'g', percentage: 70 },
                        { name: '碳水化合物', value: 16.1, unit: 'g', percentage: 5 },
                        { name: '膳食纤维', value: 8.5, unit: 'g', percentage: 34 },
                        { name: '维生素E', value: 8.3, unit: 'mg', percentage: 55 },
                        { name: '烟酸', value: 12.1, unit: 'mg', percentage: 76 },
                        { name: '镁', value: 168, unit: 'mg', percentage: 42 },
                        { name: '磷', value: 376, unit: 'mg', percentage: 54 },
                        { name: '锰', value: 1.9, unit: 'mg', percentage: 83 }
                    ]
                }
            ]
        };
    },
    created() {
        this.fetchFreshData();
        this.fetchFreshCategories();
        this.getCurrentUserId();
    },
    methods: {
        // 获取当前用户ID
        getCurrentUserId() {
            const userInfoStr = getHealthInfo();
            if (userInfoStr) {
                try {
                    const userInfo = JSON.parse(userInfoStr);
                    this.currentUserId = userInfo.id;
                } catch (error) {
                    console.error('解析用户信息失败:', error);
                }
            }
        },
        
        // 查询公开食谱数据
        async fetchFreshData() {
            try {
                this.tableData = [];
                let startTime = null;
                let endTime = null;
                if (this.searchTime != null && this.searchTime.length === 2) {
                    const [startDate, endDate] = await Promise.all(this.searchTime.map(date => date.toISOString()));
                    startTime = `${startDate.split('T')[0]}T00:00:00`;
                    endTime = `${endDate.split('T')[0]}T23:59:59`;
                }
                // 请求参数
                const params = {
                    current: this.currentPage,
                    size: this.pageSize,
                    key: this.filterText,
                    startTime: startTime,
                    endTime: endTime,
                    ...this.cookbookQueryDto
                };
                const response = await this.$axios.post('/cookbook/queryPublish', params);
                const { data } = response;
                this.tableData = data.data;
                this.totalItems = data.total;
            } catch (error) {
                this.$message.error("查询公开食谱异常:");
                console.error('查询公开食谱异常:', error);
            }
        },
        
        // 查询美食分类信息
        fetchFreshCategories() {
            this.$axios.post('/category/query', {}).then(res => {
                if (res.data.code === 200) {
                    this.categories = res.data.data;
                    const allCategory = { id: null, name: '全部' };
                    // 头插
                    this.categories.unshift(allCategory);
                }
            }).catch(error => {
                console.log("查询美食分类异常：", error);
            });
        },
        
        // 查看食谱详情
        viewDetail(cookbook) {
            this.currentCookbook = cookbook;
            this.dialogVisible = true;
        },
        
        // 营养素信息
        viewNutriments(cookbook) {
            this.fetchCookbookNutrimentData(cookbook.id);
            this.nutrimentDialogVisible = true;
        },
        
        // 编辑食谱
        editCookbook(cookbook) {
            // 检查是否是当前用户的食谱
            if (cookbook.userId !== this.currentUserId) {
                this.$message.warning("只能修改自己创建的食谱");
                return;
            }
            // 处理编辑逻辑
            this.$router.push({
                path: "/user/gourmet/form",
                query: { cookbookId: cookbook.id },
            });
        },
        
        // 删除食谱
        deleteCookbook(cookbook) {
            // 检查是否是当前用户的食谱
            if (cookbook.userId !== this.currentUserId) {
                this.$message.warning("只能删除自己创建的食谱");
                return;
            }
            
            this.$confirm("是否确定删除该食谱?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning",
            }).then(() => {
                this.$axios.post("/cookbook/delete", { id: cookbook.id })
                    .then((res) => {
                        if (res.data.code === 200) {
                            this.$message.success("删除成功");
                            this.fetchFreshData();
                        } else {
                            this.$message.error(res.data.msg);
                        }
                    })
                    .catch((error) => {
                        console.error("删除食谱异常:", error);
                        this.$message.error("删除食谱异常");
                    });
            }).catch(() => { });
        },
        
        // 查询食谱关联的营养素数据
        fetchCookbookNutrimentData(cookbookId) {
            this.cookbookNutrimentList = [];
            this.$axios.post('/cookbookNutriment/getListByCookbookId', { cookbookId }).then(res => {
                if (res.data.code === 200) {
                    this.cookbookNutrimentList = res.data.data;
                }
            }).catch(error => {
                console.log("查询食谱关联营养素异常：", error);
            });
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
        
        showFoodNutrientSearch() {
            this.foodNutrientSearchVisible = true;
        },
        
        queryFoodSuggestions(queryString, cb) {
            const results = queryString ? this.foodDatabase.filter(food => {
                return food.name.toLowerCase().includes(queryString.toLowerCase());
            }) : this.foodDatabase;
            
            // 返回格式化后的数据供自动完成组件使用
            cb(results.map(food => ({
                value: food.name,
                id: food.id,
                name: food.name,
                image: food.image,
                description: food.description,
                category: food.category,
                nutrients: food.nutrients
            })));
        },
        
        handleFoodSelect(item) {
            // 处理食物选择后的逻辑
            this.currentFoodInfo = item;
            this.currentFoodNutrients = item.nutrients;
            this.showFoodSearchResults = true;
        },
        
        searchFoodNutrient() {
            // 实现食物营养成分查询的逻辑
            if (!this.foodSearchForm.name) {
                this.$message.warning('请输入食物名称');
                return;
            }
            
            // 根据名称查找食物
            const foodItem = this.foodDatabase.find(food => 
                food.name.toLowerCase() === this.foodSearchForm.name.toLowerCase()
            );
            
            if (foodItem) {
                this.currentFoodInfo = {
                    id: foodItem.id,
                    name: foodItem.name,
                    image: foodItem.image,
                    description: foodItem.description,
                    category: foodItem.category
                };
                this.currentFoodNutrients = foodItem.nutrients;
                this.showFoodSearchResults = true;
            } else {
                this.$message.warning('未找到该食物信息');
            }
        },
        
        showPortionCalculator() {
            this.portionCalculatorVisible = true;
        },
        
        calculatePortionNutrients() {
            // 实现食物份量营养计算的逻辑
            if (!this.portionCalculatorForm.foodName) {
                this.$message.warning('请选择食物');
                return;
            }
            
            // 根据名称查找食物
            const foodItem = this.foodDatabase.find(food => 
                food.name === this.portionCalculatorForm.foodName
            );
            
            if (foodItem) {
                // 计算指定重量的营养素含量
                const weight = this.portionCalculatorForm.weight;
                const weightRatio = weight / 100; // 食物数据库中的营养素含量是按每100克计算的
                
                // 计算营养素含量
                this.portionNutrients = foodItem.nutrients.map(nutrient => ({
                    name: nutrient.name,
                    value: (nutrient.value * weightRatio).toFixed(1),
                    unit: nutrient.unit,
                    percentage: Math.round(nutrient.percentage * weightRatio)
                }));
                
                // 计算宏量营养素分布
                const nutrients = {};
                foodItem.nutrients.forEach(n => {
                    nutrients[n.name] = n.value * weightRatio;
                });
                
                // 计算热量和宏量营养素
                this.totalCalories = nutrients['热量'] ? Math.round(nutrients['热量']) : 0;
                this.proteinGrams = nutrients['蛋白质'] ? nutrients['蛋白质'].toFixed(1) : 0;
                this.fatGrams = nutrients['脂肪'] ? nutrients['脂肪'].toFixed(1) : 0;
                this.carbGrams = nutrients['碳水化合物'] ? nutrients['碳水化合物'].toFixed(1) : 0;
                
                // 计算营养素占比
                const totalEnergy = (this.proteinGrams * 4) + (this.fatGrams * 9) + (this.carbGrams * 4);
                if (totalEnergy > 0) {
                    this.proteinPercentage = Math.round((this.proteinGrams * 4 / totalEnergy) * 100);
                    this.fatPercentage = Math.round((this.fatGrams * 9 / totalEnergy) * 100);
                    this.carbPercentage = Math.round((this.carbGrams * 4 / totalEnergy) * 100);
                }
                
                this.showPortionResults = true;
            } else {
                this.$message.warning('未找到该食物信息');
            }
        },
        
        handlePortionFoodSelect(item) {
            // 处理食物选择后的逻辑
            this.portionCalculatorForm.foodName = item.name;
            // 自动计算
            this.calculatePortionNutrients();
        },
        
        getProgressColor(percentage) {
            if (percentage < 30) {
                return '#67C23A';
            } else if (percentage < 60) {
                return '#E6A23C';
            } else {
                return '#409EFF';
            }
        }
    }
};
</script>

<style>
/* 自定义按钮样式 */
.custom-button {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 8px 16px;
    border: none;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 500;
    color: #fff;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    min-width: 140px;
    height: 36px;
    letter-spacing: 0.5px;
    position: relative;
    overflow: hidden;
}

.custom-button::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.1);
    transform: translateX(-100%);
    transition: transform 0.3s ease;
}

.custom-button:hover::before {
    transform: translateX(0);
}

.custom-button:active {
    transform: translateY(2px);
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
}

.custom-button i {
    margin-right: 8px;
    font-size: 16px;
}

.custom-button span {
    font-size: 14px;
    white-space: nowrap;
}

.nutrition-search-btn {
    background: linear-gradient(135deg, #6a5af9, #4285f4);
    font-size: 14px;
}

.nutrition-search-btn:hover {
    background: linear-gradient(135deg, #5648e6, #3b78e7);
}

.portion-calc-btn {
    background: linear-gradient(135deg, #f9466a, #f05d23);
    font-size: 14px;
}

.portion-calc-btn:hover {
    background: linear-gradient(135deg, #e33959, #e34e16);
}

.search-btn {
    background: linear-gradient(135deg, #3498db, #2980b9);
    width: 90px;
}

.search-btn:hover {
    background: linear-gradient(135deg, #2980b9, #2573a7);
}

.calc-btn {
    background: linear-gradient(135deg, #27ae60, #2ecc71);
    width: 90px;
}

.calc-btn:hover {
    background: linear-gradient(135deg, #219d54, #27ae60);
}

/* 全局样式，确保能够应用到元素上 */
.nutriment-dialog .el-dialog__body {
    padding: 40px 30px 25px 30px !important;
}

.cookbook-cover {
    width: 200px;
    height: 150px;
    object-fit: cover;
    margin-right: 20px;
    border-radius: 8px;
}

.cookbook-header {
    display: flex;
    margin-bottom: 20px;
}

.cookbook-title {
    flex: 1;
}

.cookbook-meta {
    display: flex;
    gap: 15px;
    color: #666;
    margin-top: 5px;
}

.cookbook-content {
    margin-top: 20px;
    line-height: 1.6;
}

.text-button {
    color: #409EFF;
    cursor: pointer;
    display: inline-block;
    width: 70px;
    margin-bottom: 8px;
}

.operation-buttons {
    display: flex;
    flex-direction: column;
    width: 160px;
}

.button-row {
    display: flex;
    justify-content: space-between;
}

.nutriment-dialog {
    border-radius: 8px;
}

.nutriment-dialog .el-dialog__header {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f0f0;
}

.nutriment-header {
    text-align: center;
    margin-bottom: 30px;
    padding-bottom: 15px;
    border-bottom: 1px dashed #f0f0f0;
}

.nutriment-title {
    font-size: 24px;
    font-weight: 600;
    background: linear-gradient(135deg, #3498db, #8e44ad);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 12px;
}

.cookbook-detail-subtitle {
    color: #606266;
    font-size: 15px;
    margin: 0;
    font-weight: 400;
    letter-spacing: 0.5px;
}

.nutriment-subtitle {
    color: #606266;
    font-size: 15px;
    margin: 0;
    font-weight: 400;
    letter-spacing: 0.5px;
}

.nutriment-empty {
    padding: 30px 0;
    text-align: center;
}

.nutriment-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
    padding: 10px 0;
}

.nutriment-card {
    width: 160px;
    height: 130px;
    border-radius: 12px;
    box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.08);
    overflow: hidden;
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
    background-color: #fff;
    border: 1px solid #ebeef5;
}

.nutriment-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
}

.nutriment-card-header {
    padding: 14px 10px;
    background-color: #409EFF;
    color: white;
    text-align: center;
}

.nutriment-name {
    font-size: 16px;
    font-weight: bold;
    display: block;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.nutriment-card-body {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 12px;
}

.nutriment-value {
    font-size: 24px;
    font-weight: bold;
    color: #303133;
    text-align: center;
}

.nutriment-unit {
    font-size: 13px;
    color: #606266;
    margin-left: 3px;
}

.cookbook-detail-dialog {
    border-radius: 8px;
}

.cookbook-detail-dialog .el-dialog__header {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f0f0;
}

.cookbook-detail-container {
    display: flex;
    flex-direction: column;
    gap: 20px;
    padding: 10px 0;
}

.cookbook-detail-info {
    display: flex;
    align-items: center;
    background-color: #f9f9f9;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.05);
}

.cookbook-detail-cover {
    width: 180px;
    height: 140px;
    object-fit: cover;
    margin-right: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.cookbook-detail-meta {
    flex: 1;
}

.cookbook-detail-meta h3 {
    color: #303133;
    margin-top: 0;
    margin-bottom: 15px;
    font-size: 20px;
}

.cookbook-meta-items {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    color: #666;
}

.cookbook-meta-item {
    display: flex;
    align-items: center;
    background-color: #fff;
    padding: 6px 12px;
    border-radius: 16px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

.cookbook-meta-item i {
    margin-right: 5px;
    color: #409EFF;
}

.cookbook-detail-content {
    margin-top: 10px;
    line-height: 1.6;
    background-color: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.05);
}

.cookbook-detail-dialog .el-dialog__body {
    padding: 40px 30px 25px 30px !important;
}

.cookbook-detail-header {
    text-align: center;
    margin-bottom: 30px;
    padding-bottom: 15px;
    border-bottom: 1px dashed #f0f0f0;
}

.cookbook-detail-title {
    font-size: 24px;
    font-weight: 600;
    background: linear-gradient(135deg, #3498db, #8e44ad);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 12px;
}

.food-nutrient-search-container {
    padding: 20px 0;
}

.food-search-section {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.food-search-form {
    display: flex;
    flex-direction: column;
    gap: 10px;
    background-color: #f9f9f9;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.05);
}

.food-search-results {
    margin-top: 20px;
}

.food-info-header {
    display: flex;
    align-items: center;
    gap: 20px;
}

.food-image {
    width: 100px;
    height: 100px;
    object-fit: cover;
    border-radius: 8px;
}

.food-info-meta {
    flex: 1;
}

.food-info-meta h3 {
    margin-top: 0;
    margin-bottom: 10px;
}

.food-info-meta p {
    margin: 0;
}

.nutrient-section {
    margin-top: 20px;
    background-color: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.05);
}

.nutrient-section-title {
    margin-bottom: 20px;
    font-size: 18px;
    color: #409EFF;
    border-bottom: 1px dashed #eee;
    padding-bottom: 10px;
}

.nutrient-table-container {
    margin-top: 10px;
}

.portion-calculator-container {
    padding: 20px 0;
}

.portion-calculator-form {
    display: flex;
    flex-direction: column;
    gap: 10px;
    background-color: #f9f9f9;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.05);
}

.portion-calculator-results {
    margin-top: 20px;
}

.nutrition-summary {
    margin: 20px 0;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 12px;
    box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.05);
}

.summary-header {
    margin-bottom: 20px;
    border-bottom: 1px dashed #eee;
    padding-bottom: 10px;
}

.summary-header h4 {
    color: #303133;
    margin: 0;
}

.calorie-value {
    font-weight: bold;
    color: #409EFF;
    font-size: 20px;
}

.macronutrient-distribution {
    display: flex;
    gap: 20px;
}

.macro-item {
    flex: 1;
    background-color: white;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.macro-label {
    margin-bottom: 10px;
    font-weight: bold;
    color: #303133;
}

.macro-value {
    margin-top: 10px;
    text-align: center;
    color: #606266;
}

.food-description {
    color: #606266;
    margin-top: 10px;
    line-height: 1.6;
}

/* 响应式设计 */
@media screen and (max-width: 768px) {
    .custom-button {
        min-width: 120px;
        height: 32px;
        font-size: 13px;
        padding: 6px 12px;
    }
    
    .custom-button i {
        font-size: 14px;
        margin-right: 6px;
    }
    
    .cookbook-detail-title,
    .nutriment-title {
        font-size: 22px;
    }
    
    .cookbook-detail-subtitle,
    .nutriment-subtitle {
        font-size: 14px;
    }
    
    .nutriment-card {
        width: 140px;
        height: 120px;
    }
    
    .nutriment-value {
        font-size: 22px;
    }
}

@media screen and (max-width: 576px) {
    .custom-button {
        min-width: 100px;
        height: 30px;
        font-size: 12px;
        padding: 5px 10px;
    }
    
    .macronutrient-distribution {
        flex-direction: column;
        gap: 10px;
    }
}

/* 美化选择框和搜索框 */
.el-select .el-input__inner,
.el-date-editor.el-input__inner,
.el-input__inner {
    border-radius: 20px;
    border: 1px solid #e0e0e0;
    transition: all 0.3s;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

.el-select .el-input__inner:hover,
.el-date-editor.el-input__inner:hover,
.el-input__inner:hover {
    border-color: #c0c4cc;
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.08);
}

.el-select .el-input__inner:focus,
.el-date-editor.el-input__inner:focus,
.el-input__inner:focus {
    border-color: #409EFF;
    box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

/* 美化下拉菜单 */
.el-select-dropdown {
    border-radius: 12px;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
    border: none;
}

.el-select-dropdown__item {
    padding: 10px 20px;
}

.el-select-dropdown__item.selected {
    background-color: #ecf5ff;
    color: #409EFF;
    font-weight: bold;
}

/* 美化日期选择器 */
.el-picker-panel {
    border-radius: 12px;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
    border: none;
    overflow: hidden;
}

/* 美化搜索按钮 */
.el-input-group__append {
    border-top-right-radius: 20px !important;
    border-bottom-right-radius: 20px !important;
    background: linear-gradient(135deg, #409EFF, #64B5F6);
    border-color: #409EFF;
    color: white;
    transition: all 0.3s;
}

.el-input-group__append:hover {
    background: linear-gradient(135deg, #64B5F6, #409EFF);
    border-color: #64B5F6;
}

.el-input-group__append .el-button {
    border: none;
    background: transparent;
    color: white;
    padding: 0;
}

/* 修正搜索框组合样式 */
.el-input-group__append + .el-input__inner {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
}

.el-input--suffix .el-input__inner {
    padding-right: 40px;
}

/* 自定义美化组件样式 */
.styled-select, .styled-date-picker, .styled-input {
    font-size: 14px;
}

.styled-select .el-input__inner, 
.styled-date-picker .el-input__inner, 
.styled-input .el-input__inner {
    height: 36px;
    line-height: 36px;
}

.styled-input .el-input__icon,
.styled-select .el-input__icon {
    line-height: 36px;
    color: #409EFF;
}

.styled-select .el-select-dropdown__item.selected {
    font-weight: 600;
}

/* 优化组件间距 */
.el-form-item {
    margin-bottom: 18px;
}

/* 特别修复日期选择器中"至"字的垂直居中问题 - 提高选择器优先级 */
.el-date-editor .el-range-separator.el-range-separator {
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    padding: 0 !important;
    width: 6% !important;
    height: 100% !important;
    color: #909399 !important;
    font-size: 14px !important;
    line-height: 1 !important;
}

/* 进一步优化日期选择器样式，确保所有元素垂直居中 */
.el-date-editor--daterange.el-input__inner {
    display: flex;
    align-items: center;
    padding: 0 10px;
}

.el-date-editor .el-range__icon,
.el-date-editor .el-range__close-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    line-height: normal;
}

.el-range-editor--small .el-range-input {
    font-size: 14px;
}

/* 修正日期选择器中输入框的垂直对齐 */
.el-range-editor .el-range-input {
    display: flex;
    align-items: center;
    text-align: center;
    height: 100%;
}

/* 修正图标和文本位置问题 */
.el-input__inner {
    padding-left: 15px;
    padding-right: 30px;
}

.el-input__suffix {
    right: 10px;
}

.el-input__prefix {
    left: 10px;
}

.el-input__icon {
    line-height: 36px;
    height: 100%;
    text-align: center;
}

/* 调整搜索按钮内的图标位置 */
.el-input-group__append .el-button {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0 10px;
}

.el-input-group__append .el-icon-search {
    font-size: 16px;
}

/* 调整下拉箭头位置 */
.el-select .el-input .el-select__caret {
    color: #909399;
    font-size: 14px;
    transition: transform .3s;
    transform: rotateZ(180deg);
    cursor: pointer;
    line-height: 36px;
}

/* 进一步优化日期选择器样式，确保所有元素垂直居中 */
.el-date-editor--daterange.el-input__inner {
    display: flex;
    align-items: center;
    padding: 0 10px;
}

.el-date-editor .el-range__icon,
.el-date-editor .el-range__close-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    line-height: normal;
}

.el-range-editor--small .el-range-input {
    font-size: 14px;
}

/* 修正日期选择器中输入框的垂直对齐 */
.el-range-editor .el-range-input {
    display: flex;
    align-items: center;
    text-align: center;
    height: 100%;
    width: 39%;
    margin: 0;
    padding: 0 3px;
    background-color: transparent;
    border: none;
    outline: none;
}

/* 确保搜索框内的清除图标位置正确 */
.el-input__suffix-inner {
    display: flex;
    align-items: center;
    height: 100%;
}

.el-input__icon.el-icon-circle-close {
    height: auto;
    font-size: 16px;
}

/* 调整占位符文本颜色和位置 */
.el-input__inner::-webkit-input-placeholder {
    color: #b4b6bd;
    line-height: 1.3;
}

.el-input__inner:-moz-placeholder {
    color: #b4b6bd;
    line-height: 1.3;
}

.el-input__inner::-moz-placeholder {
    color: #b4b6bd;
    line-height: 1.3;
}

.el-input__inner:-ms-input-placeholder {
    color: #b4b6bd;
    line-height: 1.3;
}
</style> 