<template>
    <div class="record-container">
        <div class="record-header">
            <div class="header-content">
                <div class="back-button" @click="goBack">
                    <i class="el-icon-arrow-left"></i>
                    <span>返回首页</span>
                </div>
                <h1 class="page-title">健康记录</h1>
            </div>
        </div>
        
        <div class="main-content">
            <div class="left-panel">
                <el-tabs v-model="activeName" @tab-click="handleClick" class="model-tabs">
                    <el-tab-pane label="全局模型" name="first"></el-tab-pane>
                    <el-tab-pane label="我的模型" name="second"></el-tab-pane>
                </el-tabs>
                
                <div class="action-bar">
                    <el-button type="primary" class="add-model-btn" @click="addModel">
                        <i class="el-icon-plus"></i> 新增模型
                    </el-button>
                </div>
                
                <div class="search-bar">
                    <el-input 
                        placeholder="搜索模型" 
                        v-model="userHealthModel.name" 
                        prefix-icon="el-icon-search"
                        clearable 
                        @clear="handleFilterClear"
                        @keyup.enter.native="searModel">
                    </el-input>
                    <el-button type="primary" @click="searModel">搜索</el-button>
                </div>
                
                <div class="models-list">
                    <div 
                        v-for="(model, index) in modelList" 
                        :key="index"
                        class="model-item"
                        :class="{ 'active': selectedModel.some(m => m.id === model.id) }"
                        @click="modelSelected(model)">
                        <div class="model-icon">
                            <img :src="model.cover" alt="模型图标">
                        </div>
                        <div class="model-info">
                            <div class="model-name">{{ model.name }}</div>
                            <div class="model-details">
                                <span class="model-unit">{{ model.unit }}</span>
                                <span class="model-symbol">{{ model.symbol }}</span>
                                <div class="model-actions" v-if="!model.isGlobal" @click.stop>
                                    <el-button type="text" @click="updateModel(model)" class="action-btn edit-btn">
                                        <i class="el-icon-edit"></i> 修改
                                    </el-button>
                                    <el-button type="text" @click="deleteModel(model)" class="action-btn delete-btn">
                                        <i class="el-icon-delete"></i> 删除
                                    </el-button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="right-panel">
                <div class="panel-header">
                    <h2>数据录入面板</h2>
                    <el-button type="text" @click="clearData" class="reset-btn">
                        <i class="el-icon-refresh"></i> 重置
                    </el-button>
                </div>
                
                <div class="data-entry-area">
                    <el-empty v-if="selectedModel.length === 0" description="请选择左侧模型进行记录"></el-empty>
                    
                    <div v-else class="selected-models">
                        <div v-for="(model, index) in selectedModel" :key="index" class="model-entry-card">
                            <div class="model-entry-header">
                                <h3>{{ model.name }}</h3>
                                <span class="model-unit-label">{{ model.unit }}</span>
                            </div>
                            <div class="input-area">
                                <input type="text" v-model="model.value" class="input-model" 
                                       :placeholder="'正常值范围：' + model.valueRange">
                            </div>
                            <div class="normal-range">正常值范围: {{ model.valueRange }}</div>
                        </div>
                    </div>
                </div>
                
                <div class="submit-area" v-if="selectedModel.length > 0">
                    <el-button type="primary" @click="toRecord" class="submit-btn">
                        立即记录 <i class="el-icon-right"></i>
                    </el-button>
                </div>
            </div>
        </div>
        
        <el-dialog :visible.sync="dialogUserOperaion" width="30%" :show-close="true" custom-class="model-dialog">
            <div slot="title" class="dialog-title">
                {{ !isOperation ? '健康模型新增' : '健康模型修改' }}
            </div>
            
            <div class="model-form">
                <div class="form-group">
                    <label class="form-label required">图标</label>
                    <el-upload 
                        class="avatar-uploader" 
                        action="http://localhost:8080/api/personal-heath/v1.0/file/upload"
                        :show-file-list="false" 
                        :on-success="handleAvatarSuccess">
                        <img v-if="data.cover" :src="data.cover" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">配置名</label>
                    <el-input v-model="data.name" placeholder="请输入配置名"></el-input>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">单位</label>
                    <el-input v-model="data.unit" placeholder="请输入单位"></el-input>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">符号</label>
                    <el-input v-model="data.symbol" placeholder="请输入符号"></el-input>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">阈值（格式：最小值,最大值）</label>
                    <el-input v-model="data.valueRange" placeholder="例如: 60,100"></el-input>
                </div>
                
                <div class="form-group">
                    <label class="form-label required">简介</label>
                    <el-input type="textarea" v-model="data.detail" placeholder="请输入简介" :rows="3"></el-input>
                </div>
            </div>
            
            <div slot="footer" class="dialog-footer">
                <el-button @click="cannel()">取消</el-button>
                <el-button type="primary" v-if="!isOperation" @click="addOperation">新增</el-button>
                <el-button type="primary" v-else @click="updateOperation">修改</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
