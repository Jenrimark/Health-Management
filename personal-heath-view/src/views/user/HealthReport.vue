<template>
  <div class="health-report-page">
    <h2 class="page-title">个人体检报告</h2>
    
    <div class="upload-section">
      <!-- 基础表单上传 -->
      <el-form>
        <el-form-item>
          <el-upload
            class="upload-area"
            action="#"
            :auto-upload="false"
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :on-change="handleChange"
            :file-list="fileList"
            multiple
            accept=".pdf,.jpg,.jpeg,.png,.gif,.bmp"
            drag>
            <i class="el-icon-upload"></i>
            <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
            <div class="el-upload__tip" slot="tip">支持上传PDF、JPG、PNG等格式的体检报告，单个文件不超过10MB</div>
          </el-upload>
        </el-form-item>
        
        <el-form-item style="text-align: center;">
          <el-button 
            type="primary" 
            @click="simpleUpload" 
            :disabled="fileList.length === 0" 
            :loading="loading">
            {{ loading ? '上传中...' : '上传报告' }}
          </el-button>
          
          <el-button 
            @click="clearFiles"
            :disabled="fileList.length === 0">
            清空文件
          </el-button>
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
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" @click="viewReport(scope.row)">查看</el-button>
            <el-button size="mini" type="danger" @click="deleteReport(scope.row)">删除</el-button>
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
    simpleUpload() {
      console.log('准备上传文件:', this.fileList.length);
      
      if (this.fileList.length === 0) {
        this.$message.warning('请先选择要上传的文件!');
        return;
      }
      
      this.loading = true;
      
      try {
        setTimeout(() => {
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
          
          this.loading = false;
        }, 1500); // 延时1.5秒模拟上传过程
        
      } catch (error) {
        console.error('上传过程发生错误:', error);
        this.$message.error('上传失败: ' + error.message);
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
      this.$confirm('确定要删除该报告吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
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

<style scoped>
.health-report-page {
  padding: 20px;
  background-color: #f8f9fa;
  min-height: calc(100vh - 60px);
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid #ebeef5;
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
</style> 