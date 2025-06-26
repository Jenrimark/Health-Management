<template>
    <el-row style="background-color: #FFFFFF;padding: 5px 0;border-radius: 5px;">
        <el-row style="padding: 10px;margin-left: 5px;">
            <el-row style="display: flex;justify-content: space-between;align-items: center;margin-bottom: 15px;">
                <div style="display: flex;gap: 15px;">
                    <el-button class="nutriment-button primary-button" size="small" @click="showNutritionSearch">
                        <i class="el-icon-data-analysis"></i>
                        <span>营养素需求查询</span>
                    </el-button>
                    <el-button class="nutriment-button success-button" size="small" @click="showFunctionalGoals">
                        <i class="el-icon-aim"></i>
                        <span>营养素功能目标</span>
                    </el-button>
                    <el-button class="nutriment-button warning-button" size="small" @click="showFoodsByNutrient">
                        <i class="el-icon-food"></i>
                        <span>含营养素的食物查询</span>
                    </el-button>
                </div>
                <el-input class="styled-input" size="small" style="width: 200px;" v-model="nutrimentQueryDto.name" placeholder="营养素名称"
                    clearable @clear="handleFilterClear">
                    <el-button slot="append" @click="handleFilter" icon="el-icon-search"></el-button>
                </el-input>
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
                <el-table-column prop="name" label="营养素名"></el-table-column>
                <el-table-column prop="detail" label="描述" width="368"></el-table-column>
                <el-table-column prop="unit" label="单位" width="108"></el-table-column>
                <el-table-column prop="createTime" label="创建时间" :sortable="true" width="168"></el-table-column>
                <el-table-column label="操作" width="120">
                    <template slot-scope="scope">
                        <span class="text-button" @click="viewNutrimentDetail(scope.row)">详情</span>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination style="margin:10px 0;float: right;" @size-change="handleSizeChange"
                @current-change="handleCurrentChange" :current-page="currentPage" :page-sizes="[20, 50]"
                :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                :total="totalItems"></el-pagination>
        </el-row>

        <!-- 营养素详情弹窗 -->
        <el-dialog :visible.sync="nutrimentDetailVisible" custom-class="nutriment-detail-dialog" width="65%">
            <div class="nutriment-detail-header">
                <h2 class="nutriment-detail-title">营养素详细信息</h2>
                <p class="nutriment-detail-subtitle">了解营养素功能与作用</p>
            </div>
            <div v-if="currentNutriment" class="nutriment-detail-container">
                <div class="nutriment-detail-info">
                    <div class="nutriment-detail-meta">
                        <h3>{{currentNutriment.name}}</h3>
                        <div class="nutriment-meta-items">
                            <div class="nutriment-meta-item">
                                <i class="el-icon-menu"></i>
                                <span>单位: {{currentNutriment.unit}}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="nutriment-detail-section">
                    <h4>基本介绍</h4>
                    <p>{{currentNutriment.detail || '暂无介绍'}}</p>
                </div>
                <div class="nutriment-detail-section">
                    <h4>主要功能与作用</h4>
                    <p>{{getNutrimentFunction(currentNutriment.name)}}</p>
                </div>
                <div class="nutriment-detail-section">
                    <h4>常见来源</h4>
                    <div class="food-source-list">
                        <div class="food-source-item" v-for="(food, index) in getFoodSources(currentNutriment.name)" :key="index">
                            {{food}}
                        </div>
                    </div>
                </div>
            </div>
        </el-dialog>

        <!-- 营养素需求查询弹窗 -->
        <el-dialog :visible.sync="nutritionSearchVisible" custom-class="nutriment-detail-dialog" width="70%">
            <div class="nutriment-detail-header">
                <h2 class="nutriment-detail-title">每日营养素供给量查询</h2>
                <p class="nutriment-detail-subtitle">根据个人信息获取推荐营养素摄入量 · 数据来源：中国居民膳食指南</p>
            </div>
            <div class="nutrition-search-container">
                <div class="nutrition-search-form">
                    <el-form :model="nutrientSearchForm" label-width="100px" class="form-card">
                        <div class="form-row">
                            <el-form-item label="性别">
                                <el-radio-group v-model="nutrientSearchForm.gender">
                                    <el-radio label="male">男性</el-radio>
                                    <el-radio label="female">女性</el-radio>
                                </el-radio-group>
                            </el-form-item>
                            <el-form-item label="年龄">
                                <el-input-number v-model="nutrientSearchForm.age" :min="0" :max="120" size="small"></el-input-number>
                            </el-form-item>
                        </div>
                        <div class="form-row">
                            <el-form-item label="身高(cm)">
                                <el-input-number v-model="nutrientSearchForm.height" :min="50" :max="250" size="small"></el-input-number>
                            </el-form-item>
                            <el-form-item label="体重(kg)">
                                <el-input-number v-model="nutrientSearchForm.weight" :min="5" :max="250" size="small"></el-input-number>
                            </el-form-item>
                        </div>
                        <div class="form-row">
                            <el-form-item label="活动水平">
                                <el-select v-model="nutrientSearchForm.activityLevel" size="small">
                                    <el-option label="久坐不动" value="sedentary"></el-option>
                                    <el-option label="轻度活动" value="light"></el-option>
                                    <el-option label="中度活动" value="moderate"></el-option>
                                    <el-option label="重度活动" value="active"></el-option>
                                    <el-option label="非常活跃" value="very_active"></el-option>
                                </el-select>
                            </el-form-item>
                        </div>
                        <el-form-item>
                            <el-button type="primary" @click="searchNutrientNeeds">查询</el-button>
                        </el-form-item>
                    </el-form>
                </div>
                <div v-if="showNutrientResults" class="nutrition-search-results">
                    <div class="result-card">
                        <div class="result-header">
                            <h3>每日营养素推荐摄入量</h3>
                            <div class="user-info-summary">
                                <span class="info-item">
                                    <i class="el-icon-user"></i> {{nutrientSearchForm.gender === 'male' ? '男性' : '女性'}}
                                </span>
                                <span class="info-item">
                                    <i class="el-icon-date"></i> {{nutrientSearchForm.age}}岁
                                </span>
                                <span class="info-item">
                                    <i class="el-icon-top"></i> {{nutrientSearchForm.height}}cm
                                </span>
                                <span class="info-item">
                                    <i class="el-icon-goods"></i> {{nutrientSearchForm.weight}}kg
                                </span>
                                <span class="info-item">
                                    <i class="el-icon-position"></i> {{getActivityLevelLabel()}}
                                </span>
                            </div>
                        </div>
                        <div class="result-body">
                            <el-table :data="nutrientNeedsResults" style="width: 100%">
                                <el-table-column prop="name" label="营养素" width="150"></el-table-column>
                                <el-table-column prop="amount" label="每日推荐摄入量"></el-table-column>
                                <el-table-column prop="unit" label="单位" width="80"></el-table-column>
                                <el-table-column prop="description" label="说明"></el-table-column>
                            </el-table>
                        </div>
                        <div class="result-footer">
                            <p class="result-note">注意：以上数据仅供参考，具体营养需求请咨询专业营养师</p>
                        </div>
                    </div>
                </div>
            </div>
        </el-dialog>

        <!-- 营养素功能目标弹窗 -->
        <el-dialog :visible.sync="functionalGoalsVisible" custom-class="nutriment-detail-dialog" width="75%">
            <div class="nutriment-detail-header">
                <h2 class="nutriment-detail-title">营养素功能目标查询</h2>
                <p class="nutriment-detail-subtitle">了解不同健康目标所需的关键营养素</p>
            </div>
            <div class="functional-goals-container">
                <div class="functional-goals-selection">
                    <el-tabs v-model="selectedFunctionalGoal" @tab-click="handleFunctionalGoalChange" type="card">
                        <el-tab-pane label="皮肤健康" name="skin"></el-tab-pane>
                        <el-tab-pane label="身材管理" name="weight"></el-tab-pane>
                        <el-tab-pane label="精力/疲劳" name="energy"></el-tab-pane>
                        <el-tab-pane label="睡眠" name="sleep"></el-tab-pane>
                        <el-tab-pane label="免疫力" name="immune"></el-tab-pane>
                        <el-tab-pane label="胃肠道功能" name="digestion"></el-tab-pane>
                        <el-tab-pane label="脑力/注意力" name="brain"></el-tab-pane>
                        <el-tab-pane label="情绪/压力" name="mood"></el-tab-pane>
                        <el-tab-pane label="眼睛/视力" name="eye"></el-tab-pane>
                        <el-tab-pane label="运动恢复" name="exercise"></el-tab-pane>
                        <el-tab-pane label="骨骼关节" name="bone"></el-tab-pane>
                    </el-tabs>
                </div>
                <div class="functional-goals-results">
                    <div class="functional-goal-nutrients">
                        <div class="goal-header">
                            <h3>{{getFunctionalGoalTitle()}}</h3>
                            <div class="goal-description">{{getFunctionalGoalDescription()}}</div>
                        </div>
                        
                        <div class="goal-section">
                            <h4 class="section-title">
                                <i class="el-icon-star-on"></i>
                                推荐营养素
                            </h4>
                            <div class="nutrient-cards-container">
                                <div class="nutrient-card" v-for="(nutrient, index) in getFunctionalGoalNutrients()" :key="index">
                                    <div class="nutrient-card-header">
                                        <h5>{{nutrient.name}}</h5>
                                    </div>
                                    <div class="nutrient-card-body">
                                        <p>{{nutrient.benefit}}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="goal-section">
                            <h4 class="section-title">
                                <i class="el-icon-dish"></i>
                                推荐食物
                            </h4>
                            <div class="food-cards-container">
                                <div class="food-card" v-for="(food, index) in getFunctionalGoalFoods()" :key="index">
                                    <span>{{food}}</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="goal-section">
                            <h4 class="section-title">
                                <i class="el-icon-info"></i>
                                健康建议
                            </h4>
                            <div class="health-tips">
                                <p>除了通过饮食摄入以上营养素外，还应注意：</p>
                                <ul>
                                    <li>保持充足的水分摄入，每天饮水1.5-2升</li>
                                    <li>规律作息，保证充足睡眠</li>
                                    <li>适当运动，增强身体机能</li>
                                    <li>避免过度压力，保持良好心态</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </el-dialog>



        <!-- 含特定营养素的食物查询弹窗 -->
        <el-dialog :visible.sync="foodsByNutrientVisible" custom-class="nutriment-detail-dialog" width="70%">
            <div class="nutriment-detail-header">
                <h2 class="nutriment-detail-title">含特定营养素的食物查询</h2>
                <p class="nutriment-detail-subtitle">查找富含特定营养素的食物来源</p>
            </div>
            <div class="foods-by-nutrient-container">
                <div class="foods-by-nutrient-selection">
                    <el-form :inline="true" class="form-card">
                        <el-form-item label="选择营养素">
                            <el-select v-model="selectedNutrientForFoods" placeholder="请选择营养素" style="width: 250px">
                                <el-option 
                                    v-for="item in commonNutrients" 
                                    :key="item.value" 
                                    :label="item.label" 
                                    :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item>
                            <el-button class="search-button" type="primary" @click="searchFoodsByNutrient">查询</el-button>
                        </el-form-item>
                    </el-form>
                </div>
                <div v-if="showFoodsByNutrientResults" class="foods-by-nutrient-results">
                    <div class="result-card">
                        <div class="result-header">
                            <div class="nutrient-info">
                                <div class="nutrient-icon">
                                    <i :class="getNutrientIcon(selectedNutrientForFoods)"></i>
                                </div>
                                <div class="nutrient-details">
                                    <h3>含有<span class="highlight">{{getSelectedNutrientLabel()}}</span>的食物</h3>
                                    <p class="nutrient-description">{{getNutrientDescription(selectedNutrientForFoods)}}</p>
                                </div>
                            </div>
                        </div>
                        <div class="result-body">
                            <p class="result-note">按含量从高到低排序</p>
                            <div class="foods-list">
                                <el-table :data="foodsByNutrientResults" style="width: 100%">
                                    <el-table-column prop="name" label="食物名称" width="180"></el-table-column>
                                    <el-table-column prop="amount" label="含量">
                                        <template slot-scope="scope">
                                            <div class="amount-cell">
                                                <span class="amount-value">{{scope.row.amount}}</span>
                                                <span class="amount-unit">{{scope.row.unit}}</span>
                                            </div>
                                        </template>
                                    </el-table-column>
                                    <el-table-column prop="per" label="每份"></el-table-column>
                                    <el-table-column label="含量比较" width="250">
                                        <template slot-scope="scope">
                                            <el-progress :percentage="getPercentageForFood(scope.row)" :color="getProgressColor(getPercentageForFood(scope.row))"></el-progress>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </div>
                        </div>
                        <div class="result-footer">
                            <div class="food-tips">
                                <h4>
                                    <i class="el-icon-info"></i>
                                    食用建议
                                </h4>
                                <p>{{getFoodTips(selectedNutrientForFoods)}}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </el-dialog>
    </el-row>
