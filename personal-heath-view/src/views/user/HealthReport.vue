<template>
  <div class="health-report-page">
    <!-- 添加统一风格的头部标签 -->
    <div class="page-header">
      <h2 class="page-title">个人体检报告</h2>
      <p class="page-subtitle">上传和管理您的体检报告，追踪健康状况变化</p>
    </div>
    
    <div class="upload-section">
      <!-- 基础表单上传 -->
      <el-form @submit.native.prevent>
        <el-form-item>
          <el-upload
            class="upload-area"
            action="#"
            :auto-upload="false"
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :on-change="handleChange"
            :file-list="fileList"
            :before-upload="() => { return false; }"
            multiple
            accept=".pdf,.jpg,.jpeg,.png,.gif,.bmp"
            drag>
            <i class="el-icon-upload"></i>
            <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
            <div class="el-upload__tip" slot="tip">支持上传PDF、JPG、PNG等格式的体检报告，单个文件不超过10MB</div>
          </el-upload>
        </el-form-item>
        
        <el-form-item style="text-align: center;">
          <div class="form-buttons">
            <button 
              type="button"
              class="custom-button upload-button" 
              @click="simpleUpload" 
              :disabled="fileList.length === 0" 
              :class="{'btn-loading': loading}">
              <i class="el-icon-upload2"></i>
              <span>{{ loading ? '上传中...' : '上传报告' }}</span>
            </button>
            
            <button 
              type="button"
              class="custom-button clear-button" 
              @click="clearFiles"
              :disabled="fileList.length === 0">
              <i class="el-icon-delete"></i>
              <span>清空文件</span>
            </button>
          </div>
        </el-form-item>
      </el-form>
    </div>
    
    <!-- 调试信息 -->
    <div class="debug-info" v-if="fileList.length > 0">
      <p>已选择 {{ fileList.length }} 个文件</p>
      <ul>
        <li v-for="(file, index) in fileList" :key="index">
          {{ file.name }} ({{ formatFileSize(file.size) }})
        </li>
      </ul>
    </div>
    
    <!-- 报告列表 -->
    <div class="report-list" v-if="reports.length > 0">
      <h3 class="section-title">我的体检报告</h3>
      
      <el-table :data="reports" style="width: 100%">
        <el-table-column prop="fileName" label="报告名称" width="250"></el-table-column>
        <el-table-column prop="uploadTime" label="上传时间" width="180"></el-table-column>
        <el-table-column prop="fileType" label="文件类型" width="120"></el-table-column>
        <el-table-column prop="fileSize" label="文件大小" width="120"></el-table-column>
        <el-table-column label="操作" width="100">
          <template slot-scope="scope">
            <div class="operation-buttons" style="display: flex; flex-direction: row; justify-content: center; align-items: center; gap: 8px;">
              <button class="table-btn view-table-btn" @click="viewReport(scope.row)" style="flex: 0 0 auto;" title="查看">
                <i class="el-icon-view"></i>
              </button>
              <button class="table-btn delete-table-btn" @click="deleteReport(scope.row)" style="flex: 0 0 auto;" title="删除">
                <i class="el-icon-delete"></i>
              </button>
            </div>
          </template>
        </el-table-column>
      </el-table>
    </div>
    
    <!-- 空状态 -->
    <div class="empty-state" v-else>
      <h3 class="section-title">我的体检报告</h3>
      <div class="empty-content">
        <i class="el-icon-folder-opened"></i>
        <p>暂无体检报告，请上传您的报告</p>
      </div>
    </div>
    
    <!-- 预览对话框 -->
    <el-dialog 
      title="报告预览" 
      :visible.sync="previewVisible" 
      width="80%" 
      :before-close="closePreview">
      <div v-if="currentReport">
        <!-- PDF预览 -->
        <div v-if="currentReport.fileType === 'pdf'" class="pdf-viewer">
          <iframe :src="currentReport.fileUrl" width="100%" height="600px" frameborder="0"></iframe>
        </div>
        
        <!-- 图片预览 -->
        <div v-else-if="['jpg', 'jpeg', 'png', 'gif', 'bmp'].includes(currentReport.fileType)" class="image-viewer">
          <img :src="currentReport.fileUrl" style="max-width: 100%;" />
        </div>
        
        <!-- 其他类型 -->
        <div v-else class="unsupported-file">
          <i class="el-icon-document"></i>
          <p>无法预览此类型的文件</p>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'HealthReport',
  data() {
    return {
      fileList: [],    // 上传文件列表
      reports: [],     // 已上传报告列表
      previewVisible: false,
      currentReport: null,
      loading: false,
      errorMessage: ''
    }
  },
  methods: {
    // 文件变化处理
    handleChange(file, fileList) {
      console.log('文件变化:', file.name);
      this.fileList = fileList;
    },
    
    // 移除文件
    handleRemove(file, fileList) {
      console.log('移除文件:', file.name);
      this.fileList = fileList;
    },
    
    // 预览文件
    handlePreview(file) {
      this.viewFile(file);
    },
    
    // 清空文件列表
    clearFiles() {
      this.fileList = [];
    },
    
    // 简化上传流程
    simpleUpload(event) {
      // 阻止默认行为，防止表单提交
      if (event) event.preventDefault();
      
      console.log('准备上传文件:', this.fileList.length);
      
      if (this.fileList.length === 0) {
        this.$message.warning('请先选择要上传的文件!');
        return;
      }
      
      this.loading = true;
      
      try {
        setTimeout(() => {
          try {
            // 创建示例报告数据
            const newReports = [];
            
            for (let file of this.fileList) {
              console.log('处理文件:', file.name);
              try {
                const extension = file.name.split('.').pop().toLowerCase();
                let url = '';
                
                // 尝试创建本地URL
                if (file.raw) {
                  url = URL.createObjectURL(file.raw);
                }
                
                newReports.push({
                  id: new Date().getTime() + '_' + Math.random().toString(36).substr(2, 9),
                  fileName: file.name,
                  uploadTime: new Date().toLocaleString(),
                  fileType: extension,
                  fileSize: this.formatFileSize(file.size),
                  fileUrl: url
                });
              } catch (err) {
                console.error('处理文件时出错:', err);
                this.$message.warning(`处理文件"${file.name}"时出错`);
              }
            }
            
            // 更新报告列表
            if (newReports.length > 0) {
              this.reports = [...newReports, ...this.reports];
              this.$message.success(`成功上传${newReports.length}个文件!`);
              this.fileList = []; // 清空上传列表
            }
          } catch (innerError) {
            console.error('处理文件列表时出错:', innerError);
            this.$message.error('处理文件时出错: ' + (innerError.message || '未知错误'));
          } finally {
            this.loading = false;
          }
        }, 1500); // 延时1.5秒模拟上传过程
        
      } catch (error) {
        console.error('上传过程发生错误:', error);
        this.$message.error('上传失败: ' + (error.message || '未知错误'));
        this.loading = false;
      }
    },
    
    // 查看报告
    viewReport(report) {
      this.currentReport = report;
      this.previewVisible = true;
    },
    
    // 预览上传文件
    viewFile(file) {
      try {
        const extension = file.name.split('.').pop().toLowerCase();
        let url = '';
        
        if (file.raw) {
          url = URL.createObjectURL(file.raw);
        }
        
        this.currentReport = {
          fileName: file.name,
          fileType: extension,
          fileUrl: url
        };
        
        this.previewVisible = true;
      } catch (error) {
        console.error('创建预览出错:', error);
        this.$message.error('无法预览此文件');
      }
    },
    
    // 删除报告
    deleteReport(report) {
      this.$confirm('确定要删除该报告吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        customClass: 'custom-confirm-box',
        confirmButtonClass: 'custom-confirm-btn',
        cancelButtonClass: 'custom-cancel-btn',
        closeOnClickModal: false,
        center: true,
        roundButton: true,
        dangerouslyUseHTMLString: true,
        showIcon: false,
        message: `<div class="custom-confirm-content">
                    <p>确定要删除该报告吗？</p>
                    <p class="file-name">${report.fileName}</p>
                  </div>`
      }).then(() => {
        this.reports = this.reports.filter(item => item.id !== report.id);
        this.$message.success('报告删除成功');
      }).catch(() => {});
    },
    
    // 关闭预览
    closePreview() {
      this.previewVisible = false;
      this.currentReport = null;
    },
    
    // 格式化文件大小
    formatFileSize(size) {
      if (size < 1024) {
        return size + ' B';
      } else if (size < 1024 * 1024) {
        return (size / 1024).toFixed(2) + ' KB';
      } else {
        return (size / 1024 / 1024).toFixed(2) + ' MB';
      }
    },
    
    // 加载示例数据
    loadSampleData() {
      if (this.reports.length === 0) {
        this.reports = [
          {
            id: '1',
            fileName: '2023年度体检报告.pdf',
            uploadTime: '2023-05-15 09:30',
            fileType: 'pdf',
            fileSize: '2.5 MB',
            fileUrl: ''
          }
        ];
      }
    }
  },
  mounted() {
    this.loadSampleData();
    console.log('健康报告组件已加载');
  }
}
</script>