import Logo from '@/components/Logo';
export default {
    components: { Logo },
    data() {
        return {
            data: { cover: '' },
            userInfo: {},
            modelList: [],
            activeName: 'first',
            userHealthModel: { isGlobal: true },
            dialogUserOperaion: false,
            isOperation: false,
            userId: null,
            selectedModel: [],
        };
    },
    created() {
        this.getUserInfo();
        this.getAllModelConfig();
        this.getUser();
    },
    methods: {
        async clearData() {
            const confirmed = await this.$swalConfirm({
                title: "重置数据？",
                text: `重置之后需要重新输入,是否继续`,
                icon: 'warning',
            });
            if (confirmed) {
                this.selectedModel = [];
            }
        },
        cannel(){
            this.data = {};
            this.dialogUserOperaion = false;
            this.isOperation = false;
            this.cover = '';
        },
        // 发送修改请求
        updateOperation() {
    // 验证必填字段
    if (!this.data.cover || !this.data.name || !this.data.unit || !this.data.valueRange ) {
        this.$notify({
            duration: 1000,
            title: '模型修改',
            message: '请填写所有必填字段（图标、配置名、单位、阈值）',
            type: 'error'
        });
        return;
    }

    this.$axios.put('/health-model-config/update', this.data).then(response => {
        const { data } = response;
        if (data.code === 200) {
            this.dialogUserOperaion = false;
            this.isOperation = false;
            this.data = {};
            this.$swal.fire({
                title: '模型修改',
                text: '模型修改成功',
                icon: 'success',
                showConfirmButton: false,
                timer: 1000,
            });
            // 继续加载最新的模型数据
            this.getAllModelConfig();
        }
    })
},
        // 修改自己配置的模型
        updateModel(model) {
            this.data = model;
            this.dialogUserOperaion = true;
            this.isOperation = true;
        },
        // 删除自己配置的模型
        async deleteModel(model) {
            const confirmed = await this.$swalConfirm({
                title: '删除模型【' + model.name + "】",
                text: `删除后不可恢复，是否继续？`,
                icon: 'warning',
            });
            if (confirmed) {
                const ids = [];
                ids.push(model.id);
                // 写删除请求
                this.$axios.post('/health-model-config/batchDelete', ids).then(response => {
                    const { data } = response;
                    if (data.code === 200) {
                        this.$swal.fire({
                            title: '模型删除',
                            text: '模型删除成功',
                            icon: 'success',
                            showConfirmButton: false,
                            timer: 1000,
                        });
                        // 继续加载最新的模型数据
                        this.getAllModelConfig();
                        // 如果已经选中对应的模型，从列表中删除对应的项
                        this.selectedModel = this.selectedModel.filter(entity => entity.id !== model.id);
                    }
                })
            }
        },
        goBack() {
            this.$router.push('/user');
        },
        // 记录值
        toRecord() {
            const userHealths = this.selectedModel.map(entity => {
                return {
                    healthModelConfigId: entity.id,
                    value: entity.value
                }
            });
            this.$axios.post('/user-health/save', userHealths).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.$notify({
                        title: '记录操作',
                        message: '记录成功',
                        type: 'success'
                    });
                    // 两秒后跳转出去
                    //setTimeout(() => {
                        //this.$router.push('/user');
                    //}, 2000)
                }
            })
        },
        modelSelected(model) {
            const saveFlag = this.selectedModel.find(entity => entity.id === model.id);
            if (!saveFlag) {
                // 不存在则添加
                this.selectedModel.push(model);
            }
        },
        searModel() {
            this.getAllModelConfig();
        },
        handleFilterClear() {
            this.userHealthModel.name = '';
            this.getAllModelConfig();
        },
        handleAvatarSuccess(res, file) {
            if (res.code !== 200) {
                this.$message.error(`健康模型封面上传异常`);
                return;
            }
            this.$message.success(`健康模型封面上传成功`);
            this.data.cover = res.data;
        },
        getUser() {
            const userInfo = sessionStorage.getItem('userInfo');
            const entity = JSON.parse(userInfo);
            this.userId = entity.id;
        },
        async addOperation() {
    // 验证必填字段
    if (!this.data.cover || !this.data.name || !this.data.unit || !this.data.valueRange) {
        this.$notify({
            duration: 1000,
            title: '模型新增',
            message: '请填写所有必填字段（图标、配置名、单位、阈值）',
            type: 'error'
        });
        return;
    }

    try {
        this.data.userId = this.userId;
        const response = await this.$axios.post('/health-model-config/save', this.data);
        this.$message[response.data.code === 200 ? 'success' : 'error'](response.data.msg);
        if (response.data.code === 200) {
            this.dialogUserOperaion = false;
            this.getAllModelConfig();
            this.data = {};
        }
    } catch (error) {
        console.error('提交表单时出错:', error);
        this.$message.error('提交失败，请稍后再试！');
    }
},
        addModel() {
            this.dialogUserOperaion = true;
        },
        handleClick(tab, event) {
            // 先去清空条件
            this.userHealthModel = {};
            if (this.activeName === 'first') {
                this.userHealthModel.isGlobal = true;
            } else {
                const userInfo = sessionStorage.getItem('userInfo');
                const entity = JSON.parse(userInfo);
                this.userHealthModel.userId = entity.id;
            }
            this.getAllModelConfig();
        },
        getAllModelConfig() {
            this.$axios.post('/health-model-config/query', this.userHealthModel).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.modelList = data.data;
                }
            });
        },
        getUserInfo() {
            const userInfo = sessionStorage.getItem('userInfo');
            this.userInfo = JSON.parse(userInfo);
        },
    },
};
</script>
<style scoped lang="scss">
.record-container {
    background-color: #f5f7fa;
    min-height: 100vh;
    font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;
}

