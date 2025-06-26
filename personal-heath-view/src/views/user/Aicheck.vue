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
                <el-avatar :src="userAvatar" v-if="userAvatar" class="ai-avatar-img"></el-avatar>
                <i class="el-icon-user" v-else></i>
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
      userAvatar: '',
      isTyping: false,
      typingSpeed: 50, // 打字速度，每字符毫秒数
      currentTypingMessage: '',
      thinkingAnimation: null, // 思考动画定时器
      thinkingDots: '', // 思考动画文本
      messages: [
        {
          role: 'assistant',
          content: '我是枫丹的大明星芙宁娜，哎呀呀！是来寻求健康秘诀的朋友吗？本枫丹首席健康规划专家芙宁娜闪亮登场！无论塑形、膳食还是作息，任何烦恼都放马过来，包在本专家身上！'
        }
      ]
    }
  },
  created() {
    // 获取用户头像
    this.getUserAvatar();
  },
  beforeDestroy() {
    // 组件销毁前清除定时器
    this.stopThinkingAnimation();
  },
  methods: {
    getUserAvatar() {
      // 从sessionStorage获取用户信息
      const userInfoStr = sessionStorage.getItem('userInfo');
      if (userInfoStr) {
        try {
          const userInfo = JSON.parse(userInfoStr);
          this.userAvatar = userInfo.userAvatar || '';
        } catch (error) {
          console.error('解析用户信息失败:', error);
        }
      }
    },
    async sendQuestion() {
      if (!this.question.trim()) return

      this.messages.push({
        role: 'user',
        content: this.question
      })

      const userQuestion = this.question
      this.question = ''
      this.loading = true
      
      // 添加一个空的AI回复消息占位
      this.messages.push({
        role: 'assistant',
        content: '.'
      })
      
      // 启动思考动画
      this.startThinkingAnimation()
      
      try {
        const response = await this.$axios.post('/api/personal-heath/v1.0/ai/aiDiagnosis', {
          question: userQuestion
        })

        // 获取完整的AI回复内容
        const aiResponse = response.data.choices[0].message.content
        
        // 停止思考动画
        this.stopThinkingAnimation()
        
        // 开始流式显示回复
        await this.typeMessage(aiResponse)
        
      } catch (error) {
        console.error('AI诊断失败:', error)
        this.$message.error('抱歉，服务出现问题，请稍后再试')
        
        // 停止思考动画
        this.stopThinkingAnimation()
        
        // 删除空的回复消息
        this.messages.pop()
      } finally {
        this.loading = false
        this.$nextTick(() => {
          this.scrollToBottom()
        })
      }
    },
    
    // 开始思考动画
    startThinkingAnimation() {
      // 获取当前消息的索引
      const messageIndex = this.messages.length - 1
      let dotCount = 1
      
      this.thinkingAnimation = setInterval(() => {
        // 循环显示 "."、".."、"..."
        this.thinkingDots = '.'.repeat(dotCount)
        this.$set(this.messages[messageIndex], 'content', this.thinkingDots)
        
        // 更新点的数量，循环1-3个点
        dotCount = dotCount % 3 + 1
        
        // 滚动到底部
        this.$nextTick(() => {
          this.scrollToBottom()
        })
      }, 500) // 每500毫秒更新一次
    },
    
    // 停止思考动画
    stopThinkingAnimation() {
      if (this.thinkingAnimation) {
        clearInterval(this.thinkingAnimation)
        this.thinkingAnimation = null
      }
    },
    
    // 模拟打字效果的方法
    async typeMessage(fullMessage) {
      this.isTyping = true
      this.currentTypingMessage = ''
      
      // 获取当前消息的索引
      const messageIndex = this.messages.length - 1
      
      // 逐个字符显示
      for (let i = 0; i < fullMessage.length; i++) {
        // 将字符追加到当前正在输入的消息中
        this.currentTypingMessage += fullMessage.charAt(i)
        
        // 更新消息内容
        this.$set(this.messages[messageIndex], 'content', this.currentTypingMessage)
        
        // 每添加一个字符滚动到底部
        this.$nextTick(() => {
          this.scrollToBottom()
        })
        
        // 等待一定时间模拟打字速度
        await new Promise(resolve => setTimeout(resolve, this.typingSpeed))
      }
      
      this.isTyping = false
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
  text-align: left;
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