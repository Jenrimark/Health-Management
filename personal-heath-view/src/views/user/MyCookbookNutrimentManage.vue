<template>
    <el-row style="background-color: #FFFFFF;padding: 5px 0;border-radius: 5px;">
        <el-row style="padding: 10px;margin-left: 5px;">
            <el-row style="display: flex;justify-content: left;gap: 6px;">
                <span class="edit-button" @click="add()">
                    新增食谱配置
                </span>
            </el-row>
        </el-row>
        <el-row style="margin: 0 22px;border-top: 1px solid rgb(245,245,245);">
            <el-table :stripe="true" :data="tableData">
                <el-table-column prop="cookbookId" :sortable="true" width="120" label="食谱ID"></el-table-column>
                <el-table-column prop="nutrimentId" :sortable="true" width="120" label="营养素ID"></el-table-column>
                <el-table-column prop="cookbookName" label="食谱"></el-table-column>
                <el-table-column prop="nutrimentName" width="120" label="营养项"></el-table-column>
                <el-table-column prop="nutrimentUnit" width="130" label="营养素单位"></el-table-column>
                <el-table-column prop="g100Value" width="170" label="每100g中含量"></el-table-column>
                <el-table-column label="操作" width="110">
                    <template slot-scope="scope">
                        <span class="text-button" @click="handleEdit(scope.row)">编辑</span>
                        <span class="text-button" @click="handleDelete(scope.row)">删除</span>
                    </template>
                </el-table-column>
            </el-table>
        </el-row>
        <!-- 操作面板 -->
        <el-dialog :show-close="false" :visible.sync="dialogCategoryOperaion" width="18%">
            <div style="padding:16px 20px;">
                <p>{{ isOperation ? '修改营养素信息' : '配置营养素' }}</p>
                <el-row>
                    <span class="dialog-hover">选食谱</span>
                    <el-select style="width: 160px;" @change="fetchFreshData" size="small" v-model="data.cookbookId"
                        placeholder="食谱">
                        <el-option v-for="item in cookbookItems" :key="item.id" :label="item.name" :value="item.id">
                        </el-option>
                    </el-select>
                </el-row>
                <el-row>
                    <span class="dialog-hover">营养素</span>
                    <el-select style="width: 160px;" @change="fetchFreshData" size="small" v-model="data.nutrimentId"
                        placeholder="营养素">
                        <el-option v-for="item in nutrimentItems" :key="item.id" :label="item.name" :value="item.id">
                        </el-option>
                    </el-select>
                </el-row>
                <el-row>
                    <span class="dialog-hover">每100g中值含量</span>
                    <input class="dialog-input" v-model="data.g100Value" placeholder="输入" />
                </el-row>
            </div>
            <span slot="footer" class="dialog-footer" style="margin-top: 10px;">
                <span class="channel-button" @click="cannel()">
                    取消操作
                </span>
                <span v-if="!isOperation" class="edit-button" @click="addOperation()">
                    确定新增
                </span>
                <span v-else class="edit-button" @click="updateOperation()">
                    确定修改
                </span>
            </span>
        </el-dialog>
    </el-row>
</template>

