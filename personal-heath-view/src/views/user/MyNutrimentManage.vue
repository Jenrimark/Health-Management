<template>
    <el-row style="background-color: #FFFFFF;padding: 5px 0;border-radius: 5px;">
        <el-row style="padding: 10px;margin-left: 5px;">
            <el-row style="display: flex;justify-content: left;gap: 6px;">
                <span class="edit-button" @click="add()">
                    配置营养素
                </span>
                <el-date-picker style="width: 216px;" @change="fetchFreshData" size="small" v-model="searchTime"
                    type="daterange" range-separator="至" start-placeholder="创建开始" end-placeholder="创建结束">
                </el-date-picker>
                <el-input size="small" style="width: 166px;" v-model="nutrimentQueryDto.name" placeholder="营养素名"
                    clearable @clear="handleFilterClear">
                    <el-button slot="append" @click="handleFilter" icon="el-icon-search"></el-button>
                </el-input>
            </el-row>
        </el-row>
        <el-row style="margin: 0 22px;border-top: 1px solid rgb(245,245,245);">
            <el-table :stripe="true" :data="tableData" style="width: 100%">
                <el-table-column prop="name" label="营养素名"></el-table-column>
                <el-table-column prop="detail" label="描述" width="468"></el-table-column>
                <el-table-column prop="unit" label="单位" width="108"></el-table-column>
                <el-table-column prop="isPublish" label="是否公开" width="118">
                    <template slot-scope="scope">
                        <span>{{ scope.row.isPublish ? '公开' : '私人' }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="createTime" label="创建时间" :sortable="true" width="168"></el-table-column>
                <el-table-column label="操作" width="110">
                    <template slot-scope="scope">
                        <span class="text-button" @click="handleEdit(scope.row)">修改</span>
                        <span class="text-button" @click="handleDelete(scope.row)">删除</span>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination style="margin:10px 0;float: right;" @size-change="handleSizeChange"
                @current-change="handleCurrentChange" :current-page="currentPage" :page-sizes="[20, 50]"
                :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                :total="totalItems"></el-pagination>
        </el-row>
        <el-dialog :show-close="false" :visible.sync="dialogNutrimentOperaion" width="25%">
            <div style="padding:16px 20px;">
                <p>{{ isOperation ? '营养素修改' : '营养素新增' }}</p>
                <div>
                    <span class="dialog-hover">*单位</span>
                    <input class="dialog-input" v-model="data.name" placeholder="营养素名称" />
                </div>
                <div>
                    <span class="dialog-hover">*单位</span>
                    <input class="dialog-input" v-model="data.unit" placeholder="单位" />
                </div>
                <div>
                    <span class="dialog-hover">*描述</span>
                    <el-input type="textarea" :rows="3" placeholder="用一句话描述这项配置吧" v-model="data.detail">
                    </el-input>
                </div>
                <div style="margin-top: 15px; display: flex; align-items: center;">
                    <span class="dialog-hover" style="margin-right: 10px;">是否公开</span>
                    <el-switch
                        v-model="data.isPublish"
                        active-color="#13ce66"
                        inactive-color="#ff4949"
                        active-text="公开"
                        inactive-text="私有">
                    </el-switch>
                </div>
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
            tableData: [],
            delectedRows: [],
            searchTime: [],
            dialogNutrimentOperaion: false,
            isOperation: false,
            nutrimentQueryDto: {}, // 搜索条件
            publishStatus: [{ value: null, label: '全部' }, { value: 0, label: '私人' }, { value: 1, label: '公开' }],
        };
    },
    created() {
        this.fetchFreshData();
    },
    methods: {
       addOperation() {
    // 验证必填字段
    if (!this.data.name || !this.data.unit) {
        this.$notify({
            duration: 1000,
            title: '营养素操作',
            message: '请填写所有必填字段（名称、单位）',
            type: 'error'
        });
        return;
    }
    
    this.$axios.post('/nutriment/save', this.data).then(res => {
        if (res.data.code === 200) {
            this.$notify({
                duration: 1000,
                title: '营养素操作',
                message: '新增成功',
                type: 'success'
            });
            this.cannel();
            this.fetchFreshData();
        }
    }).catch(error => {
        console.log("新增营养素异常：", error);
    });
},
updateOperation() {
    // 验证必填字段
    if (!this.data.name || !this.data.unit) {
        this.$notify({
            duration: 1000,
            title: '营养素操作',
            message: '请填写所有必填字段（名称、单位）',
            type: 'error'
        });
        return;
    }
    
    this.$axios.put('/nutriment/update', this.data).then(res => {
        if (res.data.code === 200) {
            this.$notify({
                duration: 1000,
                title: '营养素操作',
                message: '修改成功',
                type: 'success'
            });
            this.cannel();
            this.fetchFreshData();
        }
    }).catch(error => {
        console.log("修改营养素异常：", error);
    });
},
        cannel() {
            this.dialogNutrimentOperaion = false;
            this.isOperation = false;
            this.data = {};
        },
        add() {
            this.dialogNutrimentOperaion = true;
            this.data = { isPublish: false }; // 设置默认为私有
        },
        // 批量删除数据
       // 修改批量删除方法
async batchDelete() {
    if (!this.delectedRows.length) {
        this.$message(`未选中任何数据`);
        return;
    }
    
    // 检查所有选中项是否为私人营养素
    const hasPublicItems = this.delectedRows.some(row => row.isPublish);
    if (hasPublicItems) {
        this.$message.error('只能删除私人营养素');
        return;
    }

    const confirmed = await this.$swalConfirm({
        title: '删除营养素数据',
        text: `删除后不可恢复，是否继续？`,
        icon: 'warning',
    });
    
    if (confirmed) {
        try {
            let ids = this.delectedRows.map(entity => entity.id);
            const response = await this.$axios.post(`/nutriment/delete`, ids);
            
            if (response.data.code === 200) {
                this.$notify({
                    duration: 1000,
                    title: '信息删除',
                    message: response.data.message || '删除成功',
                    type: 'success'
                });
                this.delectedRows = []; // 清空选中项
                this.fetchFreshData(); // 刷新数据
            } else {
                this.$message.error(response.data.message || '删除失败');
            }
} catch (error) {
  const errorMsg = (error.response && error.response.data && error.response.data.message) || "营养素删除异常";
  this.$message.error(errorMsg);
  console.error('营养素删除异常:', error);
}
    }
},
        // 信息查询
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
                    ...this.nutrimentQueryDto
                };
                const response = await this.$axios.post('/nutriment/queryUser', params);
                const { data } = response;
                this.tableData = data.data;
                this.totalItems = data.total;
            } catch (error) {
                this.$message.error("查询营养素异常:", error);
                console.error('查询营养素异常:', error);
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
        handleEdit(row) {
            this.data = row;
            this.dialogNutrimentOperaion = true;
            this.isOperation = true;
        },
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