<style>
.health-report-page {
  padding: 20px;
  background-color: #f8f9fa;
  min-height: calc(100vh - 60px);
}

/* 添加统一风格的头部样式 */
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

.upload-section {
  background-color: #fff;
  padding: 20px;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
  margin-bottom: 20px;
}

.upload-area {
  width: 100%;
}

.debug-info {
  background-color: #f0f9eb;
  padding: 15px;
  margin-bottom: 20px;
  border-radius: 4px;
  border-left: 3px solid #67c23a;
}

.report-list {
  background-color: #fff;
  padding: 20px;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
  margin-bottom: 20px;
}

.empty-state {
  background-color: #fff;
  padding: 20px;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
  margin-bottom: 20px;
}

.empty-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px 0;
  color: #909399;
}

.empty-content i {
  font-size: 48px;
  margin-bottom: 10px;
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 15px;
}

.pdf-viewer, .image-viewer {
  width: 100%;
  text-align: center;
}

.unsupported-file {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 300px;
  color: #909399;
}

.unsupported-file i {
  font-size: 48px;
  margin-bottom: 15px;
}

/* 表格中的按钮样式 */
.table-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
  border: none;
  border-radius: 50%;
  font-size: 12px;
  font-weight: 500;
  color: #fff;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15);
  width: 28px;
  height: 28px;
  position: relative;
  overflow: hidden;
}

