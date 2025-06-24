<template>
  <div class="family-management">
    <div class="family-management-container">
      <div class="page-header">
        <h2 class="page-title">家庭成员管理</h2>
        <p class="page-subtitle">管理您的家庭成员账户，为家人的健康保驾护航</p>
        <div class="add-member-btn">
          <el-button type="primary" @click="showAddMemberDialog" class="add-button">
            <i class="el-icon-plus"></i> 添加家庭成员
          </el-button>
        </div>
      </div>

      <!-- 家庭成员列表 -->
      <div class="family-members">
        <el-row :gutter="20">
          <el-col :span="8" v-for="(member, index) in familyMembers" :key="index" class="member-col">
            <div class="member-card" 
              @click="selectMember(member)" 
              :class="{ 'active': currentMember && currentMember.id === member.id }">
              <div class="member-avatar-container">
                <div class="member-avatar">
                  <img :src="getImageUrl(member.avatar)" alt="头像" @error="handleAvatarError($event, member)">
                  <div class="gender-indicator" :class="member.gender === 1 ? 'male' : 'female'">
                    <i :class="member.gender === 1 ? 'el-icon-male' : 'el-icon-female'"></i>
                  </div>
                </div>
              </div>
              <div class="member-info">
                <h3 class="member-name">{{ member.name }}</h3>
                <div class="relation-tag">{{ member.relation }}</div>
                <div class="member-detail">
                  <p><i class="el-icon-user"></i> 账号：{{ member.username }}</p>
                  <p><i class="el-icon-lock"></i> 密码：
                    <span class="password-mask" @click.stop="showPasswordMagnified(member.password)">******</span>
                  </p>
                  <p><i class="el-icon-date"></i> 出生日期：{{ member.birthday }}</p>
                </div>
              </div>
              <div class="member-actions">
                <el-button type="primary" size="mini" @click.stop="editMember(member)" class="action-btn edit-btn">
                  <i class="el-icon-edit"></i> 编辑
                </el-button>
                <el-button type="warning" size="mini" @click.stop="resetPassword(member)" class="action-btn reset-btn">
                  <i class="el-icon-refresh"></i> 重置密码
                </el-button>
                <el-button type="danger" size="mini" @click.stop="confirmDelete(member)" class="action-btn delete-btn">
                  <i class="el-icon-delete"></i> 删除
                </el-button>
              </div>
            </div>
          </el-col>
        </el-row>
      </div>

      <!-- 当前选中家庭成员的健康数据 -->
      <div class="member-data-container" v-if="currentMember">
        <div class="data-header">
          <div class="data-title">
            <i class="el-icon-data-analysis"></i>
            <h3>{{ currentMember.name }}的健康数据</h3>
          </div>
          <div class="data-actions">
            <el-button type="success" size="small" class="refresh-btn" @click="fetchMemberHealthData(currentMember.id)">
              <i class="el-icon-refresh"></i> 刷新数据
            </el-button>
          </div>
        </div>
        
        <el-tabs v-model="activeTab" class="custom-tabs">
          <el-tab-pane label="健康指标" name="healthMetrics">
            <div class="metrics-grid" v-if="healthData.metrics && healthData.metrics.length">
              <el-card v-for="(metric, idx) in healthData.metrics" :key="idx" class="metric-card" :body-style="{ padding: '0px' }">
                <div class="metric-header" :class="getStatusClass(metric.status)">
                  <i class="el-icon-s-data"></i>
                </div>
                <div class="metric-body">
                  <div class="metric-value">{{ metric.value }}<span class="metric-unit">{{ metric.unit }}</span></div>
                  <div class="metric-name">{{ metric.name }}</div>
                  <div class="metric-status" :class="getStatusClass(metric.status)">
                    {{ metric.status === 'normal' ? '正常' : '异常' }}
                  </div>
                </div>
              </el-card>
            </div>
            <el-empty v-else description="暂无健康指标数据"></el-empty>
          </el-tab-pane>
          
          <el-tab-pane label="运动记录" name="exerciseRecords">
            <div class="table-container" v-if="healthData.exercises && healthData.exercises.length">
              <el-table :data="healthData.exercises" style="width: 100%" class="custom-table" stripe>
                <el-table-column prop="date" label="日期" width="120">
                  <template slot-scope="scope">
                    <div class="table-cell">
                      <i class="el-icon-date cell-icon"></i>
                      <span>{{ scope.row.date }}</span>
                    </div>
                  </template>
                </el-table-column>
                <el-table-column prop="type" label="运动类型" width="120">
                  <template slot-scope="scope">
                    <div class="table-cell">
                      <i class="el-icon-bicycle cell-icon"></i>
                      <span>{{ scope.row.type }}</span>
                    </div>
                  </template>
                </el-table-column>
                <el-table-column prop="duration" label="时长(分钟)" width="120">
                  <template slot-scope="scope">
                    <div class="table-cell">
                      <i class="el-icon-timer cell-icon"></i>
                      <span>{{ scope.row.duration }}</span>
                    </div>
                  </template>
                </el-table-column>
                <el-table-column prop="calories" label="消耗(卡路里)">
                  <template slot-scope="scope">
                    <div class="table-cell">
                      <i class="el-icon-hot-water cell-icon"></i>
                      <span>{{ scope.row.calories }}</span>
                    </div>
                  </template>
                </el-table-column>
              </el-table>
            </div>
            <el-empty v-else description="暂无运动记录数据"></el-empty>
          </el-tab-pane>
          
          <el-tab-pane label="饮食记录" name="dietRecords">
            <div class="table-container" v-if="healthData.diets && healthData.diets.length">
              <el-table :data="healthData.diets" style="width: 100%" class="custom-table" stripe>
                <el-table-column prop="date" label="日期" width="120">
                  <template slot-scope="scope">
                    <div class="table-cell">
                      <i class="el-icon-date cell-icon"></i>
                      <span>{{ scope.row.date }}</span>
                    </div>
                  </template>
                </el-table-column>
                <el-table-column prop="mealTime" label="餐次" width="100">
                  <template slot-scope="scope">
                    <div class="table-cell">
                      <i class="el-icon-dish cell-icon"></i>
                      <span>{{ scope.row.mealTime }}</span>
                    </div>
                  </template>
                </el-table-column>
                <el-table-column prop="food" label="食物">
                  <template slot-scope="scope">
                    <div class="table-cell">
                      <i class="el-icon-food cell-icon"></i>
                      <span>{{ scope.row.food }}</span>
                    </div>
                  </template>
                </el-table-column>
                <el-table-column prop="calories" label="热量(卡路里)" width="120">
                  <template slot-scope="scope">
                    <div class="table-cell">
                      <i class="el-icon-hot-water cell-icon"></i>
                      <span>{{ scope.row.calories }}</span>
                    </div>
                  </template>
                </el-table-column>
              </el-table>
            </div>
            <el-empty v-else description="暂无饮食记录数据"></el-empty>
          </el-tab-pane>
        </el-tabs>
      </div>

      <el-card class="empty-state-card" v-else>
        <div class="empty-state">
          <i class="el-icon-user"></i>
          <p>请选择一个家庭成员查看健康数据</p>
        </div>
      </el-card>

      <!-- 添加/编辑家庭成员对话框 -->
      <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="30%" custom-class="custom-dialog" :show-close="false">
        <div class="dialog-header">
          <h3 class="dialog-title">{{ dialogTitle }}</h3>
          <i class="el-icon-close close-icon" @click="dialogVisible = false"></i>
        </div>
        <div class="dialog-body">
          <el-form :model="memberForm" :rules="memberRules" ref="memberForm" label-width="90px">
            <el-form-item label="姓名" prop="name">
              <div class="input-with-icon">
                <i class="el-icon-user input-prefix-icon"></i>
                <el-input v-model="memberForm.name" placeholder="请输入家庭成员姓名"></el-input>
              </div>
            </el-form-item>
            <el-form-item label="关系" prop="relation">
              <div class="input-with-icon">
                <i class="el-icon-connection input-prefix-icon"></i>
                <el-select v-model="memberForm.relation" placeholder="请选择与您的关系" style="width: 100%">
                  <el-option label="配偶" value="配偶"></el-option>
                  <el-option label="父亲" value="父亲"></el-option>
                  <el-option label="母亲" value="母亲"></el-option>
                  <el-option label="儿子" value="儿子"></el-option>
                  <el-option label="女儿" value="女儿"></el-option>
                  <el-option label="其他" value="其他"></el-option>
                </el-select>
              </div>
            </el-form-item>
            <el-form-item label="账号" prop="username">
              <div class="input-with-icon">
                <i class="el-icon-user-solid input-prefix-icon"></i>
                <el-input v-model="memberForm.username" placeholder="请输入登录账号"></el-input>
              </div>
            </el-form-item>
            <el-form-item label="密码" prop="password" v-if="!isEditing">
              <div class="input-with-icon">
                <i class="el-icon-lock input-prefix-icon"></i>
                <el-input v-model="memberForm.password" placeholder="请输入登录密码" type="password" show-password>
                  <el-button slot="append" @click="memberForm.password = generateRandomString(10)" class="random-btn">随机</el-button>
                </el-input>
              </div>
            </el-form-item>
            <el-form-item label="出生日期" prop="birthday">
              <div class="input-with-icon">
                <i class="el-icon-date input-prefix-icon"></i>
                <el-date-picker v-model="memberForm.birthday" type="date" placeholder="选择出生日期" style="width: 100%"></el-date-picker>
              </div>
            </el-form-item>
            <el-form-item label="性别" prop="gender">
              <div class="gender-selector">
                <label class="gender-option" :class="{ 'active': memberForm.gender === 1 }">
                  <el-radio v-model="memberForm.gender" :label="1">
                    <i class="el-icon-male"></i> 男
                  </el-radio>
                </label>
                <label class="gender-option" :class="{ 'active': memberForm.gender === 0 }">
                  <el-radio v-model="memberForm.gender" :label="0">
                    <i class="el-icon-female"></i> 女
                  </el-radio>
                </label>
              </div>
            </el-form-item>
            <el-form-item label="头像">
              <div class="avatar-upload-container">
                <el-upload
                  class="avatar-uploader"
                  action="#"
                  :http-request="handleCustomUpload"
                  :show-file-list="false"
                  :on-success="handleAvatarSuccess"
                  :before-upload="beforeAvatarUpload"
                  drag>
                  <img v-if="memberForm.avatar" :src="getImageUrl(memberForm.avatar)" class="avatar">
                  <div v-else class="avatar-placeholder">
                    <i class="el-icon-plus avatar-uploader-icon"></i>
                    <div class="upload-text">点击或拖拽上传</div>
                  </div>
                </el-upload>
                <div class="upload-tip">点击上传头像 (支持JPG、PNG格式，小于2MB)</div>
              </div>
            </el-form-item>
          </el-form>
        </div>
        <div class="dialog-footer">
          <el-button @click="dialogVisible = false" class="cancel-btn">取 消</el-button>
          <el-button type="primary" @click="saveMember" class="confirm-btn">确 定</el-button>
        </div>
      </el-dialog>

      <!-- 删除确认对话框 -->
      <el-dialog
        :visible.sync="deleteDialogVisible"
        width="30%"
        custom-class="custom-dialog"
        :show-close="false">
        <div class="dialog-header">
          <h3 class="dialog-title">删除确认</h3>
          <i class="el-icon-close close-icon" @click="deleteDialogVisible = false"></i>
        </div>
        <div class="dialog-body">
          <div class="delete-confirm">
            <div class="warning-icon-container">
              <i class="el-icon-warning-outline warning-icon"></i>
            </div>
            <p class="delete-message">确定要删除家庭成员 <span class="highlight-text">{{ memberToDelete ? memberToDelete.name : '' }}</span> 吗？</p>
            <p class="warning-text">删除后将无法恢复该成员的所有数据！</p>
          </div>
        </div>
        <div class="dialog-footer">
          <el-button @click="deleteDialogVisible = false" class="cancel-btn">取 消</el-button>
          <el-button type="danger" @click="deleteMember" class="confirm-btn">确 定</el-button>
        </div>
      </el-dialog>

      <!-- 重置密码对话框 -->
      <el-dialog
        :visible.sync="resetPwdDialog"
        width="30%"
        custom-class="custom-dialog"
        :show-close="false">
        <div class="dialog-header">
          <h3 class="dialog-title">重置密码</h3>
          <i class="el-icon-close close-icon" @click="resetPwdDialog = false"></i>
        </div>
        <div class="dialog-body">
          <el-form :model="resetPwdMember" :rules="resetPwdRules" ref="resetPwdForm" label-width="90px">
            <el-form-item label="新密码" prop="password">
              <div class="input-with-icon">
                <i class="el-icon-lock input-prefix-icon"></i>
                <el-input v-model="newPassword" placeholder="请输入新密码" type="password" show-password>
                  <el-button slot="append" @click="generateRandomPassword" class="random-btn">随机</el-button>
                </el-input>
              </div>
            </el-form-item>
          </el-form>
        </div>
        <div class="dialog-footer">
          <el-button @click="resetPwdDialog = false" class="cancel-btn">取 消</el-button>
          <el-button type="primary" @click="confirmResetPassword" class="confirm-btn">确 定</el-button>
        </div>
      </el-dialog>

      <!-- 密码放大查看对话框 -->
      <el-dialog
        :visible.sync="passwordPreviewDialog"
        width="30%"
        custom-class="custom-dialog"
        :show-close="false">
        <div class="dialog-header">
          <h3 class="dialog-title">密码放大查看</h3>
          <i class="el-icon-close close-icon" @click="passwordPreviewDialog = false"></i>
        </div>
        <div class="dialog-body">
          <div class="password-preview">
            <div class="password-preview-content">{{ passwordToPreview }}</div>
            <div class="password-preview-actions">
              <el-button type="primary" size="small" @click="copyToClipboard(passwordToPreview, '密码')" class="copy-btn">
                <i class="el-icon-document-copy"></i> 复制密码
              </el-button>
            </div>
          </div>
        </div>
        <div class="dialog-footer">
          <el-button @click="passwordPreviewDialog = false" class="confirm-btn">关闭</el-button>
        </div>
      </el-dialog>
    </div>
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
          { max: 20, message: '长度不能超过20个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入登录密码', trigger: 'blur' },
          { max: 20, message: '长度不能超过20个字符', trigger: 'blur' }
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
          { max: 20, message: '长度不能超过20个字符', trigger: 'blur' }
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
          name: '吴林坤', 
          relation: '儿子', 
          username: 'wlk',
          password: 'wlk123',
          birthday: '2023-01-01', 
          gender: 1,  // 男
          avatar: '/uploads/1.jpg',
          parentUserId: currentUserId,
          showPassword: false // 控制密码是否显示
        },
        { 
          id: '2', 
          name: '苏沐橙', 
          relation: '妻子', 
          username: 'smc',
          password: 'smc123',
          birthday: '2005-01-01', 
          gender: 0,  // 女
          avatar: '/uploads/2.jpg',
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
        parentUserId: '', // 关联的主用户ID
        avatarPath: '' // 不带@前缀，相对于src目录
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
          // 查找原始成员获取原始密码
          const originalMember = this.familyMembers.find(m => m.id === this.memberForm.id);
          if (originalMember) {
            // 创建一个新对象来保存更新后的成员信息
            const updatedMember = {
              ...this.memberForm,
              // 使用原始密码
              password: originalMember.password
            };
            
            const index = this.familyMembers.findIndex(m => m.id === this.memberForm.id);
            if (index !== -1) {
              this.familyMembers.splice(index, 1, updatedMember);
              
              // 如果当前正在查看的成员就是被编辑的成员，更新currentMember
              if (this.currentMember && this.currentMember.id === updatedMember.id) {
                this.currentMember = updatedMember;
              }
            }
            this.$message.success('更新成功');
          } else {
            this.$message.error('未找到要编辑的成员');
          }
        } else {
          const newMember = { 
            ...this.memberForm,
            id: Date.now().toString(), // 模拟ID生成
            showPassword: false // 添加控制密码是否显示的属性
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
      // 验证由handleCustomUpload处理，这里直接返回true
      return true;
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
      const file = event.file;
      
      try {
        // 校验文件类型和大小
        const isImage = file.type.indexOf('image/') === 0;
        const isLt2M = file.size / 1024 / 1024 < 2;
        
        if (!isImage) {
          this.$message.error('上传头像图片只能是图片格式!');
          event.onError(new Error('非图片格式'));
          return;
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 2MB!');
          event.onError(new Error('图片过大'));
          return;
        }
        
        // 创建一个临时的URL以预览图片
        const fileUrl = URL.createObjectURL(file);
        
        // 设置成员头像为临时URL
        this.memberForm.avatar = fileUrl;
        
        console.log('临时头像URL:', fileUrl);
        this.$message.success('头像上传成功');
        
        // 通知上传组件上传成功
        event.onSuccess();
      } catch (error) {
        console.error('上传过程中发生错误:', error);
        this.$message.error('上传失败: ' + error.message);
        event.onError(error);
      }
    },

    // 处理头像加载错误
    handleAvatarError(event, member) {
      // 这里可以添加处理头像加载错误的逻辑
      // 例如，设置一个默认头像
      member.avatar = require('@/assets/img/default-avatar.png');
    },

    // 获取头像URL
    getImageUrl(avatar) {
      if (!avatar) {
        return require('@/assets/img/default-avatar.png');
      }
      
      // 如果是/uploads开头的路径（相对于public目录）
      if (avatar.startsWith('/uploads/')) {
        return avatar; // 直接返回，Vue会从public目录查找
      }
      
      // 如果已经是blob URL或者http URL，直接返回
      if (avatar.startsWith('blob:') || avatar.startsWith('http') || avatar.startsWith('data:')) {
        return avatar;
      }
      
      // 对于其他路径返回默认头像
      return require('@/assets/img/default-avatar.png');
    }
  }
}
</script>