.record-header {
    background: linear-gradient(135deg, #42b983 0%, #33a06f 100%);
    padding: 20px 0;
    color: white;
    box-shadow: 0 4px 12px rgba(66, 185, 131, 0.2);
    margin-bottom: 20px;
}

.header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    align-items: center;
}

.back-button {
    display: flex;
    align-items: center;
    font-size: 16px;
    cursor: pointer;
    padding: 8px 16px;
    border-radius: 20px;
    background-color: rgba(255, 255, 255, 0.2);
    transition: all 0.3s ease;
    margin-right: 20px;
    
    &:hover {
        background-color: rgba(255, 255, 255, 0.3);
        transform: translateX(-5px);
    }
    
    i {
        margin-right: 8px;
    }
}

.page-title {
    font-size: 24px;
    font-weight: 600;
    margin: 0;
    flex: 1;
    letter-spacing: 1px;
}

.main-content {
    display: flex;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    gap: 20px;
}

.left-panel {
    width: 30%;
    background: white;
    border-radius: 10px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    padding: 20px;
    display: flex;
    flex-direction: column;
    height: calc(100vh - 180px);
}

.right-panel {
    flex: 1;
    background: white;
    border-radius: 10px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    padding: 20px;
    display: flex;
    flex-direction: column;
    height: calc(100vh - 180px);
}

.model-tabs {
    margin-bottom: 15px;
}

.action-bar {
    margin-bottom: 15px;
}

.add-model-btn {
    width: 100%;
    background: #42b983;
    border-color: #42b983;
    
    &:hover, &:focus {
        background: #33a06f;
        border-color: #33a06f;
    }
}

.search-bar {
    display: flex;
    margin-bottom: 15px;
    gap: 10px;
    
    .el-input {
        flex: 1;
    }
    
    .el-button {
        background: #42b983;
        border-color: #42b983;
        
        &:hover, &:focus {
            background: #33a06f;
            border-color: #33a06f;
        }
    }
}

.models-list {
    flex: 1;
    overflow-y: auto;
    overflow-x: hidden;
    
    &::-webkit-scrollbar {
        width: 6px;
    }
    
    &::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 10px;
    }
    
    &::-webkit-scrollbar-thumb {
        background: #c1c1c1;
        border-radius: 10px;
    }
    
    &::-webkit-scrollbar-thumb:hover {
        background: #a8a8a8;
    }
}

.model-item {
    display: flex;
    padding: 12px;
    border-radius: 8px;
    margin-bottom: 10px;
    background-color: #f9f9f9;
    transition: all 0.3s ease;
    border-left: 3px solid transparent;
    
    &:hover {
        background-color: #f0f0f0;
        transform: translateX(5px);
    }
    
    &.active {
        background-color: #e8f5ee;
        border-left-color: #42b983;
    }
}

