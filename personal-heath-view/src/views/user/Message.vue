<template>
     <div class="message-page">
        <!-- 顶部导航栏 -->
        <div class="top-nav">
            <el-row>
                <el-col :span="6">
                    <Logo sysName="蝶启新生" />
                </el-col>
                <el-col :span="18">
                    <span class="user-info">
                        <el-dropdown class="user-dropdown">
                            <span class="el-dropdown-link">
                                <img :src="userInfo.userAvatar" alt="用户头像" />
                                <span>{{ userInfo.userName }}</span>
                                <i class="el-icon-arrow-down el-icon--right"></i>
                            </span>
                            <el-dropdown-menu slot="dropdown">
                                <el-dropdown-item icon="el-icon-user" @click.native="handleUserCenter">个人中心</el-dropdown-item>
                                <el-dropdown-item icon="el-icon-warning-outline" @click.native="handleResetPwd">修改密码</el-dropdown-item>
                                <el-dropdown-item icon="el-icon-house" @click.native="handleFamilyManage">家庭管理</el-dropdown-item>
                                <el-dropdown-item icon="el-icon-back" @click.native="handleLogout">退出登录</el-dropdown-item>
                            </el-dropdown-menu>
                        </el-dropdown>
                    </span>
                </el-col>
            </el-row>
        </div>
        <div class="separator"></div>
        
        <!-- 统一风格的头部标题栏 -->
        <div class="page-header">
            <div class="header-content">
                <h1>消息中心</h1>
                <p>查看您的互动消息、系统通知及健康提醒</p>
            </div>
        </div>

        <!-- 主体内容区 -->
        <div class="message-container">
            <!-- 功能区：返回按钮和清空消息 -->
            <div class="message-actions">
                <el-button class="back-button" @click="goBack" icon="el-icon-arrow-left" plain>返回首页</el-button>
                
                <div class="action-right">
                    <el-tooltip content="将所有消息标记为已读" placement="top">
                        <el-button type="text" @click="clearMessage" class="clear-button">
                            <i class="el-icon-s-open"></i> 全部已读
                        </el-button>
                    </el-tooltip>
                </div>
            </div>

            <!-- 消息类型选择区 -->
            <div class="message-types-container">
                <div class="message-type-tabs">
                    <span 
                        v-for="(messageType, index) in messageTypes" 
                        :key="index"
                        @click="messageTypeSelected(messageType.type)" 
                        :class="['message-type', messageQueryDto.messageType === messageType.type ? 'active' : '']"
                    >
                        {{ messageType.detail }}
                    </span>
                </div>
            </div>

            <!-- 消息列表区 -->
            <div class="message-list-container">
                <div v-if="messageList.length === 0" class="empty-message">
                    <el-empty description="暂无消息"></el-empty>
                </div>
                <div v-else class="message-list">
                    <div 
                        v-for="(message, index) in messageList" 
                        :key="index"
                        :class="['message-item', !message.isRead ? 'unread' : '']"
                    >
                        <div class="message-avatar">
                            <img v-if="message.messageType === 1 || message.messageType === 2" 
                                :src="message.senderAvatar" 
                                alt="用户头像" />
                            <div v-else-if="message.messageType === 3" class="system-icon">
                                <i class="el-icon-data-analysis"></i>
                            </div>
                        </div>
                        <div class="message-body">
                            <div class="message-header">
                                <span class="sender-name" v-if="message.messageType === 1 || message.messageType === 2">
                                    {{ message.senderName }}
                                </span>
                                <span class="sender-name" v-else>系统消息</span>
                                <span class="message-time">{{ message.createTime }}</span>
                            </div>
                            <div class="message-content">
                                <span v-if="message.messageType === 1">{{ commentDeal(message.content)[2] }}</span>
                                <span v-else>{{ message.content }}</span>
                            </div>
                            <div class="message-actions-footer" v-if="message.messageType === 1">
                                <el-button type="text" size="small" @click="replyUser(message)" class="reply-button">
                                    <i class="el-icon-chat-dot-round"></i> 回复
                                </el-button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 个人中心对话框 -->
        <el-dialog :visible.sync="dialogUserCenter" title="个人中心" width="30%" :close-on-click-modal="false">
            <div class="user-center-content">
                <div class="avatar-upload-section">
                    <p class="form-label">用户头像</p>
                    <el-upload 
                        class="avatar-uploader" 
                        action="http://localhost:8080/api/personal-heath/v1.0/file/upload" 
                        :show-file-list="false" 
                        :on-success="handleAvatarSuccess">
                        <img v-if="userCenterForm.userAvatar" :src="userCenterForm.userAvatar" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </div>
                <div class="form-item">
                    <p class="form-label">用户名</p>
                    <el-input v-model="userCenterForm.userName" placeholder="请输入用户名"></el-input>
                </div>
                <div class="form-item">
                    <p class="form-label">邮箱</p>
                    <el-input v-model="userCenterForm.userEmail" placeholder="请输入邮箱"></el-input>
                </div>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogUserCenter = false">取 消</el-button>
                <el-button type="primary" @click="updateUserInfo">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import Logo from '@/components/Logo';
