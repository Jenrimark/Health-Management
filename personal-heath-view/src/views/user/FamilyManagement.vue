<template>
  <div class="family-management">
    <div class="page-header">
      <h2 class="title">家庭成员管理</h2>
      <el-button type="primary" size="small" icon="el-icon-plus" @click="showAddMemberDialog">添加家庭成员</el-button>
    </div>

    <!-- 家庭成员列表 -->
    <el-row :gutter="20" class="member-list">
      <el-col :xs="24" :sm="12" :md="8" :lg="6" v-for="(member, index) in familyMembers" :key="index">
        <div class="member-card-wrapper" @click="selectMember(member)">
          <el-card :class="['member-card', { active: currentMember && currentMember.id === member.id }]">
            <div class="member-avatar">
              <img 
                :src="member.avatar || require('@/assets/img/default-avatar.png')" 
                alt="头像" 
                @error="handleAvatarError($event, member)"
              >
            </div>
            <div class="member-info">
              <h3>{{ member.name }}</h3>
              <p>{{ member.relation }}</p>
              <p>{{ calculateAge(member.birthday) }}岁</p>
              <el-button type="primary" size="mini" @click.stop="selectMember(member)" style="margin-top: 10px;">查看健康数据</el-button>
            </div>
            <div class="member-actions">
              <el-button type="text" icon="el-icon-edit" @click.stop="editMember(member)"></el-button>
              <el-button type="text" icon="el-icon-key" @click.stop="resetPassword(member)" title="重置密码"></el-button>
              <el-button type="text" icon="el-icon-delete" @click.stop="confirmDelete(member)"></el-button>
            </div>
          </el-card>
          
          <!-- 账号密码信息卡片 -->
          <el-card class="account-info-card">
            <div class="account-info-title">账号信息</div>
            <div class="account-info-item">
              <span class="label">账号:</span> 
              <span class="value">{{ member.username }}</span>
              <el-tooltip content="复制账号" placement="top">
                <el-button type="text" size="mini" @click.stop="copyToClipboard(member.username, '账号')" icon="el-icon-document-copy"></el-button>
              </el-tooltip>
            </div>
            <div class="account-info-item">
              <span class="label">密码:</span> 
              <span class="value" v-if="member.showPassword">{{ member.password || '******' }}</span>
              <span class="value" v-else>******</span>
              <el-tooltip :content="member.showPassword ? '隐藏密码' : '查看密码'" placement="top">
                <el-button type="text" size="mini" class="password-view-btn" @click.stop="togglePasswordVisibility(member)">
                  <i :class="member.showPassword ? 'el-icon-view' : 'el-icon-search'"></i>
                </el-button>
              </el-tooltip>
              <el-tooltip v-if="member.showPassword" content="放大查看" placement="top">
                <el-button type="text" size="mini" @click.stop="showPasswordMagnified(member.password)" icon="el-icon-zoom-in"></el-button>
              </el-tooltip>
              <el-tooltip v-if="member.showPassword" content="复制密码" placement="top">
                <el-button type="text" size="mini" @click.stop="copyToClipboard(member.password, '密码')" icon="el-icon-document-copy"></el-button>
              </el-tooltip>
            </div>
          </el-card>
        </div>
      </el-col>
    </el-row>

    <!-- 当前选中家庭成员的健康数据 -->
    <div class="member-data" v-if="currentMember">
      <div class="section-header">
        <h3>{{ currentMember.name }}的健康数据</h3>
        <el-tabs v-model="activeTab">
          <el-tab-pane label="健康指标" name="healthMetrics">
            <div class="metrics-grid" v-if="healthData.metrics && healthData.metrics.length">
              <el-card v-for="(metric, idx) in healthData.metrics" :key="idx" class="metric-card">
                <div class="metric-value">{{ metric.value }}{{ metric.unit }}</div>
                <div class="metric-name">{{ metric.name }}</div>
                <div class="metric-status" :class="getStatusClass(metric.status)">
                  {{ metric.status === 'normal' ? '正常' : '异常' }}
                </div>
              </el-card>
            </div>
            <el-empty v-else description="暂无健康指标数据"></el-empty>
          </el-tab-pane>
          <el-tab-pane label="运动记录" name="exerciseRecords">
            <el-table :data="healthData.exercises || []" style="width: 100%" v-if="healthData.exercises && healthData.exercises.length">
              <el-table-column prop="date" label="日期" width="180"></el-table-column>
              <el-table-column prop="type" label="运动类型" width="120"></el-table-column>
              <el-table-column prop="duration" label="时长(分钟)"></el-table-column>
              <el-table-column prop="calories" label="消耗(卡路里)"></el-table-column>
            </el-table>
            <el-empty v-else description="暂无运动记录数据"></el-empty>
          </el-tab-pane>
          <el-tab-pane label="饮食记录" name="dietRecords">
            <el-table :data="healthData.diets || []" style="width: 100%" v-if="healthData.diets && healthData.diets.length">
              <el-table-column prop="date" label="日期" width="180"></el-table-column>
              <el-table-column prop="mealTime" label="餐次" width="120"></el-table-column>
              <el-table-column prop="food" label="食物"></el-table-column>
              <el-table-column prop="calories" label="热量(卡路里)"></el-table-column>
            </el-table>
            <el-empty v-else description="暂无饮食记录数据"></el-empty>
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>

    <el-empty v-else description="请选择一个家庭成员查看健康数据"></el-empty>

    <!-- 添加/编辑家庭成员对话框 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="30%">
      <el-form :model="memberForm" :rules="memberRules" ref="memberForm" label-width="80px">
        <el-form-item label="姓名" prop="name">
          <el-input v-model="memberForm.name" placeholder="请输入家庭成员姓名"></el-input>
        </el-form-item>
        <el-form-item label="关系" prop="relation">
          <el-select v-model="memberForm.relation" placeholder="请选择与您的关系" style="width: 100%">
            <el-option label="配偶" value="配偶"></el-option>
            <el-option label="父亲" value="父亲"></el-option>
            <el-option label="母亲" value="母亲"></el-option>
            <el-option label="儿子" value="儿子"></el-option>
            <el-option label="女儿" value="女儿"></el-option>
            <el-option label="其他" value="其他"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="账号" prop="username">
          <el-input v-model="memberForm.username" placeholder="请输入登录账号"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password" v-if="!isEditing">
          <el-input v-model="memberForm.password" placeholder="请输入登录密码" type="password" show-password></el-input>
        </el-form-item>
        <el-form-item label="出生日期" prop="birthday">
          <el-date-picker v-model="memberForm.birthday" type="date" placeholder="选择出生日期" style="width: 100%"></el-date-picker>
        </el-form-item>
        <el-form-item label="性别" prop="gender">
          <el-radio-group v-model="memberForm.gender">
            <el-radio :label="1">男</el-radio>
            <el-radio :label="0">女</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="头像">
          <el-upload
            class="avatar-uploader"
            action="#"
            :http-request="handleCustomUpload"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload">
            <img v-if="memberForm.avatar" :src="memberForm.avatar" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
          <div class="upload-tip">点击上传头像（支持JPG、PNG格式，小于2MB）</div>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveMember">确 定</el-button>
      </span>
    </el-dialog>

    <!-- 删除确认对话框 -->
    <el-dialog
      title="删除确认"
      :visible.sync="deleteDialogVisible"
      width="30%">
      <span>确定要删除家庭成员 {{ memberToDelete ? memberToDelete.name : '' }} 吗？</span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="deleteDialogVisible = false">取 消</el-button>
        <el-button type="danger" @click="deleteMember">确 定</el-button>
      </span>
    </el-dialog>

    <!-- 重置密码对话框 -->
    <el-dialog
      title="重置密码"
      :visible.sync="resetPwdDialog"
      width="30%">
      <el-form :model="resetPwdMember" :rules="resetPwdRules" ref="resetPwdForm" label-width="80px">
        <el-form-item label="新密码" prop="password">
          <el-input v-model="newPassword" placeholder="请输入新密码" type="password" show-password>
            <el-button slot="append" @click="generateRandomPassword">随机</el-button>
          </el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="resetPwdDialog = false">取 消</el-button>
        <el-button type="primary" @click="confirmResetPassword">确 定</el-button>
      </span>
    </el-dialog>

    <!-- 密码放大查看对话框 -->
    <el-dialog
      title="密码放大查看"
      :visible.sync="passwordPreviewDialog"
      width="30%">
      <div class="password-preview">
        <div class="password-preview-content">{{ passwordToPreview }}</div>
        <div class="password-preview-actions">
          <el-button type="primary" size="small" @click="copyToClipboard(passwordToPreview, '密码')">
            <i class="el-icon-document-copy"></i> 复制密码
          </el-button>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="passwordPreviewDialog = false">关闭</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'FamilyManagement',
  data() {
    return {
      familyMembers: [],
      currentMember: null,
      dialogVisible: false,
      dialogTitle: '添加家庭成员',
      deleteDialogVisible: false,
      memberToDelete: null,
      isEditing: false,
      activeTab: 'healthMetrics',
      healthData: {
        metrics: [],
        exercises: [],
        diets: []
      },
      memberForm: {
        id: '',
        name: '',
        relation: '',
        username: '',
        password: '',
        birthday: '',
        gender: 1,
        avatar: '',
        parentUserId: '' // 关联的主用户ID
      },
      memberRules: {
        name: [
          { required: true, message: '请输入家庭成员姓名', trigger: 'blur' }
        ],
        relation: [
          { required: true, message: '请选择与您的关系', trigger: 'change' }
        ],
        username: [
          { required: true, message: '请输入登录账号', trigger: 'blur' },
          { min: 4, max: 20, message: '长度在 4 到 20 个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入登录密码', trigger: 'blur' },
          { min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur' }
        ],
        birthday: [
          { required: true, message: '请选择出生日期', trigger: 'change' }
        ],
        gender: [
          { required: true, message: '请选择性别', trigger: 'change' }
        ]
      },
      // 重置密码对话框
      resetPwdDialog: false,
      resetPwdMember: null,
      newPassword: '',
      resetPwdRules: {
        password: [
          { required: true, message: '请输入新密码', trigger: 'blur' },
          { min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur' }
        ]
      },
      // 密码放大查看对话框
      passwordPreviewDialog: false,
      passwordToPreview: ''
    }
  },
  created() {
    this.fetchFamilyMembers()
    // 添加一个延时，确保家庭成员数据加载完成后再选择默认成员
    setTimeout(() => {
      if (this.familyMembers.length > 0) {
        this.selectMember(this.familyMembers[0])
      }
    }, 500)
  },
  methods: {
    // 获取家庭成员列表
    fetchFamilyMembers() {
      // 获取当前登录用户ID
      const userInfo = JSON.parse(sessionStorage.getItem('userInfo') || '{}');
      const currentUserId = userInfo.id || '';
      
      // 实际项目中应该从API获取数据
      // this.$axios.get('/api/family-members', {
      //   params: { parentUserId: currentUserId }
      // }).then(res => {
      //   this.familyMembers = res.data.data;
      // });
      
      // 模拟数据
      this.familyMembers = [
        { 
          id: '1', 
          name: '张三', 
          relation: '配偶', 
          username: 'zhangsan123',
          password: 'zhangsan123',
          birthday: '1985-05-15', 
          gender: 0,
          avatar: '',
          parentUserId: currentUserId,
          showPassword: false // 控制密码是否显示
        },
        { 
          id: '2', 
          name: '小明', 
          relation: '儿子', 
          username: 'xiaoming456',
          password: 'xiaoming456',
          birthday: '2010-08-20', 
          gender: 1,
          avatar: '',
          parentUserId: currentUserId,
          showPassword: false // 控制密码是否显示
        }
      ];
    },
    
    // 显示添加成员对话框
    showAddMemberDialog() {
      this.isEditing = false
      this.dialogTitle = '添加家庭成员'
      
      // 生成默认账号和密码
      const defaultUsername = 'user_' + Math.floor(Math.random() * 10000);
      const defaultPassword = this.generateRandomString(8);
      
      this.memberForm = {
        id: '',
        name: '',
        relation: '',
        username: defaultUsername,
        password: defaultPassword,
        birthday: '',
        gender: 1,
        avatar: '',
        parentUserId: '' // 关联的主用户ID
      }
      this.dialogVisible = true
    },
    
    // 编辑成员
    editMember(member) {
      this.isEditing = true;
      this.dialogTitle = '编辑家庭成员';
      
      // 深拷贝成员数据，避免直接修改列表中的数据
      this.memberForm = JSON.parse(JSON.stringify(member));
      
      // 确保头像URL正确显示
      if (!this.memberForm.avatar) {
        // 如果没有头像，使用默认头像
        this.memberForm.avatar = require('@/assets/img/default-avatar.png');
      }
      
      this.dialogVisible = true;
    },
    
    // 确认删除
    confirmDelete(member) {
      this.memberToDelete = member
      this.deleteDialogVisible = true
    },
    
    // 删除成员
    deleteMember() {
      if (!this.memberToDelete) return
      
      // 实际项目中应该调用API删除
      // this.$axios.delete(`/api/family-members/${this.memberToDelete.id}`).then(() => {
      //   this.familyMembers = this.familyMembers.filter(m => m.id !== this.memberToDelete.id)
      //   this.$message.success('删除成功')
      //   this.deleteDialogVisible = false
      //   this.memberToDelete = null
      //   
      //   // 如果删除的是当前选中的成员，清空当前选中
      //   if (this.currentMember && this.currentMember.id === this.memberToDelete.id) {
      //     this.currentMember = null
      //   }
      // })
      
      // 模拟删除
      this.familyMembers = this.familyMembers.filter(m => m.id !== this.memberToDelete.id)
      this.$message.success('删除成功')
      this.deleteDialogVisible = false
      
      // 如果删除的是当前选中的成员，清空当前选中
      if (this.currentMember && this.currentMember.id === this.memberToDelete.id) {
        this.currentMember = null
        this.healthData = {
          metrics: [],
          exercises: [],
          diets: []
        }
      }
      
      this.memberToDelete = null
    },
    
    // 保存成员信息
    saveMember() {
      this.$refs.memberForm.validate(valid => {
        if (!valid) return;
        
        // 获取当前登录用户ID
        const userInfo = JSON.parse(sessionStorage.getItem('userInfo') || '{}');
        const currentUserId = userInfo.id || '';
        
        // 添加关联用户ID
        this.memberForm.parentUserId = currentUserId;
        
        // 实际项目中应该调用API保存
        // const api = this.isEditing ? 
        //   this.$axios.put(`/api/family-members/${this.memberForm.id}`, this.memberForm) :
        //   this.$axios.post('/api/family-members', this.memberForm);
        // 
        // api.then(res => {
        //   const savedMember = res.data.data;
        //   if (this.isEditing) {
        //     const index = this.familyMembers.findIndex(m => m.id === savedMember.id);
        //     if (index !== -1) {
        //       this.familyMembers.splice(index, 1, savedMember);
        //     }
        //   } else {
        //     this.familyMembers.push(savedMember);
        //   }
        //   this.$message.success(this.isEditing ? '更新成功' : '添加成功');
        //   this.dialogVisible = false;
        // });
        
        // 模拟保存
        if (this.isEditing) {
          // 编辑时不修改密码
          const memberWithoutPassword = {...this.memberForm};
          delete memberWithoutPassword.password;
          
          const index = this.familyMembers.findIndex(m => m.id === this.memberForm.id);
          if (index !== -1) {
            this.familyMembers.splice(index, 1, memberWithoutPassword);
          }
          this.$message.success('更新成功');
        } else {
          const newMember = { 
            ...this.memberForm,
            id: Date.now().toString() // 模拟ID生成
          };
          this.familyMembers.push(newMember);
          
          // 显示账号密码信息
          this.$alert(`家庭成员账号创建成功！<br/><br/>账号：${newMember.username}<br/>密码：${newMember.password}<br/><br/>请记住这些信息，用于家庭成员登录。`, '账号信息', {
            dangerouslyUseHTMLString: true,
            confirmButtonText: '确定',
            callback: () => {
              this.$message.success('添加成功');
            }
          });
        }
        this.dialogVisible = false;
      });
    },
    
    // 选择成员查看详情
    selectMember(member) {
      this.currentMember = member
      this.fetchMemberHealthData(member.id)
      // 添加日志输出，以便调试
      console.log('选择家庭成员:', member.name, '，ID:', member.id)
      this.$message.success(`已选择家庭成员: ${member.name}`)
    },
    
    // 获取成员健康数据
    fetchMemberHealthData(memberId) {
      // 实际项目中应该从API获取数据
      // this.$axios.get(`/api/family-members/${memberId}/health-data`).then(res => {
      //   this.healthData = res.data.data
      // })
      
      // 模拟数据
      this.healthData = {
        metrics: [
          { name: '体重', value: '65', unit: 'kg', status: 'normal' },
          { name: '身高', value: '175', unit: 'cm', status: 'normal' },
          { name: '血压', value: '120/80', unit: 'mmHg', status: 'normal' },
          { name: '血糖', value: '5.6', unit: 'mmol/L', status: 'normal' },
          { name: '体温', value: '36.5', unit: '°C', status: 'normal' },
          { name: '心率', value: '75', unit: '次/分', status: 'normal' }
        ],
        exercises: [
          { date: '2025-06-22', type: '跑步', duration: 30, calories: 300 },
          { date: '2023-10-14', type: '游泳', duration: 45, calories: 400 },
          { date: '2023-10-12', type: '骑行', duration: 60, calories: 450 }
        ],
        diets: [
          { date: '2025-06-22', mealTime: '早餐', food: '燕麦粥、鸡蛋、牛奶', calories: 450 },
          { date: '2025-06-22', mealTime: '午餐', food: '米饭、红烧排骨、青菜', calories: 650 },
          { date: '2025-06-22', mealTime: '晚餐', food: '全麦面包、沙拉、水果', calories: 500 }
        ]
      }
    },
    
    // 计算年龄
    calculateAge(birthday) {
      if (!birthday) return 0
      
      const birthDate = new Date(birthday)
      const today = new Date()
      let age = today.getFullYear() - birthDate.getFullYear()
      const monthDiff = today.getMonth() - birthDate.getMonth()
      
      if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
        age--
      }
      
      return age
    },
    
    // 获取状态样式
    getStatusClass(status) {
      return {
        'status-normal': status === 'normal',
        'status-abnormal': status === 'abnormal'
      }
    },
    
    // 头像上传成功回调
    handleAvatarSuccess(res, file) {
      // 实际项目中应该处理上传返回的URL
      // this.memberForm.avatar = res.data.url
      
      // 由于我们使用了自定义的上传处理，所以这个函数不会被调用
      // 保留它是为了与原来的代码兼容
    },
    
    // 头像上传前验证
    beforeAvatarUpload(file) {
      const isImage = file.type.indexOf('image/') === 0;
      const isLt2M = file.size / 1024 / 1024 < 2;
      
      if (!isImage) {
        this.$message.error('上传头像图片只能是图片格式 (JPG, PNG, GIF等)!');
        return false;
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
        return false;
      }
      
      // 如果验证通过，返回true
      return isImage && isLt2M;
    },
    
    // 切换密码可见性
    togglePasswordVisibility(member) {
      member.showPassword = !member.showPassword;
    },
    
    // 复制到剪贴板
    copyToClipboard(text, label) {
      const input = document.createElement('input');
      input.value = text;
      document.body.appendChild(input);
      input.select();
      document.execCommand('copy');
      document.body.removeChild(input);
      this.$message.success(`${label} 已复制到剪贴板`);
    },
    
    // 重置密码
    resetPassword(member) {
      this.resetPwdMember = member;
      this.newPassword = '';
      this.resetPwdDialog = true;
    },
    
    // 确认重置密码
    confirmResetPassword() {
      if (!this.newPassword) {
        this.$message.error('请输入新密码');
        return;
      }
      
      // 实际项目中应该调用API重置密码
      // this.$axios.put(`/api/family-members/${this.resetPwdMember.id}/reset-password`, {
      //   newPassword: this.newPassword
      // }).then(() => {
      //   this.$message.success('密码重置成功');
      //   this.resetPwdDialog = false;
      // });
      
      // 模拟重置密码
      const index = this.familyMembers.findIndex(m => m.id === this.resetPwdMember.id);
      if (index !== -1) {
        this.familyMembers[index].password = this.newPassword;
        this.familyMembers[index].showPassword = true; // 自动显示新密码
        this.$message.success('密码重置成功');
        this.resetPwdDialog = false;
      }
    },
    
    // 生成随机字符串
    generateRandomString(length) {
      const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
      let result = '';
      for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * charset.length);
        result += charset[randomIndex];
      }
      return result;
    },
    
    // 生成随机密码
    generateRandomPassword() {
      const length = 12;
      const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>?";
      let password = '';
      for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * charset.length);
        password += charset[randomIndex];
      }
      this.newPassword = password;
    },
    
    // 显示密码放大查看对话框
    showPasswordMagnified(password) {
      this.passwordToPreview = password;
      this.passwordPreviewDialog = true;
    },

    // 自定义上传逻辑
    handleCustomUpload(event) {
      // 这里可以添加自定义的上传逻辑
      // 例如，使用 FormData 对象将文件上传到服务器
      const file = event.file;
      
      // 在实际项目中，应该上传到服务器
      // const formData = new FormData();
      // formData.append('file', file);
      
      // 使用 axios 发送 POST 请求到服务器
      // this.$axios.post('/api/upload', formData, {
      //   headers: {
      //     'Content-Type': 'multipart/form-data'
      //   }
      // }).then(res => {
      //   if (res.data.code === 200) {
      //     this.memberForm.avatar = res.data.data;
      //     this.$message.success('头像上传成功');
      //   } else {
      //     this.$message.error('头像上传失败');
      //   }
      // }).catch(err => {
      //   console.error('上传错误:', err);
      //   this.$message.error('上传发生错误');
      // });
      
      // 模拟上传成功，使用本地文件URL
      this.memberForm.avatar = URL.createObjectURL(file);
      this.$message.success('头像上传成功');
      
      // 通知上传组件上传成功
      event.onSuccess();
    },

    // 处理头像加载错误
    handleAvatarError(event, member) {
      // 这里可以添加处理头像加载错误的逻辑
      // 例如，设置一个默认头像
      member.avatar = require('@/assets/img/default-avatar.png');
    }
  }
}
</script>

