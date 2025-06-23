<template>
    <div class="create-gourmet-container">
        <div class="page-header">
            <div class="header-content">
                <el-tooltip class="item" effect="dark" content="返回上一页" placement="bottom">
                    <span class="back-button" @click="goBack">
                        <i class="el-icon-back"></i>
                    </span>
                </el-tooltip>
                <h1 class="page-title">创建精彩内容</h1>
            </div>
            <div class="publish-button-wrapper">
                <el-button 
                    @click="postGourmet" 
                    type="primary" 
                    size="medium" 
                    :loading="submitting"
                    icon="el-icon-s-promotion"
                    class="publish-button">
                    发布内容
                </el-button>
            </div>
        </div>
        
        <div class="content-panel">
            <el-row :gutter="20">
                <!-- 左侧边栏 -->
                <el-col :xs="24" :sm="8" :md="6" :lg="5" class="sidebar-panel">
                    <div class="sidebar-section category-section">
                        <h2 class="section-title">
                            <i class="el-icon-collection-tag"></i> 内容分类
                        </h2>
                        <div class="category-wrap">
                            <el-select 
                                v-model="gourmet.categoryId" 
                                placeholder="选择内容分类" 
                                class="full-width-select">
                                <el-option
                                    v-for="item in categories"
                                    :key="item.id"
                                    :label="item.name"
                                    :value="item.id">
                                </el-option>
                            </el-select>
                            <div class="helper-text">为您的内容选择一个合适的分类</div>
                        </div>
                    </div>

                    <div class="sidebar-section cover-section">
                        <h2 class="section-title">
                            <i class="el-icon-picture-outline"></i> 封面图片
                        </h2>
                        <el-upload
                            class="cover-uploader"
                            action="http://localhost:8080/api/personal-heath/v1.0/file/upload"
                            :show-file-list="false"
                            :on-success="handleCoverSuccess"
                            :before-upload="beforeCoverUpload"
                            ref="uploadRef">
                            <div class="upload-area" v-if="!cover">
                                <i class="el-icon-picture"></i>
                                <div class="upload-text">点击上传封面图片</div>
                                <div class="upload-hint">建议尺寸 960×640 像素</div>
                            </div>
                            <div class="cover-preview" v-else>
                                <img :src="cover" class="cover-image">
                                <div class="cover-overlay">
                                    <div class="overlay-buttons">
                                        <el-button type="text" icon="el-icon-delete" @click.stop="removeCover">删除</el-button>
                                        <el-button type="text" icon="el-icon-refresh" @click.stop="$refs.uploadRef.handleClick()">更换</el-button>
                                    </div>
                                </div>
                            </div>
                        </el-upload>
                    </div>

                    <div class="sidebar-section visibility-section">
                        <h2 class="section-title">
                            <i class="el-icon-lock"></i> 可见性设置
                        </h2>
                        <div class="visibility-setting">
                            <div class="visibility-switch">
                                <span class="switch-label">{{ gourmet.isPublish ? '公开' : '私密' }}</span>
                                <el-switch
                                    v-model="gourmet.isPublish"
                                    active-color="#0f753f"
                                    inactive-color="#909399">
                                </el-switch>
                            </div>
                            <div class="visibility-icon">
                                <i :class="gourmet.isPublish ? 'el-icon-view' : 'el-icon-lock'"></i>
                            </div>
                        </div>
                        <div class="helper-text visibility-help">{{ gourmet.isPublish ? '所有用户都可以查看您的内容' : '仅自己可见，不会显示在公共页面' }}</div>
                    </div>
                </el-col>
                
                <!-- 右侧内容区 -->
                <el-col :xs="24" :sm="16" :md="18" :lg="19" class="content-area">
                    <div class="title-section">
                        <input
                            v-model="gourmet.title"
                            class="title-input"
                            type="text"
                            maxlength="100"
                            placeholder="请输入一个吸引人的标题...">
                        <div class="title-counter" :class="{'title-warning': gourmet.title && gourmet.title.length > 80}">
                            {{ gourmet.title ? gourmet.title.length : 0 }}/100
                        </div>
                    </div>
                    
                    <div class="editor-section">
                        <Editor 
                            height="calc(100vh - 280px)" 
                            :receiveContent="gourmet.content"
                            @on-receive="onReceive" />
                    </div>
                </el-col>
            </el-row>
        </div>
    </div>