<script>
export default {
    data() {
        return {
            data: {},
            filterText: '',
            currentPage: 1,
            pageSize: 20,
            totalItems: 0,
            dialogCategoryOperaion: false, // 开关
            isOperation: false, // 默认新增
            tableData: [],
            delectedRows: [],
            cookbookNutrimentQueryDto: {}, // 搜索条件
            cookbookItems: [],
            nutrimentItems: []
        };
    },
    created() {
        this.fetchCookBookListItem();
        this.fetchNutrimentListItem();
        this.fetchFreshData();
    },
    methods: {
        // 食谱下拉选择器数据
        async fetchCookBookListItem() {
            try {
                const response = await this.$axios.get(`/cookbook/querySelectedItemsUser`);
                if (response.data.code === 200) {
                    this.cookbookItems = response.data.data;
                    
                }
            } catch (error) {
                console.log(error);
            }
        },
        // 营养素下拉选择器数据
        async fetchNutrimentListItem() {
            try {
                const response = await this.$axios.get(`/nutriment/querySelectedItemsUser`);
                if (response.data.code === 200) {
                    // 获取原始数据
                    const originalItems = response.data.data;
                    
                    // 用于存储去重后的结果
                    const uniqueNutriments = new Map();
                    
                    // 处理每个营养素项
                    originalItems.forEach(item => {
                        // 移除前缀（"私人营养素 - "或"公开营养素 - "）
                        const originalName = item.name;
                        let cleanName = originalName;
                        
                        if (originalName.startsWith('私人营养素 - ')) {
                            cleanName = originalName.substring('私人营养素 - '.length);
                        } else if (originalName.startsWith('公开营养素 - ')) {
                            cleanName = originalName.substring('公开营养素 - '.length);
                        }
                        
                        // 使用清洁后的名称作为键，优先保留私人营养素
                        if (!uniqueNutriments.has(cleanName) || originalName.startsWith('私人营养素 - ')) {
                            // 创建新对象，使用原始ID但清洁后的名称
                            uniqueNutriments.set(cleanName, {
                                id: item.id,
                                name: cleanName
                            });
                        }
                    });
                    
                    // 转换回数组形式
                    this.nutrimentItems = Array.from(uniqueNutriments.values());
                }
            } catch (error) {
                console.log(error);
            }
        },
        cannel() {
            this.data = {};
            this.dialogCategoryOperaion = false;
            this.isOperation = false;
        },
        // 批量删除数据
        async batchDelete() {
            if (!this.delectedRows.length) {
                this.$message(`未选中任何数据`);
                return;
            }
            const confirmed = await this.$swalConfirm({
                title: '删除食谱营养素关联数据',
                text: `删除后不可恢复，是否继续？`,
                icon: 'warning',
            });
            if (confirmed) {
                try {
                    let ids = this.delectedRows.map(entity => entity.id);
                    const response = await this.$axios.post(`/cookbookNutriment/batchDelete`, ids);
                    if (response.data.code === 200) {
                        this.$notify({
                            duration: 1000,
                            title: '信息删除',
                            message: '删除成功',
                            type: 'success'
                        });
                        this.fetchFreshData();
                        return;
                    }
                } catch (error) {
                    this.$message.error("食谱营养素关联信息删除异常：", error);
                    console.error(`食谱营养素关联信息删除异常：`, error);
                }
            }
        },
        // 修改信息
        async updateOperation() {
            try {
                const response = await this.$axios.put('/cookbookNutriment/update', this.data);
                if (response.data.code === 200) {
                    this.$notify({
                        duration: 1000,
                        title: '信息修改',
                        message: '修改成功',
                        type: 'success'
                    });
                    this.cannel();
                    this.fetchFreshData();
                }
            } catch (error) {
                console.error('修改出错:', error);
            }
        },
        // 信息新增
        async addOperation() {
            try {
                const response = await this.$axios.post('/cookbookNutriment/save', this.data);
                if (response.data.code === 200) {
                    this.$notify({
                        duration: 1000,
                        title: '配置新增',
                        message: '新增成功',
                        type: 'success'
                    });
                    this.cannel();
                    this.fetchFreshData();
                } else {
                    this.$notify({
                        duration: 1000,
                        title: '配置新增',
                        message: response.data.msg,
                        type: 'error'
                    });
                }
            } catch (error) {
                console.error('信息新增出错:', error);
                this.$message.error('提交失败，请稍后再试！');
            }
        },
        // 信息查询
        async fetchFreshData() {
            try {
                const response = await this.$axios.post('/cookbookNutriment/queryUser');
                const { data } = response;
                this.tableData = data.data;
            } catch (error) {
                this.$message.error("查询食谱营养素关联信息异常:", error);
                console.error('查询食谱营养素关联信息异常:', error);
            }
        },
        add() {
            this.dialogCategoryOperaion = true;
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
        // 食谱营养素关联修改按钮点击事件 
        handleEdit(row) {
            this.dialogCategoryOperaion = true;
            this.isOperation = true;
            this.data = { ...row }
        },
        // 食谱营养素关联修改按钮删除事件 
        handleDelete(row) {
            this.delectedRows.push(row);
            this.batchDelete();
        }
    },
};
</script>

<style>
.dialog-hover {
    display: inline-block;
    width: 100px;
    text-align: right;
    margin-right: 10px;
}

.dialog-input {
    width: 160px;
    height: 30px;
    padding: 0 10px;
}

.dialog-footer {
    margin-block: 10px;
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
    margin-right: 10px;
}

.channel-button {
    border: 1px solid #dcdfe6;
    background-color: #fff;
    color: #606266;
}

.channel-button:hover {
    color: #409EFF;
    border-color: #c6e2ff;
    background-color: #ecf5ff;
}

.edit-button {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 16px;
  border: none;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 500;
  background: linear-gradient(135deg, #0f753f 0%, #2eab60 100%);
  color: white;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 10px rgba(15, 117, 63, 0.2);
  min-width: 120px;
  height: 32px;
  letter-spacing: 0.5px;
  position: relative;
  overflow: hidden;
}

.edit-button::before {
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

.edit-button:hover {
  background: linear-gradient(135deg, #2eab60 0%, #0f753f 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 15px rgba(15, 117, 63, 0.3);
}

.edit-button:hover::before {
  transform: translateX(0);
}

.edit-button:active {
  transform: translateY(0);
  box-shadow: 0 2px 6px rgba(15, 117, 63, 0.25);
}

.text-button {
    color: #409EFF;
    cursor: pointer;
    display: inline-block;
    width: 50px;
    margin-bottom: 8px;
}
</style>