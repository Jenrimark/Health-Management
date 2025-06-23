<template>
    <el-row style="background-color: #FFFFFF;padding: 5px 0;border-radius: 5px;">
        <el-row style="padding: 10px;margin-left: 5px;">
            <el-row>
                <el-input size="small" style="width: 188px;margin-left: 5px;margin-right: 6px;"
                    v-model="healthModelConfigQueryDto.name" placeholder="配置名" clearable @clear="handleFilterClear">
                    <el-button slot="append" @click="handleFilter" icon="el-icon-search"></el-button>
                </el-input>
                <span style="float: right;">
                    <el-button size="small"
                        style="background-color: rgb(96, 98, 102);color: rgb(247,248,249);border: none;"
                        class="customer" type="info" @click="add()"><i class="el-icon-plus"></i>新增模型</el-button>
                </span>
            </el-row>
        </el-row>
        <el-row style="margin: 0 20px;border-top: 1px solid rgb(245,245,245);">
            <el-table row-key="id" @selection-change="handleSelectionChange" :data="tableData" style="width: 100%">
                <el-table-column prop="cover" width="80" label="模型图">
                    <template slot-scope="scope">
                        <img :src="scope.row.cover" style="width: 30px;height: 30px;border-radius: 5px;" />
                    </template>
                </el-table-column>
                <el-table-column prop="name" width="218" label="模型名"></el-table-column>
                <el-table-column prop="isGlobal" label="权限" width="128">
                    <template slot-scope="scope">
                        <span>{{ scope.row.isGlobal ? '全局模型' : '私有模型' }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="userName" width="108" label="配置用户"></el-table-column>
                <el-table-column prop="valueRange" width="128" label="值范围"></el-table-column>
                <el-table-column prop="unit" width="88" label="单位"></el-table-column>
                <el-table-column prop="symbol" width="88" label="符号"></el-table-column>
                <el-table-column prop="detail" label="模型介绍"></el-table-column>
                <el-table-column label="操作" width="120">
                    <template slot-scope="scope">
                        <span class="text-button" @click="handleEdit(scope.row)">编辑</span>
                        <span class="text-button" @click="handleDelete(scope.row)">删除</span>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination style="margin: 20px 0;" @size-change="handleSizeChange" @current-change="handleCurrentChange"
                :current-page="currentPage" :page-sizes="[10, 20]" :page-size="pageSize"
                layout="total, sizes, prev, pager, next, jumper" :total="totalItems"></el-pagination>
        </el-row>
        <!-- 健康模型新增/修改弹窗 -->
        <el-dialog :visible.sync="dialogUserOperaion" width="35%" :show-close="true" custom-class="model-dialog">
            <div slot="title" class="dialog-title">
                <h3>{{ !isOperation ? '健康模型新增' : '健康模型修改' }}</h3>
                <p class="dialog-subtitle">{{ !isOperation ? '添加新的健康指标监测模型' : '更新已有健康指标模型' }}</p>
            </div>
            <div class="model-form">
                <div class="form-group">
                    <label class="form-label required">图标</label>
                    <div class="upload-wrapper">
                        <el-upload 
                            class="avatar-uploader" 
                            action="http://localhost:8080/api/personal-heath/v1.0/file/upload"
                            :show-file-list="false" 
                            :on-success="handleAvatarSuccess">
                            <img v-if="data.cover" :src="data.cover" class="avatar">
                            <div v-else class="upload-placeholder">
                                <i class="el-icon-plus"></i>
                                <p>点击上传</p>
                            </div>
                        </el-upload>
                        <div v-if="data.cover" class="upload-actions">
                            <el-button size="mini" type="text" icon="el-icon-refresh" @click="data.cover = ''">
                                重新上传
                            </el-button>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">配置名</label>
                    <el-input 
                        v-model="data.name" 
                        placeholder="请输入配置名" 
                        class="enhanced-input"
                        prefix-icon="el-icon-edit">
                    </el-input>
                </div>
                
                <div class="form-group form-row">
                    <div class="form-col">
                        <label class="form-label required">单位</label>
                        <el-input 
                            v-model="data.unit" 
                            placeholder="请输入单位" 
                            class="enhanced-input"
                            prefix-icon="el-icon-set-up">
                        </el-input>
                    </div>
                    <div class="form-col">
                        <label class="form-label required">符号</label>
                        <el-input 
                            v-model="data.symbol" 
                            placeholder="请输入符号" 
                            class="enhanced-input"
                            prefix-icon="el-icon-reading">
                        </el-input>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">阈值范围</label>
                    <div class="range-input-wrapper">
                        <el-input 
                            v-model="data.valueRange" 
                            placeholder="格式：最小值,最大值，如: 60,100" 
                            class="enhanced-input"
                            prefix-icon="el-icon-data-line">
                        </el-input>
                        <div class="range-hint">指定健康指标的正常值范围</div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">简介</label>
                    <el-input 
                        type="textarea" 
                        v-model="data.detail" 
                        placeholder="请输入健康模型的简要说明..." 
                        :rows="3"
                        class="enhanced-textarea">
                    </el-input>
                </div>
            </div>
            
            <div slot="footer" class="dialog-footer">
                <el-button plain @click="cannel()">取消</el-button>
                <el-button 
                    type="primary" 
                    class="confirm-button" 
                    v-if="!isOperation" 
                    @click="addOperation">
                    <i class="el-icon-check"></i> 确认新增
                </el-button>
                <el-button 
                    type="primary" 
                    class="confirm-button" 
                    v-else 
                    @click="updateOperation">
                    <i class="el-icon-check"></i> 确认修改
                </el-button>
            </div>
        </el-dialog>
    </el-row>
</template>

<script>
export default {
    data() {
        return {
            data: { cover: '' },
            filterText: '',
            currentPage: 1,
            pageSize: 10,
            totalItems: 0,
            dialogUserOperaion: false, // 开关
            isOperation: false, // 开关-标识新增或修改
            tableData: [],
            searchTime: [],
            selectedRows: [],
            status: null,
            healthModelConfigQueryDto: {}, // 搜索条件
            messsageContent: '',
            tagsList: [],
            valuesRange: [10, 50]
        };
    },
    created() {
        this.fetchFreshData();
    },
    methods: {
        handleAvatarSuccess(res, file) {
            this.$notify({
                duration: 2000,
                title: '图标上传',
                message: res.code === 200 ? '成功' : '异常',
                type: res.code === 200 ? 'success' : 'error'
            });
            this.data.cover = res.data;
        },
        // 多选框选中
        handleSelectionChange(selection) {
            this.selectedRows = selection;
        },
        // 批量删除数据
        async batchDelete() {
            if (!this.selectedRows.length) {
                this.$message(`未选中任何数据`);
                return;
            }
            const confirmed = await this.$swalConfirm({
                title: '删除健康模型数据',
                text: `删除后不可恢复，是否继续？`,
                icon: 'warning',
            });
            if (confirmed) {
                try {
                    let ids = this.selectedRows.map(entity => entity.id);
                    const response = await this.$axios.post(`/health-model-config/batchDelete`, ids);
                    if (response.data.code === 200) {
                        this.$notify({
                            duration: 2000,
                            title: '删除操作',
                            message: '成功',
                            type: 'success'
                        });
                        this.fetchFreshData();
                        return;
                    }
                } catch (e) {
                    console.error(`健康模型信息删除异常：`, e);
                }
            }
        },
        resetQueryCondition() {
            this.healthModelConfigQueryDto = {};
            this.searchTime = [];
            this.fetchFreshData();
        },
        // 修改信息
        async updateOperation() {
            if (!this.validateForm()) return;

            try {
                const res = await this.$axios.put('/health-model-config/update', this.data);
                if (res.data.code === 200) {
                    this.cannel();
                    this.fetchFreshData();
                    this.$notify({
                        duration: 2000,
                        title: '修改操作',
                        message: '成功',
                        type: 'success'
                    });
                }
            } catch (error) {
                console.log('模型修改异常=>', error);
                this.$notify({
                    duration: 2000,
                    title: '修改操作',
                    message: '失败，请稍后再试',
                    type: 'error'
                });
            }
        },
        cannel() {
            this.dialogUserOperaion = false;
            this.isOperation = false;
            this.data = { cover: '' };
            this.valueRange = null;
        },
        // 模型新增
        addOperation() {
            if (!this.validateForm()) return;
            
            this.$axios.post('/health-model-config/config/save', this.data).then(res => {
                this.cannel();
                this.fetchFreshData();
                this.$notify({
                    duration: 2000,
                    title: '新增操作',
                    message: '成功',
                    type: 'success'
                });
            }).catch(error => {
                console.log('模型新增异常=>', error);
                this.$notify({
                    duration: 2000,
                    title: '新增操作',
                    message: '失败，请稍后再试',
                    type: 'error'
                });
            })
        },
        
        // 表单验证
        validateForm() {
            if (!this.data.cover) {
                this.$notify({
                    duration: 2000,
                    title: '表单验证',
                    message: '请上传图标',
                    type: 'warning'
                });
                return false;
            }
            
            if (!this.data.name) {
                this.$notify({
                    duration: 2000,
                    title: '表单验证',
                    message: '请输入配置名',
                    type: 'warning'
                });
                return false;
            }
            
            if (!this.data.unit) {
                this.$notify({
                    duration: 2000,
                    title: '表单验证',
                    message: '请输入单位',
                    type: 'warning'
                });
                return false;
            }
            
            if (!this.data.valueRange) {
                this.$notify({
                    duration: 2000,
                    title: '表单验证',
                    message: '请输入阈值范围',
                    type: 'warning'
                });
                return false;
            }
            
            // 验证阈值格式
            const valueRangeRegex = /^\d+(\.\d+)?,\d+(\.\d+)?$/;
            if (!valueRangeRegex.test(this.data.valueRange)) {
                this.$notify({
                    duration: 2000,
                    title: '表单验证',
                    message: '阈值格式不正确，请使用格式：最小值,最大值',
                    type: 'warning'
                });
                return false;
            }
            
            return true;
        },

        // 模型查询
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
                    startTime: startTime,
                    endTime: endTime,
                    ...this.healthModelConfigQueryDto
                };
                const response = await this.$axios.post('/health-model-config/query', params);
                const { data } = response;
                this.tableData = data.data;
                this.totalItems = data.total;
            } catch (error) {
                console.error('查询健康模型信息异常:', error);
            }
        },
        add() {
            this.dialogUserOperaion = true;
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
            this.dialogUserOperaion = true;
            this.isOperation = true;
            this.data = { ...row }
        },
        handleDelete(row) {
            this.selectedRows.push(row);
            this.batchDelete();
        }
    },
};
</script>