import Swal from 'sweetalert2';
import { clearToken } from "@/utils/storage.js";

export default {
    components: { Logo },
    data() {
        return {
            userInfo: {},
            messageQueryDto: {
                messageType: null
            },
            messageList: [],
            messageTypes: [],
            dialogEvaluationsOperation: false,
            message: {},
            // 个人中心相关
            dialogUserCenter: false,
            userCenterForm: {
                userName: '',
                userEmail: '',
                userAvatar: ''
            }
        };
    },
    created() {
        // 1. 拿到当前用户的信息
        this.getUserInfo();
        // 2. 加载用户全部消息
        this.loadAllUsersMessage();
        // 3. 加载全部的消息类型
        this.loadAllMessageType();
    },
    methods: {
        commentDeal(content) {
            return content.split(';');
        },
        goBack() {
            this.$router.push('/user-health-model');
        },
        // 回复用户
        replyUser(message) {
            Swal.fire({
                title: `回复【${message.senderName}】`,
                input: 'text',
                inputPlaceholder: '回复内容',
                showCancelButton: true,
                confirmButtonText: '提交',
                cancelButtonText: '取消',
                confirmButtonColor: '#42b983',
                inputValidator: (value) => {
                    if (!value) {
                        return '内容不能为空哦';
                    } else {
                        this.saveCommentData(message.senderId, value, this.commentDeal(message.content));
                    }
                }
            }).then((result) => {
                console.log("...");
            });
        },
        // 保存回复数据
        saveCommentData(senderId, content, ary) {
            const comment = {
                content,
                parentId: ary[0],
                contentType: 'NEWS',
                contentId: ary[1],
                replierId: senderId
            }
            this.$axios.post('/evaluations/insert', comment).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.$notify({
                        title: '评论回复',
                        message: '回复成功',
                        type: 'success'
                    });
                }
            }).catch(error => {
                console.log("回复异常：", error);
            })
        },
        // 将全部的消息设置未已读
        async clearMessage() {
            const confirmed = await this.$swalConfirm({
                title: '消息清除',
                text: `是否将全部的消息设置为已读？`,
                icon: 'warning',
                confirmButtonColor: '#42b983',
            });
            if (confirmed) {
                this.$axios.put('/message/clearMessage').then(response => {
                    const { data } = response;
                    if (data.code === 200) {
                        this.loadAllUsersMessage();
                        this.$notify({
                            title: '消息提示',
                            message: '所有消息已标记为已读',
                            type: 'success'
                        });
                    }
                })
            }
        },
        evaluationsPut() {
            this.$axios.put('/message/clearMessage').then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.loadAllUsersMessage();
                }
            })
        },
        // 消息类型选中
        messageTypeSelected(messageType) {
            this.messageQueryDto.messageType = messageType;
            // 如果是评论数据，需要额外处理
            this.loadAllUsersMessage();
        },
        getUserInfo() {
            const userInfo = sessionStorage.getItem('userInfo');
            this.userInfo = JSON.parse(userInfo);
        },
        // 加载全部的消息类型
        loadAllMessageType() {
            this.$axios.get('/message/types').then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.messageTypes = data.data;
                    const messageType = { type: null, detail: '全部消息' };
                    this.messageTypes.unshift(messageType);
                }
            })
        },
        loadAllUsersMessage() {
            const userInfo = sessionStorage.getItem('userInfo');
            const entity = JSON.parse(userInfo);
            this.messageQueryDto.userId = entity.id;
            this.$axios.post('/message/query', this.messageQueryDto).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.messageList = data.data;
                }
            })
        },
        // 下拉菜单处理函数
        handleUserCenter() {
            // 打开个人中心对话框
            this.userCenterForm.userName = this.userInfo.userName;
            this.userCenterForm.userEmail = this.userInfo.userEmail;
            this.userCenterForm.userAvatar = this.userInfo.userAvatar;
            this.dialogUserCenter = true;
        },
        handleResetPwd() {
            // 跳转到修改密码页面
            this.$router.push('/reset-password');
        },
        handleFamilyManage() {
            // 跳转到家庭管理页面
            this.$router.push('/family-management');
        },
        handleLogout() {
            // 退出登录
            Swal.fire({
                title: '退出登录',
                text: '确定要退出登录吗？',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#42b983',
                cancelButtonColor: '#d33',
                confirmButtonText: '确定',
                cancelButtonText: '取消'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 清除token和用户信息
                    clearToken();
                    sessionStorage.removeItem('userInfo');
                    // 跳转到登录页
                    this.$router.push('/login');
                }
            });
        },
        // 处理头像上传成功
        handleAvatarSuccess(res) {
            if (res.code === 200) {
                this.userCenterForm.userAvatar = res.data;
                this.$message.success('头像上传成功');
            } else {
                this.$message.error('头像上传失败');
            }
        },
        // 更新用户信息
        updateUserInfo() {
            const userUpdateDTO = {
                userAvatar: this.userCenterForm.userAvatar,
                userName: this.userCenterForm.userName,
                userEmail: this.userCenterForm.userEmail
            };
            
            this.$axios.put(`/user/update`, userUpdateDTO).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    // 更新本地存储的用户信息
                    const userInfo = JSON.parse(sessionStorage.getItem('userInfo'));
                    userInfo.userName = this.userCenterForm.userName;
                    userInfo.userEmail = this.userCenterForm.userEmail;
                    userInfo.userAvatar = this.userCenterForm.userAvatar;
                    sessionStorage.setItem('userInfo', JSON.stringify(userInfo));
                    
                    // 更新当前组件的用户信息
                    this.userInfo = userInfo;
                    
                    // 关闭对话框并提示成功
                    this.dialogUserCenter = false;
                    this.$notify({
                        title: '个人信息',
                        message: '个人信息更新成功',
                        type: 'success'
                    });
                }
            }).catch(error => {
                console.error('更新用户信息失败:', error);
                this.$message.error('更新用户信息失败，请稍后重试');
            });
        }
    },
};
</script>

