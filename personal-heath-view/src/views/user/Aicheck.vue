<template>
  <div class="ai-diagnosis">
    <div class="page-header">
      <h2 class="page-title">智能问答</h2>
      <p class="page-subtitle">描述您的症状或健康问题，AI将为您提供专业的健康建议</p>
    </div>
    
    <el-card class="chat-container">
      <!-- 聊天消息容器 -->
      <div class="chat-messages" ref="chatBox">
        <!-- 聊天记录 -->
        <div v-for="(message, index) in messages" :key="index" 
             :class="['message', message.role === 'user' ? 'user-message' : 'ai-message']">
          <div class="message-content">
            <div class="avatar">
              <template v-if="message.role === 'user'">
                <i class="el-icon-user"></i>
              </template>
              <template v-else>
                <img src="/fnn.jpg" alt="AI助手" class="ai-avatar-img" />
              </template>
            </div>
            <div class="text">{{ message.content }}</div>
          </div>
        </div>
      </div>

      <!-- 输入框区域 -->
      <div class="input-area">
        <el-input
          v-model="question"
          type="textarea"
          :rows="3"
          placeholder="把答案留给时间去验证吧~"
          :disabled="loading"
        />
        <el-button 
          type="primary" 
          @click="sendQuestion" 
          :loading="loading"
          :disabled="!question.trim()">
          发送
        </el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'AiDiagnosis',
  data() {
    return {
      question: '',
      loading: false,
      messages: [
        {
          role: 'assistant',
          content: '我是枫丹的大明星芙宁娜，哎呀呀！是来寻求健康秘诀的朋友吗？本枫丹首席健康规划专家芙宁娜闪亮登场！无论塑形、膳食还是作息，任何烦恼都放马过来，包在本专家身上！'
        }
      ]
    }
  },
  methods: {
    async sendQuestion() {
      if (!this.question.trim()) return

      this.messages.push({
        role: 'user',
        content: this.question
      })

      this.loading = true
      try {
        const response = await this.$axios.post('/api/personal-heath/v1.0/ai/aiDiagnosis', {
          question: this.question
        })

        this.messages.push({
          role: 'assistant',
          content: response.data.choices[0].message.content
        })

        this.question = ''
      } catch (error) {
        console.error('AI诊断失败:', error)
        this.$message.error('抱歉，服务出现问题，请稍后再试')
      } finally {
        this.loading = false
        this.$nextTick(() => {
          this.scrollToBottom()
        })
      }
    },
    scrollToBottom() {
      const chatBox = this.$refs.chatBox
      chatBox.scrollTop = chatBox.scrollHeight
    }
  }
}
</script>

<style scoped lang="scss">
.ai-diagnosis {
  padding: 20px;
  height: calc(100vh - 120px);
  display: flex;
  flex-direction: column;
}

/* 添加页面头部样式 */
.page-header {
  background: linear-gradient(135deg, #42b983, #2c9e6a);
  color: white;
  border-radius: 12px;
  padding: 25px 30px;
  margin-bottom: 30px;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  margin: 0 0 10px;
  color: white;
}

.page-subtitle {
  font-size: 14px;
  margin: 0;
  opacity: 0.9;
}

.chat-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  background-color: #ffffff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.chat-messages {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
  margin-bottom: 20px;
  max-height: calc(100vh - 290px); /* 调整高度以适应新添加的页面头部 */
  scroll-behavior: smooth; /* 平滑滚动 */
}

.message {
  margin-bottom: 20px;
}

.message-content {
  display: flex;
  align-items: flex-start;
  max-width: 80%;
}

.user-message {
  justify-content: flex-end;
}

.user-message .message-content {
  flex-direction: row-reverse;
  margin-left: auto;
}

.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: #f0f2f5;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 10px;
  flex-shrink: 0;
  overflow: hidden;
}

.user-message .avatar {
  background-color: #409EFF;
  color: white;
}

.ai-message .avatar {
  background-color: #67C23A;
  color: white;
}

.ai-avatar-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.text {
  background-color: #f0f2f5;
  padding: 12px 16px;
  border-radius: 8px;
  word-break: break-word;
  font-size: 14px;
  line-height: 1.5;
}

.user-message .text {
  background-color: #409EFF;
  color: white;
}

.input-area {
  padding: 20px;
  border-top: 1px solid #EBEEF5;
  display: flex;
  gap: 10px;
  background-color: #ffffff;
  position: sticky;
  bottom: 0;
  z-index: 1;
  box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.05);
}

.input-area .el-textarea {
  flex: 1;
}

.input-area .el-button {
  align-self: flex-end;
  background-color: #409EFF;
  border-color: #409EFF;
  color: white;
  transition: background-color 0.3s ease;
}

.input-area .el-button:hover {
  background-color: #66b1ff;
  border-color: #66b1ff;
}
</style>