<style scoped>
.family-management {
  padding: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.title {
  font-size: 22px;
  color: #333;
  margin: 0;
}

.member-list {
  margin-bottom: 30px;
}

.member-card-wrapper {
  cursor: pointer;
  transition: all 0.3s;
  position: relative;
  z-index: 1;
  margin-bottom: 15px;
}

.member-card-wrapper:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}

.member-card {
  display: flex;
  align-items: center;
  padding: 15px;
  height: 100%;
}

.member-card.active {
  border-color: #409EFF;
  background-color: #ecf5ff;
}

.member-avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  overflow: hidden;
  margin-right: 15px;
  flex-shrink: 0;
}

.member-avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.member-info {
  flex-grow: 1;
}

.member-info h3 {
  margin: 0 0 5px;
  font-size: 16px;
}

.member-info p {
  margin: 0;
  color: #666;
  font-size: 14px;
}

.member-actions {
  position: absolute;
  top: 10px;
  right: 10px;
  z-index: 2;
}

.section-header {
  margin-bottom: 20px;
}

.section-header h3 {
  font-size: 18px;
  color: #333;
  margin: 0 0 15px;
}

.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.metric-card {
  text-align: center;
  padding: 20px;
}

.metric-value {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-bottom: 5px;
}

.metric-name {
  color: #666;
  margin-bottom: 10px;
}

