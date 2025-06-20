<template>
  <div class="ai-diagnosis">
    <el-card class="chat-container">
      <!-- 聊天消息容器 -->
      <div class="chat-messages" ref="chatBox">
        <!-- 聊天记录 -->
        <div v-for="(message, index) in messages" :key="index" 
             :class="['message', message.role === 'user' ? 'user-message' : 'ai-message']">
          <div class="message-content">
            <div class="avatar">
              <i :class="message.role === 'user' ? 'el-icon-user' : 'el-icon-service'"></i>
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
          placeholder="请描述您的症状或健康问题..."
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
          content: '您好！我是您的AI健康助手。请描述您的症状或健康问题，我会为您提供专业的建议。'
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
  max-height: calc(100vh - 240px);
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
}

.user-message .avatar {
  background-color: #409EFF;
  color: white;
}

.ai-message .avatar {
  background-color: #67C23A;
  color: white;
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