.model-icon {
    width: 50px;
    height: 50px;
    margin-right: 15px;
    
    img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 8px;
    }
}

.model-info {
    flex: 1;
    min-width: 0;
}

.model-name {
    font-weight: 600;
    font-size: 16px;
    margin-bottom: 5px;
    color: #333;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.model-details {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    font-size: 14px;
    color: #666;
}

.model-unit, .model-symbol {
    margin-right: 10px;
    background: #f0f0f0;
    padding: 2px 8px;
    border-radius: 12px;
    font-size: 12px;
}

.model-actions {
    margin-left: auto;
    margin-top: 5px;
    
    .action-btn {
        padding: 2px 6px;
        font-size: 12px;
    }
    
    .edit-btn {
        color: #409EFF;
    }
    
    .delete-btn {
        color: #F56C6C;
    }
}

.panel-header {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 10px;
    border-bottom: 1px solid #eee;
    
    h2 {
        margin: 0;
        font-size: 18px;
        flex: 1;
    }
    
    .reset-btn {
        font-size: 14px;
        color: #666;
        
        &:hover {
            color: #42b983;
        }
    }
}

.data-entry-area {
    flex: 1;
    overflow-y: auto;
    
    &::-webkit-scrollbar {
        width: 6px;
    }
    
    &::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 10px;
    }
    
    &::-webkit-scrollbar-thumb {
        background: #c1c1c1;
        border-radius: 10px;
    }
    
    &::-webkit-scrollbar-thumb:hover {
        background: #a8a8a8;
    }
}

.selected-models {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 15px;
}

.model-entry-card {
    background-color: #f9f9f9;
    border-radius: 10px;
    padding: 15px;
    transition: all 0.3s ease;
    border-top: 3px solid #42b983;
    
    &:hover {
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        transform: translateY(-3px);
    }
}

.model-entry-header {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    
    h3 {
        margin: 0;
        font-size: 16px;
        flex: 1;
        color: #333;
    }
    
    .model-unit-label {
        background: #e8f5ee;
        color: #42b983;
        padding: 2px 8px;
        border-radius: 12px;
        font-size: 12px;
    }
}

.input-area {
    margin-bottom: 8px;
}

.input-model {
    font-size: 18px;
    padding: 12px;
    box-sizing: border-box;
    border-radius: 8px;
    border: 1px solid #e0e0e0;
    outline: none;
    background-color: white;
    width: 100%;
    transition: all 0.3s ease;
    
    &:focus {
        border-color: #42b983;
        box-shadow: 0 0 0 2px rgba(66, 185, 131, 0.2);
    }
    
    &::placeholder {
        color: #bbb;
        font-size: 14px;
    }
}

.normal-range {
    font-size: 12px;
    color: #888;
}

.submit-area {
    margin-top: 20px;
    text-align: center;
}

.submit-btn {
    background: #42b983;
    border-color: #42b983;
    font-size: 16px;
    padding: 12px 25px;
    border-radius: 30px;
    
    &:hover, &:focus {
        background: #33a06f;
        border-color: #33a06f;
        transform: translateY(-2px);
    }
    
    i {
        margin-left: 8px;
        transition: transform 0.3s ease;
    }
    
    &:hover i {
        transform: translateX(4px);
    }
}

.model-dialog {
    border-radius: 10px;
    overflow: hidden;
}

.dialog-title {
    font-size: 18px;
    font-weight: 600;
    color: #333;
}

.model-form {
    padding: 10px 0;
}

.form-group {
    margin-bottom: 15px;
}

.form-label {
    display: block;
    margin-bottom: 8px;
    font-size: 14px;
    color: #333;
    
    &.required:before {
        content: '*';
        color: #F56C6C;
        margin-right: 4px;
    }
}

.avatar-uploader {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    width: 80px;
    height: 80px;
    display: flex;
    justify-content: center;
    align-items: center;
    
    &:hover {
        border-color: #42b983;
    }
}

.avatar {
    width: 80px;
    height: 80px;
    display: block;
    object-fit: cover;
}

.avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 80px;
    height: 80px;
    line-height: 80px;
    text-align: center;
}

@media screen and (max-width: 768px) {
    .main-content {
        flex-direction: column;
    }
    
    .left-panel {
        width: 100%;
        height: auto;
        margin-bottom: 20px;
    }
    
    .models-list {
        max-height: 300px;
    }
    
    .right-panel {
        height: auto;
    }
    
    .selected-models {
        grid-template-columns: 1fr;
    }
}
</style>