.metric-status {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 10px;
  font-size: 12px;
}

.status-normal {
  background-color: #f0f9eb;
  color: #67c23a;
}

.status-abnormal {
  background-color: #fef0f0;
  color: #f56c6c;
}

.avatar-uploader {
  text-align: center;
}

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: all 0.3s;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
  box-shadow: 0 0 8px rgba(64, 158, 255, 0.3);
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  line-height: 100px;
  text-align: center;
  border-radius: 50%;
  background-color: #f8f8f8;
}

.avatar {
  width: 100px;
  height: 100px;
  display: block;
  border-radius: 50%;
  object-fit: cover;
}

.account-info-card {
  margin-top: 10px;
  padding: 10px;
  background-color: #f8f8f8;
  border-radius: 4px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  border-left: 3px solid #409EFF;
}

.account-info-title {
  font-size: 14px;
  font-weight: bold;
  margin-bottom: 10px;
  color: #409EFF;
}

.account-info-item {
  margin-bottom: 8px;
  display: flex;
  align-items: center;
}

.label {
  font-weight: bold;
  color: #666;
  width: 50px;
}

.value {
  margin-left: 5px;
  color: #333;
  font-family: 'Courier New', monospace;
  background-color: #f0f0f0;
  padding: 2px 5px;
  border-radius: 3px;
  flex: 1;
}

.password-view-btn {
  margin-left: 5px;
}

.password-preview {
  padding: 20px;
  text-align: center;
}

.password-preview-content {
  margin-bottom: 20px;
  font-size: 28px;
  font-family: 'Courier New', monospace;
  letter-spacing: 2px;
  background-color: #f8f8f8;
  border: 1px solid #e0e0e0;
  border-radius: 5px;
  padding: 15px;
  color: #333;
  word-break: break-all;
  font-weight: bold;
}

.password-preview-actions {
  margin-top: 20px;
  text-align: center;
}

.upload-tip {
  margin-top: 10px;
  font-size: 12px;
  color: #909399;
}
</style> 