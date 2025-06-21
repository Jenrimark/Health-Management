<template>
    <el-row style="background-color: #FFFFFF;padding: 5px 0;border-radius: 5px;">
        <el-row style="padding: 10px;margin-left: 5px;">
            <el-row style="display: flex;justify-content: left;gap: 6px;">
                <el-select style="width: 100px;" @change="fetchFreshData" size="small"
                    v-model="cookbookQueryDto.categoryId" placeholder="菜系">
                    <el-option v-for="item in categories" :key="item.id" :label="item.name" :value="item.id">
                    </el-option>
                </el-select>
                <el-date-picker style="width: 216px;" @change="fetchFreshData" size="small" v-model="searchTime"
                    type="daterange" range-separator="至" start-placeholder="发布开始" end-placeholder="发布结束">
                </el-date-picker>
                <el-input size="small" style="width: 166px;" v-model="cookbookQueryDto.title" placeholder="美食名"
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
        <el-dialog :visible.sync="dialogVisible" title="食谱详情" width="60%">
            <div v-if="currentCookbook">
                <div class="cookbook-header">
                    <img :src="currentCookbook.cover" class="cookbook-cover" v-if="currentCookbook.cover">
                    <div class="cookbook-title">
                        <h2>{{currentCookbook.title}}</h2>
                        <div class="cookbook-meta">
                            <span>分类：{{currentCookbook.categoryName}}</span>
                            <span>发布者：{{currentCookbook.userName}}</span>
                            <span>发布时间：{{currentCookbook.createTime}}</span>
                        </div>
                    </div>
                </div>
                <div class="cookbook-content" v-html="currentCookbook.content"></div>
            </div>
        </el-dialog>

        <!-- 营养素弹窗 -->
        <el-dialog :visible.sync="nutrimentDialogVisible" title="食谱营养素信息" width="50%">
            <el-table :data="cookbookNutrimentList" border style="width: 100%">
                <el-table-column prop="nutrimentName" label="营养素名称" width="180"></el-table-column>
                <el-table-column prop="g100Value" label="每100g含量"></el-table-column>
                <el-table-column prop="nutrimentUnit" label="单位"></el-table-column>
            </el-table>
            <div v-if="cookbookNutrimentList.length === 0" style="text-align: center; padding: 20px;">
                该食谱暂无营养素信息
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
                path: '/user/createGourmet',
                query: { id: cookbook.id }
            });
        },
        
        // 删除食谱
        deleteCookbook(cookbook) {
            // 检查是否是当前用户的食谱
            if (cookbook.userId !== this.currentUserId) {
                this.$message.warning("只能删除自己创建的食谱");
                return;
            }
            
            this.$confirm('确定要删除这个食谱吗？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$axios.post('/cookbook/batchDelete', [cookbook.id]).then(res => {
                    if (res.data.code === 200) {
                        this.$notify({
                            duration: 1000,
                            title: '信息删除',
                            message: '删除成功',
                            type: 'success'
                        });
                        this.fetchFreshData();
                    } else {
                        this.$message.error(res.data.message || "删除失败");
                    }
                }).catch(error => {
                    this.$message.error("删除异常");
                    console.error('删除食谱异常:', error);
                });
            }).catch(() => {
                // 取消删除操作
            });
        },
        
        // 查询食谱营养素关联数据
        fetchCookbookNutrimentData(cookbookId) {
            const cookbookNutrimentQueryDto = { cookbookId }
            this.$axios.post('/cookbookNutriment/query', cookbookNutrimentQueryDto).then(res => {
                if (res.data.code === 200) {
                    this.cookbookNutrimentList = res.data.data;
                }
            }).catch(error => {
                console.log("查询食谱营养素关联信息异常：", error);
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
        }
    }
};
</script>

<style scoped>
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
</style> 