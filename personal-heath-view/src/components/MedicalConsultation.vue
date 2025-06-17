<template>
  <div>
    <h1>AI 问诊服务</h1>
    <textarea v-model="question" placeholder="请输入问诊信息" rows="5"></textarea>
    <button @click="getDiagnosis">获取诊断结果</button>
    <div v-if="diagnosisResult" style="margin-top: 20px;">
      <h2>诊断结果</h2>
      <pre>{{ diagnosisResult }}</pre>
      </div>
    <div v-if="errorMessage" style="color: red; margin-top: 20px;">
      {{ errorMessage }}
      </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      question: '', // 问诊信息
      diagnosisResult: null, // 诊断结果
      errorMessage: null // 错误信息
    };
  },
  methods: {
    /**
     * 获取 AI 诊断结果
     */
    async getDiagnosis() {
      try {
        // 清空之前的结果和错误信息
        this.diagnosisResult = null;
        this.errorMessage = null;

        // 构建请求参数对象
        const requestData = {
          question: this.question
        };

        // 发送请求到后端接口
        const response = await axios.post('/api/personal-heath/v1.0/ai/aiDiagnosis', requestData);

        // 处理响应
        if (response.data.code === 200) {
          this.diagnosisResult = response.data.data;
        } else {
          this.errorMessage = response.data.message;
        }
      } catch (error) {
        console.error('请求出错:', error);
        if (error.response && error.response.status === 404) {
          this.errorMessage = '请求的接口未找到，请检查接口地址是否正确。';
        } else {
          this.errorMessage = '请求出错，请稍后再试';
        }
      }
    }
  }
};
</script>

<style scoped>
textarea {
  width: 100%;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

button {
  margin-top: 10px;
  padding: 10px 20px;
  font-size: 16px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}

pre {
  background-color: #f8f9fa;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  white-space: pre-wrap;
}
</style>