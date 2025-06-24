<template>
     <div class="message-page">
        <!-- 统一风格的头部标题栏 -->
        <div class="page-header">
            <div class="header-content">
                <h1>消息中心</h1>
                <p>查看您的互动消息、系统通知及健康提醒</p>
            </div>
        </div>

        <!-- 主体内容区 -->
        <div class="message-container">
            <!-- 消息类型选择区 -->
            <div class="message-types-container">
                <div class="message-type-header">
                    <div class="message-type-tabs">
                        <span 
                            v-for="(messageType, index) in messageTypes" 
                            :key="index"
                            @click="messageTypeSelected(messageType.type)" 
                            :class="['message-type', messageQueryDto.messageType === messageType.type ? 'active' : '']"
                        >
                            <i v-if="messageType.icon" :class="messageType.icon"></i>
                            {{ messageType.detail }}
                        </span>
                    </div>
                    <div class="action-right">
                        <el-tooltip content="将所有消息标记为已读" placement="top">
                            <el-button type="text" @click="clearMessage" class="clear-button">
                                <i class="el-icon-s-open"></i> 全部已读
                            </el-button>
                        </el-tooltip>
                    </div>
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
    </div>
</template>

<script>
import Swal from 'sweetalert2';
import { clearToken } from "@/utils/storage.js";

export default {
    components: { },
    data() {
        return {
            userInfo: {},
            messageQueryDto: {
                messageType: null
            },
            messageList: [],
            messageTypes: [],
            dialogEvaluationsOperation: false,
            message: {}
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
                    // 添加图标信息
                    this.messageTypes.forEach(item => {
                        // 根据消息类型设置对应图标
                        if (item.detail === '评论') {
                            item.icon = 'el-icon-chat-dot-round';
                        } else if (item.detail === '点赞') {
                            item.icon = 'el-icon-star-on';
                        } else if (item.detail === '指标提醒') {
                            item.icon = 'el-icon-data-analysis';
                        } else if (item.detail === '系统通知') {
                            item.icon = 'el-icon-bell';
                        }
                    });
                    // 添加全部消息选项，并设置图标
                    const messageType = { type: null, detail: '全部消息', icon: 'el-icon-document' };
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

    },
};
</script>

<style scoped lang="scss">


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
    padding-bottom: 15px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
    padding: 15px 20px;
}

.message-type-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.message-type-tabs {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
}

.message-type {
    padding: 8px 16px;
    font-size: 15px;
    color: #606266;
    cursor: pointer;
    border-radius: 20px;
    transition: all 0.3s;
    display: flex;
    align-items: center;
    gap: 6px;
    
    i {
        font-size: 16px;
    }
    
    &:hover {
        color: #42b983;
        background-color: rgba(66, 185, 131, 0.08);
        transform: translateY(-2px);
    }
    
    &.active {
        color: white;
        background-color: #42b983;
        font-weight: 500;
        box-shadow: 0 4px 8px rgba(66, 185, 131, 0.2);
    }
}

/* 消息列表区 */
.message-list-container {
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
    padding: 20px;
    margin-top: 20px;
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



@media screen and (max-width: 768px) {
    
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