<style scoped lang="scss">
/* 顶部导航栏样式 */
.top-nav {
    line-height: 70px;
    padding: 0 50px;
}

.user-info {
    float: right;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    height: 70px;
}

.user-dropdown {
    cursor: pointer;
    
    .el-dropdown-link {
        display: flex;
        align-items: center;
        
        img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 8px;
        }
        
        i {
            margin-left: 8px;
            font-size: 12px;
            color: #909399;
        }
    }
}

.separator {
    height: 20px;
    background-color: rgb(248, 248, 248);
}

.message-page {
    background-color: #f5f7fa;
    min-height: calc(100vh - 90px);
    font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;
}

/* 统一风格的头部 */
.page-header {
    background: linear-gradient(135deg, #42b983 0%, #2c9e6a 100%);
    color: white;
    padding: 40px 0;
    text-align: center;
    border-radius: 0 0 20px 20px;
    margin-bottom: 30px;
    box-shadow: 0 6px 20px rgba(66, 185, 131, 0.2);
    position: relative;
    overflow: hidden;
    
    &::before {
        content: '';
        position: absolute;
        top: -10%;
        left: -10%;
        width: 120%;
        height: 120%;
        background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="rgba(255,255,255,0.05)"/></svg>');
        background-size: 100px 100px;
        opacity: 0.4;
        animation: pulse 8s infinite linear;
    }
    
    @keyframes pulse {
        0% {
            opacity: 0.3;
            transform: scale(1);
        }
        50% {
            opacity: 0.5;
            transform: scale(1.05);
        }
        100% {
            opacity: 0.3;
            transform: scale(1);
        }
    }
}

.header-content {
    position: relative;
    z-index: 1;
    
    h1 {
        font-size: 32px;
        margin-bottom: 10px;
        font-weight: 600;
        letter-spacing: 2px;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    p {
        font-size: 16px;
        margin-bottom: 0;
        opacity: 0.9;
        max-width: 600px;
        margin-left: auto;
        margin-right: auto;
    }
}

/* 主体内容区 */
.message-container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 0 20px 40px;
}

/* 功能区 */
.message-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.back-button {
    color: #42b983;
    border-color: #42b983;
    
    &:hover {
        color: white;
        background-color: #42b983;
    }
}

.action-right {
    display: flex;
    align-items: center;
}

.clear-button {
    color: #42b983;
    font-size: 14px;
    transition: all 0.3s;
    
    &:hover {
        color: #2c9e6a;
        transform: scale(1.05);
    }
    
    i {
        margin-right: 4px;
    }
}

/* 消息类型选择区 */
.message-types-container {
    margin-bottom: 25px;
    border-bottom: 1px solid #eee;
    padding-bottom: 10px;
}

.message-type-tabs {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}

.message-type {
    padding: 8px 16px;
    font-size: 15px;
    color: #606266;
    cursor: pointer;
    border-radius: 20px;
    transition: all 0.3s;
    
    &:hover {
        color: #42b983;
        background-color: rgba(66, 185, 131, 0.08);
    }
    
    &.active {
        color: white;
        background-color: #42b983;
        font-weight: 500;
    }
}

/* 消息列表区 */
.message-list-container {
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
    padding: 20px;
}

.empty-message {
    padding: 40px 0;
}

.message-list {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.message-item {
    display: flex;
    padding: 15px;
    border-radius: 8px;
    transition: all 0.3s;
    background-color: white;
    border-left: 3px solid transparent;
    
    &:hover {
        background-color: #f9f9f9;
        transform: translateX(5px);
    }
    
    &.unread {
        background-color: rgba(66, 185, 131, 0.05);
        border-left: 3px solid #42b983;
    }
}

.message-avatar {
    margin-right: 15px;
    
    img {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        object-fit: cover;
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
    }
    
    .system-icon {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        background: linear-gradient(135deg, #42b983, #2c9e6a);
        display: flex;
        justify-content: center;
        align-items: center;
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
        
        i {
            color: white;
            font-size: 22px;
        }
    }
}

.message-body {
    flex: 1;
    min-width: 0;
}

.message-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 8px;
}

.sender-name {
    font-size: 16px;
    font-weight: 500;
    color: #333;
}

.message-time {
    font-size: 13px;
    color: #909399;
}

.message-content {
    margin-bottom: 10px;
    color: #606266;
    line-height: 1.5;
    font-size: 15px;
    word-break: break-word;
}

.message-actions-footer {
    display: flex;
    justify-content: flex-start;
}

.reply-button {
    color: #42b983;
    padding-left: 0;
    
    &:hover {
        color: #2c9e6a;
    }
    
    i {
        margin-right: 4px;
    }
}

/* 用户中心对话框样式 */
.user-center-content {
    padding: 10px;
}

.avatar-upload-section {
    margin-bottom: 20px;
    text-align: center;
}

.form-label {
    font-size: 14px;
    color: #606266;
    margin-bottom: 10px;
}

.form-item {
    margin-bottom: 20px;
}

.avatar-uploader {
    display: flex;
    justify-content: center;
    
    .el-upload {
        border: 1px dashed #d9d9d9;
        border-radius: 6px;
        cursor: pointer;
        overflow: hidden;
        
        &:hover {
            border-color: #42b983;
        }
    }
    
    .avatar {
        width: 100px;
        height: 100px;
        display: block;
        object-fit: cover;
    }
    
    .avatar-uploader-icon {
        font-size: 28px;
        color: #8c939d;
        width: 100px;
        height: 100px;
        line-height: 100px;
        text-align: center;
    }
}

@media screen and (max-width: 768px) {
    .top-nav {
        padding: 0 20px;
    }
    
    .page-header {
        padding: 30px 0;
    }
    
    .header-content h1 {
        font-size: 24px;
    }
    
    .message-container {
        padding: 0 15px 30px;
    }
    
    .message-actions {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
    }
    
    .action-right {
        width: 100%;
        justify-content: space-between;
    }
    
    .message-item {
        padding: 12px 10px;
    }
    
    .message-avatar img,
    .message-avatar .system-icon {
        width: 40px;
        height: 40px;
    }
}
</style>