</template>

<script>
export default {
    data() {
        return {
            filterText: '',
            currentPage: 1,
            pageSize: 20,
            totalItems: 0,
            tableData: [],
            nutrimentQueryDto: { isPublish: true }, // 只查询公开的营养素
            nutrimentDetailVisible: false,
            nutritionSearchVisible: false,
            functionalGoalsVisible: false,

            foodsByNutrientVisible: false,
            currentNutriment: null,
            nutrientSearchForm: {
                gender: 'male',
                age: 25,
                height: 175,
                weight: 70,
                activityLevel: 'moderate'
            },
            showNutrientResults: false,
            nutrientNeedsResults: [],
            selectedFunctionalGoal: 'skin',

            selectedNutrientForFoods: 'vitamin_c',
            showFoodsByNutrientResults: false,
            foodsByNutrientResults: [],
            commonNutrients: [
                { value: 'vitamin_a', label: '维生素A' },
                { value: 'vitamin_c', label: '维生素C' },
                { value: 'vitamin_d', label: '维生素D' },
                { value: 'vitamin_e', label: '维生素E' },
                { value: 'vitamin_b1', label: '维生素B1' },
                { value: 'vitamin_b2', label: '维生素B2' },
                { value: 'vitamin_b6', label: '维生素B6' },
                { value: 'vitamin_b12', label: '维生素B12' },
                { value: 'calcium', label: '钙' },
                { value: 'iron', label: '铁' },
                { value: 'zinc', label: '锌' },
                { value: 'magnesium', label: '镁' },
                { value: 'potassium', label: '钾' },
                { value: 'sodium', label: '钠' },
                { value: 'fiber', label: '膳食纤维' },
                { value: 'protein', label: '蛋白质' },
                { value: 'fat', label: '脂肪' },
                { value: 'carbohydrate', label: '碳水化合物' }
            ],
            // 营养素作用数据库
            nutrientFunctions: {
                '维生素A': '维生素A是人体必需的脂溶性维生素，对维持正常视力至关重要，参与视紫红质的合成。同时，它对皮肤和黏膜的健康、骨骼生长、生殖与免疫系统功能都起着重要作用。缺乏维生素A可能导致夜盲症、干眼症和免疫力下降。',
                '维生素C': '维生素C（抗坏血酸）是人体必需的水溶性维生素，具有抗氧化、促进胶原蛋白合成、增强免疫力等核心作用。同时帮助铁元素吸收、保护心血管和皮肤健康，需通过饮食或补充剂获取。',
                '维生素D': '维生素D是一种脂溶性维生素，主要通过皮肤在阳光照射下合成。它对钙和磷的吸收与代谢、骨骼健康和免疫系统功能至关重要。充足的维生素D可以预防佝偻病、骨质疏松症，并可能降低某些慢性疾病风险。',
                '钙': '钙是人体最丰富的矿物质，主要存在于骨骼和牙齿中。它对骨骼健康、肌肉收缩、神经传导、血液凝固和酶的活化都至关重要。钙摄入不足可能导致骨质疏松、肌肉痉挛和其他健康问题。',
                '铁': '铁是人体必需的微量元素，是血红蛋白和肌红蛋白的关键成分。它参与氧气的运输、能量代谢和DNA合成。铁缺乏可导致贫血、疲劳和免疫功能下降。',
                '锌': '锌是参与200多种酶活性的必需微量元素，对免疫功能、蛋白质合成、伤口愈合、DNA合成和细胞分裂至关重要。它还支持正常生长发育和味觉感知。',
                '膳食纤维': '膳食纤维是植物性食物中不能被人体消化酶分解的部分。它能促进肠道健康、预防便秘、调节血糖水平、降低胆固醇和帮助维持健康体重。'
            },
            // 营养素食物来源数据库
            nutrientSources: {
                '维生素A': ['胡萝卜', '菠菜', '甘薯', '南瓜', '芒果', '鱼肝油', '鸡蛋', '奶制品'],
                '维生素C': ['柑橘类水果', '猕猴桃', '草莓', '辣椒', '西兰花', '西红柿', '土豆', '菠菜'],
                '维生素D': ['鱼肝油', '鲑鱼', '金枪鱼', '蛋黄', '蘑菇', '强化牛奶', '强化谷物'],
                '钙': ['牛奶', '酸奶', '奶酪', '豆腐', '杏仁', '芝麻', '绿叶蔬菜', '小鱼干'],
                '铁': ['红肉', '肝脏', '豆类', '菠菜', '南瓜籽', '贝类', '全谷物', '干果'],
                '锌': ['牡蛎', '红肉', '家禽', '豆类', '坚果', '种子', '全谷物', '奶酪'],
                '膳食纤维': ['全谷物', '豆类', '水果', '蔬菜', '坚果', '种子']
            },
            // 功能目标数据库
            functionalGoals: {
                skin: {
                    title: '皮肤健康',
                    description: '皮肤是人体最大的器官，健康的皮肤需要充足的营养支持。以下营养素对维持皮肤弹性、保湿和防护功能非常重要。',
                    nutrients: [
                        { name: '维生素A', benefit: '帮助维持皮肤细胞更新，防止皮肤干燥和角质化' },
                        { name: '维生素C', benefit: '是胶原蛋白合成的必需元素，有助于维持皮肤弹性和防止氧化损伤' },
                        { name: '维生素E', benefit: '强效抗氧化剂，保护皮肤免受自由基损害，减少皮肤老化' },
                        { name: '锌', benefit: '帮助伤口愈合和减少炎症反应，对控制痤疮有帮助' }
                    ],
                    foods: ['杏仁', '牛油果', '胡萝卜', '橙子', '南瓜籽', '鲑鱼', '菠菜', '核桃']
                },
                weight: {
                    title: '身材管理',
                    description: '健康的身材管理不仅仅是减轻体重，更在于保持肌肉质量和降低脂肪比例。以下营养素对控制体重和提升代谢率有益。',
                    nutrients: [
                        { name: '蛋白质', benefit: '增加饱腹感，保持肌肉质量，提高代谢率' },
                        { name: '膳食纤维', benefit: '增加饱腹感，减缓碳水化合物吸收，稳定血糖水平' },
                        { name: '钙', benefit: '研究表明钙摄入充足可能与较低的体脂率相关' },
                        { name: '维生素D', benefit: '帮助钙吸收，可能影响体重调节相关激素' }
                    ],
                    foods: ['瘦肉蛋白', '豆类和扁豆', '全谷物', '水果', '蔬菜', '希腊酸奶', '坚果', '燕麦']
                },
                energy: {
                    title: '精力/疲劳管理',
                    description: '保持充沛的精力需要均衡摄入宏量和微量营养素。以下营养素对能量代谢和减轻疲劳尤为重要。',
                    nutrients: [
                        { name: '铁', benefit: '是血红蛋白的关键成分，帮助携带氧气到身体各处，预防疲劳' },
                        { name: '维生素B群', benefit: '参与能量代谢过程，帮助将食物转化为能量' },
                        { name: '镁', benefit: '参与产能代谢，有助于减轻肌肉疲劳' },
                        { name: '辅酶Q10', benefit: '在细胞能量产生中发挥关键作用' }
                    ],
                    foods: ['富铁食物(瘦肉、菠菜)', '全谷物', '坚果种子', '深绿色蔬菜', '香蕉', '鱼类', '鸡蛋', '乳制品']
                },
                immune: {
                    title: '免疫力增强',
                    description: '强大的免疫系统是预防疾病的第一道防线。以下营养素对增强免疫功能尤为重要。',
                    nutrients: [
                        { name: '维生素C', benefit: '支持多种免疫细胞功能，增强抗氧化能力' },
                        { name: '维生素D', benefit: '调节免疫系统，可能预防上呼吸道感染' },
                        { name: '锌', benefit: '支持免疫细胞生长和活性，缺乏会影响免疫反应' },
                        { name: '硒', benefit: '具有抗氧化特性，支持免疫系统功能' }
                    ],
                                          foods: ['柑橘类水果', '红椒', '西兰花', '大蒜', '生姜', '蘑菇', '酸奶', '坚果和种子']
                  }
              }
        };
    },
    created() {
        this.fetchFreshData();
    },
    methods: {
        // 查询公开营养素数据
        async fetchFreshData() {
            try {
                this.tableData = [];
                // 请求参数
                const params = {
                    current: this.currentPage,
                    size: this.pageSize,
                    key: this.filterText,
                    ...this.nutrimentQueryDto
                };
                const response = await this.$axios.post('/nutriment/query', params);
                const { data } = response;
                this.tableData = data.data;
                this.totalItems = data.total;
            } catch (error) {
                this.$message.error("查询公开营养素异常");
                console.error('查询公开营养素异常:', error);
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

        showNutritionSearch() {
            this.nutritionSearchVisible = true;
        },

        showFunctionalGoals() {
            this.functionalGoalsVisible = true;
        },

        showFoodsByNutrient() {
            this.foodsByNutrientVisible = true;
        },



        viewNutrimentDetail(nutriment) {
            this.currentNutriment = nutriment;
            this.nutrimentDetailVisible = true;
        },

        searchNutrientNeeds() {
            // 根据用户输入的年龄、性别、体重等计算营养素需求
            // 通常这需要专业的营养数据库和计算公式
            this.showNutrientResults = true;
            
            // 这里使用简化版的推荐营养素摄入量
            // 实际应用中应使用完整的计算公式或从API获取
            let gender = this.nutrientSearchForm.gender;
            let age = this.nutrientSearchForm.age;
            let weight = this.nutrientSearchForm.weight;
            
            this.nutrientNeedsResults = [
                { name: '蛋白质', amount: gender === 'male' ? weight * 0.8 : weight * 0.75, unit: '克', description: '每千克体重0.75-0.8克' },
                { name: '钙', amount: age > 50 ? 1200 : 1000, unit: '毫克', description: '维持骨骼健康' },
                { name: '铁', amount: gender === 'female' && age < 50 ? 18 : 8, unit: '毫克', description: '预防贫血' },
                { name: '维生素C', amount: 75, unit: '毫克', description: '增强免疫力' },
                { name: '维生素D', amount: 15, unit: '微克', description: '促进钙吸收' },
                { name: '膳食纤维', amount: gender === 'male' ? 38 : 25, unit: '克', description: '促进肠道健康' }
            ];
        },

        handleFunctionalGoalChange(tab) {
            // 当用户选择不同功能目标时更新显示内容
            this.selectedFunctionalGoal = tab.name;
        },



        searchFoodsByNutrient() {
            // 搜索含有特定营养素的食物
            this.showFoodsByNutrientResults = true;
            
            // 获取选中的营养素标签
            const nutrientLabel = this.getSelectedNutrientLabel();
            
            // 模拟从数据库获取食物列表
            // 实际应用中应从API或数据库获取
            switch(this.selectedNutrientForFoods) {
                case 'vitamin_a':
                    this.foodsByNutrientResults = [
                        { name: '胡萝卜', amount: 835, unit: 'μg', per: '100克' },
                        { name: '甘薯', amount: 709, unit: 'μg', per: '100克' },
                        { name: '菠菜', amount: 469, unit: 'μg', per: '100克' },
                        { name: '南瓜', amount: 426, unit: 'μg', per: '100克' },
                        { name: '羽衣甘蓝', amount: 241, unit: 'μg', per: '100克' }
                    ];
                    break;
                case 'vitamin_c':
                    this.foodsByNutrientResults = [
                        { name: '鲜枣', amount: 243, unit: 'mg', per: '100克' },
                        { name: '黄椒', amount: 183.5, unit: 'mg', per: '100克' },
                        { name: '猕猴桃', amount: 92.7, unit: 'mg', per: '100克' },
                        { name: '西兰花', amount: 89.2, unit: 'mg', per: '100克' },
                        { name: '草莓', amount: 58.8, unit: 'mg', per: '100克' }
                    ];
                    break;
                case 'calcium':
                    this.foodsByNutrientResults = [
                        { name: '芝麻酱', amount: 1057, unit: 'mg', per: '100克' },
                        { name: '干紫菜', amount: 400, unit: 'mg', per: '100克' },
                        { name: '奶酪', amount: 367, unit: 'mg', per: '100克' },
                        { name: '豆腐干', amount: 350, unit: 'mg', per: '100克' },
                        { name: '牛奶', amount: 120, unit: 'mg', per: '100克' }
                    ];
                    break;
                default:
                    this.foodsByNutrientResults = [
                        { name: '请选择营养素', amount: '-', unit: '', per: '' }
                    ];
            }
        },

        getNutrimentFunction(name) {
            // 根据营养素名称获取其功能描述
            return this.nutrientFunctions[name] || '暂无相关功能信息';
        },

        getFoodSources(name) {
            // 根据营养素名称获取食物来源
            return this.nutrientSources[name] || ['暂无相关食物信息'];
        },

        getFunctionalGoalTitle() {
            // 获取当前选择的功能目标标题
            const goal = this.functionalGoals[this.selectedFunctionalGoal];
            return goal ? goal.title : '';
        },

        getFunctionalGoalDescription() {
            // 获取当前选择的功能目标描述
            const goal = this.functionalGoals[this.selectedFunctionalGoal];
            return goal ? goal.description : '';
        },

        getFunctionalGoalNutrients() {
            // 获取当前选择的功能目标相关营养素
            const goal = this.functionalGoals[this.selectedFunctionalGoal];
            return goal ? goal.nutrients : [];
        },

        getFunctionalGoalFoods() {
            // 获取当前选择的功能目标推荐食物
            const goal = this.functionalGoals[this.selectedFunctionalGoal];
            return goal ? goal.foods : [];
        },



        getSelectedNutrientLabel() {
            // 获取当前选择的营养素标签
            const nutrient = this.commonNutrients.find(n => n.value === this.selectedNutrientForFoods);
            return nutrient ? nutrient.label : '';
        },

        getActivityLevelLabel() {
            // 获取活动水平标签
            const activityLevel = this.nutrientSearchForm.activityLevel;
            switch(activityLevel) {
                case 'sedentary':
                    return '久坐不动';
                case 'light':
                    return '轻度活动';
                case 'moderate':
                    return '中度活动';
                case 'active':
                    return '重度活动';
                case 'very_active':
                    return '非常活跃';
                default:
                    return '未知活动水平';
            }
        },

        getNutrientIcon(nutrient) {
            // 根据营养素获取对应的图标
            const icons = {
                vitamin_a: 'el-icon-vitamin-a',
                vitamin_c: 'el-icon-vitamin-c',
                vitamin_d: 'el-icon-vitamin-d',
                vitamin_e: 'el-icon-vitamin-e',
                vitamin_b1: 'el-icon-vitamin-b1',
                vitamin_b2: 'el-icon-vitamin-b2',
                vitamin_b6: 'el-icon-vitamin-b6',
                vitamin_b12: 'el-icon-vitamin-b12',
                calcium: 'el-icon-calcium',
                iron: 'el-icon-iron',
                zinc: 'el-icon-zinc',
                magnesium: 'el-icon-magnesium',
                potassium: 'el-icon-potassium',
                sodium: 'el-icon-sodium',
                fiber: 'el-icon-fiber',
                protein: 'el-icon-protein',
                fat: 'el-icon-fat',
                carbohydrate: 'el-icon-carbohydrate'
            };
            return icons[nutrient] || 'el-icon-question';
        },

        getNutrientDescription(nutrient) {
            // 根据营养素获取描述
            const descriptions = {
                vitamin_a: '维生素A是人体必需的脂溶性维生素，对维持正常视力至关重要，参与视紫红质的合成。同时，它对皮肤和黏膜的健康、骨骼生长、生殖与免疫系统功能都起着重要作用。缺乏维生素A可能导致夜盲症、干眼症和免疫力下降。',
                vitamin_c: '维生素C（抗坏血酸）是人体必需的水溶性维生素，具有抗氧化、促进胶原蛋白合成、增强免疫力等核心作用。同时帮助铁元素吸收、保护心血管和皮肤健康，需通过饮食或补充剂获取。',
                vitamin_d: '维生素D是一种脂溶性维生素，主要通过皮肤在阳光照射下合成。它对钙和磷的吸收与代谢、骨骼健康和免疫系统功能至关重要。充足的维生素D可以预防佝偻病、骨质疏松症，并可能降低某些慢性疾病风险。',
                calcium: '钙是人体最丰富的矿物质，主要存在于骨骼和牙齿中。它对骨骼健康、肌肉收缩、神经传导、血液凝固和酶的活化都至关重要。钙摄入不足可能导致骨质疏松、肌肉痉挛和其他健康问题。',
                iron: '铁是人体必需的微量元素，是血红蛋白和肌红蛋白的关键成分。它参与氧气的运输、能量代谢和DNA合成。铁缺乏可导致贫血、疲劳和免疫功能下降。',
                zinc: '锌是参与200多种酶活性的必需微量元素，对免疫功能、蛋白质合成、伤口愈合、DNA合成和细胞分裂至关重要。它还支持正常生长发育和味觉感知。',
                fiber: '膳食纤维是植物性食物中不能被人体消化酶分解的部分。它能促进肠道健康、预防便秘、调节血糖水平、降低胆固醇和帮助维持健康体重。'
            };
            return descriptions[nutrient] || '暂无相关描述信息';
        },

        getFoodTips(nutrient) {
            // 根据营养素获取食物食用建议
            const tips = {
                vitamin_a: '维生素A主要来源于动物性食物，如肝脏、鱼类和奶制品。过量摄入可能导致中毒，建议每天不超过1000μg（视黄醇当量）。',
                vitamin_c: '维生素C主要来源于新鲜水果和蔬菜。过量摄入可能导致腹泻，建议每天不超过2000mg。',
                vitamin_d: '维生素D主要来源于阳光照射和食物。过量摄入可能导致中毒，建议每天不超过4000IU。',
                vitamin_e: '维生素E主要来源于植物性食物。过量摄入可能导致中毒，建议每天不超过1500IU。',
                vitamin_b1: '维生素B1主要来源于全谷物、豆类和瘦肉。过量摄入可能导致中毒，建议每天不超过2.5mg。',
                vitamin_b2: '维生素B2主要来源于动物性食物和全谷物。过量摄入可能导致中毒，建议每天不超过2.5mg。',
                vitamin_b6: '维生素B6主要来源于全谷物、豆类和瘦肉。过量摄入可能导致中毒，建议每天不超过2.5mg。',
                vitamin_b12: '维生素B12主要来源于动物性食物和强化食品。过量摄入可能导致中毒，建议每天不超过2.5μg。',
                calcium: '钙主要来源于牛奶、酸奶、奶酪和绿叶蔬菜。过量摄入可能导致肾结石，建议每天不超过2000mg。',
                iron: '铁主要来源于红肉、肝脏和豆类。过量摄入可能导致便秘和消化不良，建议每天不超过45mg。',
                zinc: '锌主要来源于瘦肉、肝脏和全谷物。过量摄入可能导致铜缺乏，建议每天不超过40mg。',
                magnesium: '镁主要来源于绿叶蔬菜、全谷物和坚果。过量摄入可能导致腹泻，建议每天不超过400mg。',
                potassium: '钾主要来源于香蕉、土豆和绿叶蔬菜。过量摄入可能导致腹泻，建议每天不超过5600mg。',
                sodium: '钠主要来源于食盐。过量摄入可能导致高血压，建议每天不超过2300mg。',
                fiber: '膳食纤维主要来源于全谷物、豆类和水果。过量摄入可能导致消化不良，建议每天摄入25-35g。',
                protein: '蛋白质主要来源于瘦肉、鱼类、豆类和奶制品。过量摄入可能导致肾脏负担，建议每天不超过1.2g/kg体重。',
                fat: '脂肪主要来源于动物性食物和植物油。过量摄入可能导致肥胖和心血管疾病，建议每天摄入20-35%的能量。',
                carbohydrate: '碳水化合物主要来源于全谷物、豆类和水果。过量摄入可能导致肥胖和糖尿病，建议每天摄入50-100g。'
            };
            return tips[nutrient] || '暂无相关食用建议';
        },

        getPercentageForFood(food) {
            // 根据食物含量计算百分比
            const nutrient = this.commonNutrients.find(n => n.value === this.selectedNutrientForFoods);
            if (nutrient) {
                const amount = food.amount;
                const unit = food.unit;
                const nutrientAmount = nutrient.value === 'calcium' ? amount * 1000 : amount;
                const totalAmount = this.foodsByNutrientResults.reduce((total, f) => total + (f.amount * 1000), 0);
                return (nutrientAmount / totalAmount) * 100;
            }
            return 0;
        },

        getProgressColor(percentage) {
            // 根据百分比获取进度条颜色
            if (percentage < 30) {
                return '#409EFF';
            } else if (percentage < 60) {
                return '#67C23A';
            } else {
                return '#F56C6C';
            }
        },


    }
};
</script>

<style scoped lang="scss">
/* 通用样式 */
.nutriment-detail-dialog {
    .el-dialog__header {
        padding: 0;
    }
    .el-dialog__body {
        padding: 0;
    }
}

/* 自定义按钮样式 */
.nutriment-button {
    border-radius: 20px;
    padding: 8px 16px;
    font-weight: 500;
    transition: all 0.3s;
    border: none;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 14px;
    
    i {
        font-size: 16px;
    }

    span {
        font-size: 14px;
        white-space: nowrap;
    }
    
    &:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.15);
    }
    
    &:active {
        transform: translateY(0);
    }
}