<style scoped lang="scss">
.model-dialog {
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
}

.dialog-title {
    margin: 0;
    padding: 0 0 15px 0;
    border-bottom: 1px solid #f0f0f0;
    
    h3 {
        font-size: 20px;
        font-weight: 600;
        color: #333;
        margin: 0 0 8px 0;
    }
    
    .dialog-subtitle {
        font-size: 14px;
        color: #888;
        margin: 0;
    }
}

.model-form {
    padding: 20px 5px 10px;
}

.form-group {
    margin-bottom: 20px;
}

.form-row {
    display: flex;
    gap: 12px;
    
    .form-col {
        flex: 1;
    }
}

.form-label {
    display: block;
    margin-bottom: 8px;
    font-size: 14px;
    color: #333;
    font-weight: 500;
    
    &.required:before {
        content: '*';
        color: #F56C6C;
        margin-right: 4px;
    }
}

.upload-wrapper {
    display: flex;
    align-items: flex-start;
}

.avatar-uploader {
    border: 1px dashed #d9d9d9;
    border-radius: 8px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    width: 100px;
    height: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: all 0.3s;
    background: #fafafa;
    
    &:hover {
        border-color: #42b983;
        background: #f0f9f4;
    }
}

.upload-placeholder {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
    
    i {
        font-size: 28px;
        color: #8c939d;
        margin-bottom: 5px;
    }
    
    p {
        margin: 0;
        font-size: 12px;
        color: #8c939d;
    }
}