</template>

<script>
import Editor from "@/components/Editor"

export default {
    components: { Editor },
    name: "CreateGourmet",
    data() {
        return {
            gourmet: {
                title: '',
                content: '',
                isPublish: true,
                categoryId: null
            },
            categories: [], 
            cover: null,
            submitting: false
        }
    },
    created() {
        this.fetchFreshCategories();
        document.title = "创建内容 - 健康管理";
    },
    methods: {
        // 发布帖子
        postGourmet() {
            // 验证必填字段
            if (!this.validateForm()) {
                return;
            }
            
            this.submitting = true;
            this.gourmet.cover = this.cover;
            
            this.$axios.post('/gourmet/save', this.gourmet).then(res => {
                this.submitting = false;
                if (res.data.code === 200) {
                    this.$notify({
                        duration: 2000,
                        title: '发布成功',
                        message: '您的内容已成功发布',
                        type: 'success',
                        position: 'bottom-right'
                    });
                    this.goBack();
                }
            }).catch(error => {
                this.submitting = false;
                this.$notify({
                    duration: 2000,
                    title: '发布失败',
                    message: '发布过程中出现错误，请稍后重试',
                    type: 'error',
                    position: 'bottom-right'
                });
                console.log("新增论坛异常：", error);
            });
        },
        
        validateForm() {
            if (!this.gourmet.title) {
                this.$notify({
                    duration: 2000,
                    title: '标题缺失',
                    message: '请输入文章标题',
                    type: 'warning',
                    position: 'bottom-right'
                });
                return false;
            }
            
            if (!this.gourmet.content) {
                this.$notify({
                    duration: 2000,
                    title: '内容缺失',
                    message: '请输入文章内容',
                    type: 'warning',
                    position: 'bottom-right'
                });
                return false;
            }
            
            if (!this.cover) {
                this.$notify({
                    duration: 2000,
                    title: '封面缺失',
                    message: '请上传一张封面图片',
                    type: 'warning',
                    position: 'bottom-right'
                });
                return false;
            }
            
            if (!this.gourmet.categoryId) {
                this.$notify({
                    duration: 2000,
                    title: '分类缺失',
                    message: '请选择一个内容分类',
                    type: 'warning',
                    position: 'bottom-right'
                });
                return false;
            }
            
            return true;
        },
        
        // 封面上传前验证
        beforeCoverUpload(file) {
            const isImage = file.type.startsWith('image/');
            const isLt5M = file.size / 1024 / 1024 < 5;
            
            if (!isImage) {
                this.$notify({
                    duration: 2000,
                    title: '文件类型错误',
                    message: '封面图片只能是图片格式',
                    type: 'error',
                    position: 'bottom-right'
                });
                return false;
            }
            
            if (!isLt5M) {
                this.$notify({
                    duration: 2000,
                    title: '文件过大',
                    message: '封面图片大小不能超过 5MB',
                    type: 'error',
                    position: 'bottom-right'
                });
                return false;
            }
            
            return true;
        },
        
        // 封面上传回调函数
        handleCoverSuccess(res, file) {
            if (res.code === 200) {
                this.cover = res.data;
                this.$notify({
                    duration: 1500,
                    title: '上传成功',
                    message: '封面图片已上传',
                    type: 'success',
                    position: 'bottom-right'
                });
            } else {
                this.$notify({
                    duration: 1500,
                    title: '上传失败',
                    message: '请重新尝试上传',
                    type: 'error',
                    position: 'bottom-right'
                });
            }
        },
        
        // 移除封面
        removeCover() {
            this.cover = null;
        },
        
        // 获取分类列表
        fetchFreshCategories() {
            this.$axios.post('/tags/query', {}).then(res => {
                if (res.data.code === 200) {
                    this.categories = res.data.data.filter(item => item.id !== null);
                }
            }).catch(error => {
                this.$notify({
                    duration: 2000,
                    title: '获取分类失败',
                    message: '无法加载分类列表，请刷新页面',
                    type: 'error',
                    position: 'bottom-right'
                });
                console.log("查询信息异常：", error);
            });
        },
        
        // 返回上一页
        goBack() {
            this.$router.go(-1);
        },
        
        // 接收编辑器内容
        onReceive(content) {
            this.gourmet.content = content;
        }
    }
};
</script>