.table-btn i {
  margin-right: 0;
  font-size: 14px;
}

.table-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.view-table-btn {
  background: linear-gradient(135deg, #0f753f 0%, #2eab60 100%);
}

.view-table-btn:hover {
  background: linear-gradient(135deg, #2eab60 0%, #0f753f 100%);
}

.delete-table-btn {
  background: linear-gradient(135deg, #f56c6c, #e74c3c);
}

.delete-table-btn:hover {
  background: linear-gradient(135deg, #e74c3c, #f56c6c);
}

/* 原始按钮样式恢复 */
.custom-button {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 16px;
  border: none;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 500;
  color: #fff;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
  min-width: 100px;
  height: 32px;
  letter-spacing: 0.5px;
  position: relative;
  overflow: hidden;
}

.custom-button::before {
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

.custom-button:hover::before {
  transform: translateX(0);
}

.custom-button:active {
  transform: translateY(2px);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
}

.custom-button i {
  margin-right: 8px;
  font-size: 16px;
}

.custom-button span {
  font-size: 14px;
  white-space: nowrap;
}

.custom-button[disabled] {
  opacity: 0.6;
  cursor: not-allowed;
}

.custom-button[disabled]:hover::before {
  transform: translateX(-100%);
}

.upload-button {
  background: linear-gradient(135deg, #0f753f 0%, #2eab60 100%);
  margin-right: 15px;
}

.upload-button:hover {
  background: linear-gradient(135deg, #2eab60 0%, #0f753f 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 15px rgba(15, 117, 63, 0.3);
}

.clear-button {
  background: linear-gradient(135deg, #0f753f 0%, #2eab60 100%);
}

.clear-button:hover {
  background: linear-gradient(135deg, #2eab60 0%, #0f753f 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 15px rgba(15, 117, 63, 0.3);
}

/* 表格操作按钮容器样式 */

/* 表格操作按钮容器 */
.operation-buttons {
  display: flex !important;
  align-items: center !important;
  flex-direction: row !important;
  gap: 8px !important;
  justify-content: center !important;
  width: 100% !important;
  flex-wrap: nowrap !important;
}

.btn-loading {
  position: relative;
  pointer-events: none;
}

.btn-loading::after {
  content: '';
  position: absolute;
  width: 16px;
  height: 16px;
  top: calc(50% - 8px);
  left: calc(50% - 8px);
  border: 2px solid #ffffff;
  border-radius: 50%;
  border-right-color: transparent;
  animation: btn-spin 0.8s linear infinite;
}

@keyframes btn-spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.form-buttons {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 15px;
}

/* 自定义确认对话框样式 */
.custom-confirm-box {
  border-radius: 12px !important;
  overflow: hidden;
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15) !important;
  padding-bottom: 20px !important;
  text-align: center !important;
}

.custom-confirm-box .el-message-box__header {
  background: linear-gradient(135deg, #42b983, #2c9e6a);
  padding: 15px 20px !important;
}

.custom-confirm-box .el-message-box__title {
  color: white !important;
  font-size: 22px !important;
  font-weight: 600 !important;
  text-align: center !important;
}

.custom-confirm-box .el-message-box__headerbtn .el-message-box__close {
  color: white !important;
  font-size: 22px !important;
}

.custom-confirm-box .el-message-box__content {
  padding: 30px 20px !important;
  display: flex !important;
  justify-content: center !important;
  align-items: center !important;
}

.custom-confirm-box .el-message-box__btns {
  padding: 10px 20px 5px !important;
  text-align: center !important;
  justify-content: center !important;
  display: flex !important;
}

.custom-confirm-content {
  text-align: center;
  padding: 15px 0;
  width: 100%;
}

.custom-confirm-content p {
  margin: 12px 0;
  font-size: 20px;
  line-height: 1.5;
  color: #303133;
  font-weight: 500;
}

.custom-confirm-content .file-name {
  color: #606266;
  font-size: 18px;
  margin-top: 16px;
  font-style: italic;
  word-break: break-all;
  max-width: 100%;
  padding: 0 20px;
}

.custom-icon {
  font-size: 32px !important;
  color: #f5a623 !important;
  margin-bottom: 15px !important;
  display: block !important;
  text-align: center !important;
}

.custom-confirm-btn {
  background: linear-gradient(135deg, #0f753f 0%, #2eab60 100%) !important;
  border: none !important;
  border-radius: 20px !important;
  padding: 10px 20px !important;
  font-size: 14px !important;
  font-weight: 500 !important;
  box-shadow: 0 4px 10px rgba(15, 117, 63, 0.2) !important;
  transition: all 0.3s ease !important;
}

.custom-confirm-btn:hover {
  background: linear-gradient(135deg, #2eab60 0%, #0f753f 100%) !important;
  transform: translateY(-2px) !important;
  box-shadow: 0 6px 15px rgba(15, 117, 63, 0.3) !important;
}

.custom-cancel-btn {
  background: transparent !important;
  border: 1px solid #dcdfe6 !important;
  border-radius: 20px !important;
  padding: 10px 20px !important;
  font-size: 14px !important;
  color: #606266 !important;
  margin-right: 15px !important;
  transition: all 0.3s ease !important;
}

.custom-cancel-btn:hover {
  color: #409EFF !important;
  border-color: #c6e2ff !important;
  background-color: #ecf5ff !important;
}

/* 覆盖Element UI表格样式，确保按钮横向排列 */
.el-table .cell {
  white-space: nowrap;
  padding-left: 5px !important;
  padding-right: 5px !important;
}

/* 只针对操作列进行修改 */
.el-table .el-table__row .el-table__cell:last-child .cell {
  display: flex !important;
  justify-content: center !important;
  align-items: center !important;
  flex-direction: row !important;
  flex-wrap: nowrap !important;
  gap: 8px !important;
  padding: 0 !important;
}

/* 确保其他列的文本对齐方式不受影响 */
.el-table .el-table__row .el-table__cell:not(:last-child) .cell {
  display: block !important;
}

/* 删除自定义垃圾桶图标样式 */
.trash-icon {
  display: none;
}

.trash-icon::before,
.trash-icon::after {
  display: none;
}

/* 确保垃圾桶图标正确显示 */
.clear-button i.el-icon-delete {
  font-size: 16px;
  margin-right: 8px;
  color: #ffffff;
}
</style> 