<style scoped>
.family-management {
  padding: 20px;
}

/* 头部区域样式 */
.family-management-container {
  padding: 20px;
}

.page-header {
  background: linear-gradient(135deg, #42b983, #2c9e6a);
  color: white;
  border-radius: 12px;
  padding: 25px 30px;
  margin-bottom: 30px;
  display: flex;
  justify-content: space-between;
  align-items: center;
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

.add-member-btn {
  padding: 10px 20px;
  border: none;
  background-color: rgba(255, 255, 255, 0.2);
  transition: all 0.3s ease;
}

.add-member-btn:hover {
  background-color: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

/* 成员列表区域 */
.family-members {
  margin-bottom: 30px;
}

.member-col {
  cursor: pointer;
  transition: all 0.3s;
  position: relative;
  z-index: 1;
  margin-bottom: 15px;
}

.member-col:hover {
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
  transform: translateY(-3px);
}

.member-card {
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  overflow: hidden;
  transition: all 0.3s;
  height: 100%;
  display: flex;
  flex-direction: column;
  position: relative;
  border: 2px solid transparent;
}

.member-card:hover {
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
  transform: translateY(-5px);
}

/* 选中样式 */
.member-card.active {
  border-color: #42b983;
  background-color: #f0f9eb;
}

.member-avatar-container {
  padding: 20px;
  display: flex;
  justify-content: center;
  background: linear-gradient(135deg, #f8f9fa, #e9ecef);
}

.member-avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  overflow: hidden;
  border: 4px solid #fff;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  position: relative;
}

.gender-indicator {
  position: absolute;
  bottom: 0;
  right: 0;
  width: 30px;
  height: 30px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 16px;
  border: 2px solid white;
  z-index: 2; /* 确保性别指示器在头像上方 */
}

.gender-indicator.male {
  background: linear-gradient(135deg, #4a90e2, #357ae8);
}

.gender-indicator.female {
  background: linear-gradient(135deg, #e25c5c, #d83b3b);
}

/* 调整头像样式，确保图片能够完整显示 */
.member-avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block; /* 防止图片底部出现间隙 */
}

.member-name {
  font-size: 18px;
  font-weight: 600;
  margin: 0 0 10px;
  color: #333;
  text-align: center;
}

.relation-tag {
  display: inline-block;
  padding: 4px 12px;
  background-color: #e1f3d8;
  color: #42b983;
  border-radius: 20px;
  font-size: 12px;
  margin: 0 auto 15px;
  text-align: center;
}

.member-detail {
  margin-top: 15px;
}

.member-detail p {
  margin: 8px 0;
  color: #606266;
  font-size: 14px;
  display: flex;
  align-items: center;
}

.member-detail i {
  margin-right: 8px;
  color: #909399;
  width: 16px;
  text-align: center;
}

.password-mask {
  background-color: #f5f7fa;
  padding: 2px 8px;
  border-radius: 4px;
  cursor: pointer;
  font-family: monospace;
  transition: all 0.3s;
}

.password-mask:hover {
  background-color: #e1f3d8;
  color: #42b983;
}

.member-actions {
  margin-top: auto;
  padding: 15px;
  display: flex;
  justify-content: space-around;
  background-color: #f8f9fa;
  border-top: 1px solid #e9ecef;
}

.action-btn {
  font-size: 12px;
  padding: 7px 12px;
  border-radius: 15px;
}

.edit-btn {
  background-color: #409EFF;
  border-color: #409EFF;
}

.reset-btn {
  background-color: #E6A23C;
  border-color: #E6A23C;
}

.delete-btn {
  background-color: #F56C6C;
  border-color: #F56C6C;
}

/* 健康数据区域 */
.member-data-container {
  background-color: #fff;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
  margin-bottom: 30px;
}

.data-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  border-bottom: 2px solid #f5f5f5;
  padding-bottom: 15px;
}

.data-title {
  display: flex;
  align-items: center;
}

.data-title i {
  font-size: 24px;
  margin-right: 10px;
  color: #42b983;
}

.data-title h3 {
  font-size: 20px;
  color: #333;
  margin: 0;
}

.refresh-btn {
  background-color: #42b983;
  border-color: #42b983;
  color: white;
}

.refresh-btn:hover {
  background-color: #2c9e6a;
  border-color: #2c9e6a;
}

.custom-tabs {
  margin-top: 20px;
}

/* 健康指标卡片 */
.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.metric-card {
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  transition: all 0.3s;
}

.metric-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
}

.metric-header {
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.metric-header i {
  font-size: 28px;
  color: white;
}

.metric-header.status-normal {
  background: linear-gradient(135deg, #42b983, #2c9e6a);
}

.metric-header.status-abnormal {
  background: linear-gradient(135deg, #f56c6c, #d63b3b);
}

.metric-body {
  padding: 15px;
  text-align: center;
}

.metric-value {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-bottom: 8px;
}

.metric-unit {
  font-size: 14px;
  color: #666;
  margin-left: 2px;
}

.metric-name {
  color: #666;
  margin-bottom: 10px;
  font-size: 14px;
}

.metric-status {
  display: inline-block;
  padding: 3px 10px;
  border-radius: 15px;
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

/* 表格样式 */
.table-container {
  margin: 20px 0;
}

.custom-table {
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.table-cell {
  display: flex;
  align-items: center;
}

.cell-icon {
  margin-right: 8px;
  color: #409EFF;
}

/* 空状态卡片 */
.empty-state-card {
  text-align: center;
  padding: 40px;
  border-radius: 10px;
  background-color: #fff;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
}

.empty-state {
  color: #909399;
}

.empty-state i {
  font-size: 60px;
  margin-bottom: 20px;
  color: #dcdfe6;
}

.empty-state p {
  font-size: 16px;
  margin: 0;
}

/* 头像上传区域 */
.avatar-upload-container {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.avatar-uploader {
  text-align: center;
  margin-bottom: 10px;
}

.avatar-uploader .el-upload {
  border: 2px dashed #d9d9d9;
  border-radius: 50%;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: all 0.3s;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
  box-shadow: 0 0 8px rgba(64, 158, 255, 0.3);
}

.avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  object-fit: cover;
}

.avatar-placeholder {
  width: 100px;
  height: 100px;
  background-color: #f5f7fa;
  border-radius: 50%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border: 1px dashed #d9d9d9;
  cursor: pointer;
  transition: all 0.3s;
}

.avatar-placeholder:hover {
  border-color: #42b983;
  background-color: #f0f9eb;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  margin-bottom: 5px;
}

.upload-text {
  font-size: 12px;
  color: #909399;
  text-align: center;
}

.upload-tip {
  font-size: 12px;
  color: #909399;
  margin-top: 10px;
}

/* 对话框样式 */
.custom-dialog {
  border-radius: 10px;
  overflow: hidden;
}

.dialog-header {
  padding: 15px 20px;
  background: linear-gradient(135deg, #42b983, #2c9e6a);
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: none;
}

.dialog-title {
  font-size: 18px;
  font-weight: 500;
  margin: 0;
  color: white;
}

.close-icon {
  cursor: pointer;
  color: white;
  font-size: 18px;
}

.dialog-body {
  padding: 20px;
}

.dialog-footer {
  padding: 10px 20px 20px;
  text-align: center;
  display: flex;
  justify-content: center;
  gap: 15px;
}

.cancel-btn {
  border-radius: 20px;
  padding: 10px 25px;
  background-color: #f5f7fa;
  border-color: #dcdfe6;
  color: #606266;
}

.cancel-btn:hover {
  background-color: #e9ebee;
  border-color: #c6c8cc;
}

.confirm-btn {
  border-radius: 20px;
  padding: 10px 25px;
  background-color: #42b983;
  border-color: #42b983;
}

.confirm-btn:hover {
  background-color: #2c9e6a;
  border-color: #2c9e6a;
}

/* 新增样式 */
.input-with-icon {
  position: relative;
  display: flex;
  align-items: center;
}

.input-prefix-icon {
  position: absolute;
  left: 10px;
  top: 50%;
  transform: translateY(-50%);
  z-index: 1;
  color: #909399;
  font-size: 16px;
}

.input-with-icon .el-input__inner {
  padding-left: 35px;
}

.gender-selector {
  display: flex;
  gap: 20px;
}

.gender-option {
  flex: 1;
  padding: 10px 15px;
  border-radius: 6px;
  border: 1px solid #dcdfe6;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s;
}

.gender-option.active {
  border-color: #42b983;
  background-color: #f0f9eb;
}

.gender-option .el-radio {
  margin-right: 0;
}

.gender-option .el-radio__label {
  display: flex;
  align-items: center;
  font-size: 14px;
}

.gender-option i {
  margin-right: 5px;
}

.gender-option .el-icon-male {
  color: #409EFF;
}

.gender-option .el-icon-female {
  color: #ff6b9a;
}

.random-btn {
  background-color: #67c23a;
  color: white;
  border-color: #67c23a;
}

.random-btn:hover {
  background-color: #85ce61;
  border-color: #85ce61;
}

/* 删除确认对话框样式 */
.delete-confirm {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px 10px;
  text-align: center;
}

.warning-icon-container {
  width: 70px;
  height: 70px;
  border-radius: 50%;
  background-color: rgba(255, 153, 0, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 20px;
}

.warning-icon {
  font-size: 40px;
  color: #ff9900;
}

.delete-message {
  color: #333;
  font-size: 16px;
  margin-bottom: 15px;
}

.highlight-text {
  color: #f56c6c;
  font-weight: bold;
}

.warning-text {
  color: #ff9900;
  font-size: 14px;
  font-weight: 500;
}

/* 密码预览对话框样式 */
.password-preview {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px 10px;
}

.password-preview-content {
  background-color: #f8f8f8;
  padding: 15px 20px;
  border-radius: 8px;
  border: 1px solid #e0e0e0;
  font-family: 'Courier New', monospace;
  font-size: 20px;
  margin-bottom: 20px;
  width: 100%;
  text-align: center;
  word-break: break-all;
  letter-spacing: 1px;
  color: #333;
}

.password-preview-actions {
  margin-top: 10px;
}

.copy-btn {
  background-color: #409EFF;
  color: white;
  border-color: #409EFF;
  padding: 10px 20px;
  border-radius: 20px;
}

.copy-btn:hover {
  background-color: #66b1ff;
  border-color: #66b1ff;
}

/* 响应式调整 */
@media screen and (max-width: 768px) {
  .family-management-container {
    padding: 10px;
  }
  
  .page-header {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .add-member-btn {
    margin-top: 15px;
  }
  
  .metrics-grid {
    grid-template-columns: 1fr;
  }
}

.add-button {
  padding: 10px 20px;
  border-radius: 20px;
  background-color: #ffffff;
  border-color: #ffffff;
  color: #42b983;
  font-weight: 500;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  transition: all 0.3s;
}

.add-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  background-color: #f5f5f5;
}

.add-button i {
  margin-right: 5px;
}
</style> 