.primary-button {
    background: linear-gradient(135deg, #409EFF, #64B5F6);
    color: white;
    
    &:hover {
        background: linear-gradient(135deg, #64B5F6, #409EFF);
    }
}

.success-button {
    background: linear-gradient(135deg, #67C23A, #8BC34A);
    color: white;
    
    &:hover {
        background: linear-gradient(135deg, #8BC34A, #67C23A);
    }
}

.warning-button {
    background: linear-gradient(135deg, #E6A23C, #FFB74D);
    color: white;
    
    &:hover {
        background: linear-gradient(135deg, #FFB74D, #E6A23C);
    }
}

.nutriment-detail-header {
    background: linear-gradient(135deg, #409EFF, #67C23A);
    padding: 20px;
    color: white;
    border-radius: 8px 8px 0 0;
}

.nutriment-detail-title {
    margin: 0;
    font-size: 24px;
    font-weight: 600;
}

.nutriment-detail-subtitle {
    margin: 5px 0 0;
    font-size: 14px;
    opacity: 0.8;
}

.form-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 20px;
}

.form-row {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

.result-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.result-header {
    background-color: #f5f7fa;
    padding: 15px;
    border-bottom: 1px solid #ebeef5;
}

.result-header h3 {
    margin: 0;
    color: #303133;
}

.result-body {
    padding: 15px;
}

.result-footer {
    padding: 10px 15px;
    border-top: 1px solid #ebeef5;
    background-color: #f5f7fa;
}

.result-note {
    color: #909399;
    font-size: 12px;
    margin: 0;
}

.user-info-summary {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    margin-top: 10px;
}

.info-item {
    display: flex;
    align-items: center;
    gap: 5px;
    color: #606266;
    font-size: 14px;
}

.highlight {
    color: #409EFF;
    font-weight: bold;
}

.section-title {
    display: flex;
    align-items: center;
    gap: 8px;
    color: #303133;
    margin-bottom: 15px;
    padding-bottom: 8px;
    border-bottom: 1px dashed #ebeef5;
}

.section-title i {
    color: #409EFF;
}

.amount-cell {
    display: flex;
    align-items: center;
    gap: 5px;
}

.amount-value {
    font-weight: bold;
}

.amount-unit {
    color: #909399;
    font-size: 12px;
}

/* 营养素详情相关样式 */
.nutriment-detail-container {
    padding: 20px;
}

.nutriment-info {
    margin-bottom: 20px;
}

.nutriment-name {
    font-size: 24px;
    color: #303133;
    margin-bottom: 10px;
}

.nutriment-description {
    color: #606266;
    margin-bottom: 15px;
}

.nutriment-properties {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    margin-bottom: 20px;
}

.property-item {
    background-color: #f5f7fa;
    padding: 10px 15px;
    border-radius: 4px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.property-label {
    color: #909399;
    font-size: 12px;
}

.property-value {
    color: #303133;
    font-weight: bold;
}

.food-sources {
    margin-bottom: 20px;
}

.food-sources-title {
    font-size: 18px;
    color: #303133;
    margin-bottom: 15px;
}

.food-sources-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}

.food-source-item {
    background-color: #ecf5ff;
    color: #409EFF;
    padding: 8px 12px;
    border-radius: 4px;
}

/* 营养素需求查询相关样式 */
.nutrition-search-container {
    padding: 20px;
}

.nutrition-search-form {
    margin-bottom: 20px;
}

.nutrition-search-results {
    margin-top: 20px;
}

/* 营养素功能目标相关样式 */
.functional-goals-container {
    padding: 20px;
}

.functional-goals-selection {
    margin-bottom: 20px;
}

.functional-goals-results {
    margin-top: 20px;
}

.goal-header {
    margin-bottom: 20px;
}

.goal-description {
    color: #606266;
    margin-top: 10px;
    line-height: 1.6;
}

.goal-section {
    margin-bottom: 30px;
}

.nutrient-cards-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 15px;
    margin-bottom: 20px;
}

.nutrient-card {
    background-color: white;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.food-cards-container {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 20px;
}

.food-card {
    background-color: #ecf5ff;
    color: #409EFF;
    padding: 8px 15px;
    border-radius: 4px;
    display: flex;
    align-items: center;
}

.health-tips {
    background-color: #f5f7fa;
    padding: 15px;
    border-radius: 8px;
    color: #606266;
}

.health-tips ul {
    padding-left: 20px;
    margin: 10px 0 0;
}

.health-tips li {
    margin-bottom: 5px;
}

/* 食物营养素查询相关样式 */
.foods-by-nutrient-container {
    padding: 20px;
}

.foods-by-nutrient-selection {
    margin-bottom: 20px;
}

.foods-by-nutrient-results {
    margin-top: 20px;
}

.nutrient-info {
    display: flex;
    align-items: center;
    gap: 15px;
}

.nutrient-icon {
    width: 50px;
    height: 50px;
    background-color: #ecf5ff;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #409EFF;
    font-size: 24px;
}

.nutrient-details {
    flex: 1;
}

.nutrient-description {
    color: #606266;
    font-size: 14px;
    margin-top: 5px;
    line-height: 1.6;
}

.food-tips {
    margin-top: 10px;
}

.food-tips h4 {
    display: flex;
    align-items: center;
    gap: 8px;
    color: #303133;
    margin-top: 0;
    margin-bottom: 10px;
}

.food-tips p {
    color: #606266;
    font-size: 14px;
    line-height: 1.6;
    margin: 0;
}

/* 调整日期选择器内的文本位置 */
.el-date-editor .el-range-input {
    font-size: 14px;
    display: inline-block;
    width: 39%;
    height: 100%;
    line-height: 36px;
    margin: 0;
    padding: 0 3px;
    text-align: center;
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

/* 特别修复PublicNutriment搜索框图标位置 */
.el-input-group__append .el-button {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0;
    width: 30px;
    height: 100%;
}

.el-input-group__append .el-button i {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
    font-size: 16px;
    margin: 0;
}

/* 确保按钮内的图标对齐 */
.el-button [class*="el-icon-"] + span {
    margin-left: 5px;
}

/* 提高选择器优先级，确保样式生效 */
.el-input-group__append.el-input-group__append {
    padding: 0;
    display: flex;
    align-items: center;
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

.el-date-editor .el-range-separator {
    padding: 0 5px;
    line-height: 32px;
    color: #909399;
}

.el-date-editor .el-range__icon, 
.el-date-editor .el-range__close-icon {
    line-height: 24px;
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

</style> 