<style scoped lang="scss">
.create-gourmet-container {
    background-color: #f8fafc;
    min-height: calc(100vh - 60px);
    padding: 20px 30px 40px;
}

.page-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 25px;
    
    .header-content {
        display: flex;
        align-items: center;
    }
    
    .back-button {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: linear-gradient(145deg, #ffffff, #f0f0f0);
        color: #0f753f;
        box-shadow: 5px 5px 10px #e8e8e8, -5px -5px 10px #ffffff;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-right: 15px;
        
        &:hover {
            background: linear-gradient(145deg, #0f753f, #0d6937);
            color: white;
            transform: translateX(-3px);
        }
        
        i {
            font-size: 18px;
        }
    }
    
    .page-title {
        font-size: 28px;
        font-weight: 700;
        color: #1e293b;
        margin: 0;
        position: relative;
        
        &:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -8px;
            width: 45px;
            height: 4px;
            border-radius: 2px;
            background: linear-gradient(90deg, #0f753f 0%, #52c873 100%);
        }
    }
    
    .publish-button-wrapper {
        .publish-button {
            background: linear-gradient(45deg, #0f753f 0%, #2eab60 100%);
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(15, 117, 63, 0.2);
            
            &:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(15, 117, 63, 0.3);
            }
            
            &:active {
                transform: translateY(0);
                box-shadow: 0 2px 5px rgba(15, 117, 63, 0.2);
            }
        }
    }
}

.content-panel {
    background-color: white;
    border-radius: 16px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
    overflow: hidden;
    border: 1px solid rgba(235, 238, 241, 0.8);
}

.sidebar-panel {
    padding: 30px 25px;
    border-right: 1px solid #f0f4f8;
    background-color: #fbfcfd;
    
    @media screen and (max-width: 768px) {
        border-right: none;
        border-bottom: 1px solid #f0f4f8;
    }
}

.sidebar-section {
    margin-bottom: 35px;
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.03);
    border: 1px solid #f0f4f8;
    transition: all 0.3s ease;
    
    &:hover {
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        transform: translateY(-2px);
    }
    
    &:last-child {
        margin-bottom: 0;
    }
    
    .section-title {
        font-size: 18px;
        font-weight: 600;
        color: #334155;
        margin-top: 0;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        
        i {
            margin-right: 10px;
            color: #0f753f;
            font-size: 20px;
        }
    }
    
    .helper-text {
        font-size: 13px;
        color: #64748b;
        margin-top: 10px;
        line-height: 1.5;
    }
    
    .full-width-select {
        width: 100%;
    }
    
    &.category-section {
        border-left: 4px solid #0f753f;
    }
    
    &.cover-section {
        border-left: 4px solid #0ea5e9;
    }
    
    &.visibility-section {
        border-left: 4px solid #8b5cf6;
    }
    
    &.tips-section {
        background: linear-gradient(145deg, #f8f9fa, #ffffff);
        border: 1px dashed #e2e8f0;
        
        &:hover {
            background: linear-gradient(145deg, #f9fafb, #ffffff);
        }
    }
}

.category-wrap {
    .el-select {
        .el-input__inner {
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            padding: 12px 15px;
            height: 45px;
            
            &:hover, &:focus {
                border-color: #0f753f;
            }
        }
    }
}

.visibility-setting {
    display: flex;
    align-items: center;
    justify-content: space-between;
    
    .visibility-switch {
        display: flex;
        flex-direction: column;
        gap: 10px;
        
        .switch-label {
            font-size: 16px;
            font-weight: 600;
            color: #334155;
        }
    }
    
    .visibility-icon {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        background-color: #f1f5f9;
        transition: all 0.3s ease;
        
        i {
            font-size: 20px;
            color: #64748b;
            transition: all 0.3s ease;
        }
    }
}

.visibility-help {
    margin-top: 15px;
}

.tips-content {
    display: flex;
    align-items: flex-start;
    gap: 15px;
    
    .tips-icon {
        width: 40px;
        height: 40px;
        background: linear-gradient(45deg, #0f753f, #2eab60);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        
        i {
            color: white;
            font-size: 20px;
        }
    }
    
    .tips-text {
        h3 {
            margin-top: 0;
            margin-bottom: 10px;
            color: #334155;
            font-size: 16px;
            font-weight: 600;
        }
        
        ul {
            margin: 0;
            padding: 0 0 0 18px;
            
            li {
                color: #64748b;
                font-size: 13px;
                margin-bottom: 5px;
                line-height: 1.5;
                
                &:last-child {
                    margin-bottom: 0;
                }
            }
        }
    }
}

.cover-uploader {
    width: 100%;
    
    .upload-area {
        border: 2px dashed #cbd5e1;
        border-radius: 10px;
        padding: 25px;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s;
        background-color: #f8fafc;
        
        &:hover {
            border-color: #0ea5e9;
            background-color: #f0f9ff;
        }
        
        i {
            font-size: 36px;
            color: #64748b;
            margin-bottom: 10px;
            display: block;
        }
        
        .upload-text {
            color: #334155;
            font-size: 15px;
            font-weight: 500;
            margin-bottom: 6px;
        }
        
        .upload-hint {
            color: #64748b;
            font-size: 13px;
        }
    }
    
    .cover-preview {
        position: relative;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        
        .cover-image {
            width: 100%;
            height: auto;
            display: block;
            transition: transform 0.5s ease;
        }
        
        .cover-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to top, rgba(0, 0, 0, 0.8) 0%, rgba(0, 0, 0, 0) 60%);
            display: flex;
            justify-content: center;
            align-items: flex-end;
            padding-bottom: 15px;
            opacity: 0;
            transition: opacity 0.3s;
            
            .overlay-buttons {
                display: flex;
                gap: 10px;
                
                .el-button {
                    color: white;
                    font-size: 14px;
                    padding: 8px 15px;
                    background: rgba(255, 255, 255, 0.2);
                    backdrop-filter: blur(5px);
                    border-radius: 6px;
                    
                    &:hover {
                        background: rgba(255, 255, 255, 0.3);
                    }
                }
            }
        }
        
        &:hover {
            .cover-image {
                transform: scale(1.05);
            }
            
            .cover-overlay {
                opacity: 1;
            }
        }
    }
}

.content-area {
    padding: 30px;
}

.title-section {
    margin-bottom: 25px;
    position: relative;
    
    .title-input {
        width: 100%;
        font-size: 32px;
        font-weight: 700;
        color: #1e293b;
        padding: 15px 0;
        border: none;
        border-bottom: 2px solid #e2e8f0;
        outline: none;
        transition: all 0.3s;
        
        &::placeholder {
            color: #94a3b8;
            font-weight: 500;
            opacity: 0.6;
        }
        
        &:focus {
            border-bottom-color: #0f753f;
        }
    }
    
    .title-counter {
        position: absolute;
        right: 0;
        bottom: 15px;
        font-size: 13px;
        background: #f1f5f9;
        padding: 3px 10px;
        border-radius: 20px;
        color: #64748b;
        transition: all 0.3s;
        
        &.title-warning {
            color: #fff;
            background: #f59e0b;
        }
    }
}

.editor-section {
    margin-bottom: 25px;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
}

.action-section {
    display: flex;
    justify-content: flex-end;
    padding-top: 20px;
    gap: 15px;
    
    .el-button {
        padding: 10px 20px;
        font-size: 15px;
        font-weight: 500;
        border-radius: 8px;
        transition: all 0.3s ease;
    }
    
    .el-button--default {
        border-color: #cbd5e1;
        color: #475569;
        
        &:hover {
            color: #1e293b;
            border-color: #94a3b8;
            background-color: #f8fafc;
        }
    }
    
    .el-button--primary {
        background: linear-gradient(45deg, #0f753f 0%, #2eab60 100%);
        border: none;
        box-shadow: 0 4px 10px rgba(15, 117, 63, 0.2);
        
        &:hover, &:focus {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(15, 117, 63, 0.3);
        }
        
        &:active {
            transform: translateY(0);
        }
    }
}
</style>