.avatar {
    width: 100px;
    height: 100px;
    display: block;
    object-fit: cover;
}

.upload-actions {
    margin-left: 12px;
    padding-top: 8px;
}

.enhanced-input {
    .el-input__inner {
        padding-left: 35px;
        height: 42px;
        font-size: 14px;
        transition: all 0.3s;
        border-radius: 8px;
        
        &:focus {
            border-color: #42b983;
            box-shadow: 0 0 0 2px rgba(66, 185, 131, 0.2);
        }
    }
    
    .el-input__prefix {
        left: 10px;
        color: #42b983;
    }
}

.enhanced-textarea {
    .el-textarea__inner {
        border-radius: 8px;
        transition: all 0.3s;
        padding: 10px 15px;
        font-size: 14px;
        
        &:focus {
            border-color: #42b983;
            box-shadow: 0 0 0 2px rgba(66, 185, 131, 0.2);
        }
    }
}

.range-input-wrapper {
    position: relative;
    
    .range-hint {
        font-size: 12px;
        color: #999;
        margin-top: 5px;
    }
}

.dialog-footer {
    margin-top: 10px;
    text-align: right;
    padding-top: 15px;
    border-top: 1px solid #f0f0f0;
}

.confirm-button {
    padding: 10px 20px;
    background: #42b983;
    border-color: #42b983;
    transition: all 0.3s;
    
    &:hover {
        background: #33a06f;
        border-color: #33a06f;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(66, 185, 131, 0.2);
    }
    
    i {
        margin-right: 5px;
    }
}

.text-button {
    color: #42b983;
    margin-right: 10px;
    cursor: pointer;
    font-size: 13px;
    transition: all 0.3s;
    
    &:hover {
        color: #33a06f;
        text-decoration: underline;
    }
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.model-form {
    animation: fadeIn 0.4s ease;
}
</style>