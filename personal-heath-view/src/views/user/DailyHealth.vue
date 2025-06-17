<template>
  <div class="daily-health">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>每日健康计划</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="handleAdd">添加计划</el-button>
      </div>

      <el-table :data="healthPlans" style="width: 100%">
        <el-table-column prop="planDate" label="日期" width="180">
          <template slot-scope="scope">
            {{ formatDate(scope.row.planDate) }}
          </template>
        </el-table-column>
        <el-table-column prop="targetCalories" label="目标热量(kcal)" width="180"/>
        <el-table-column prop="exerciseMinutes" label="运动时间(分钟)"/>
        <el-table-column prop="sleepHours" label="睡眠时间(小时)"/>
        <el-table-column prop="waterCups" label="饮水量(杯)"/>
        <el-table-column label="操作" width="250">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-dialog 
  :show-close="false" 
  :visible.sync="dialogVisible" 
  width="40%"
  class="custom-dialog">
  <div style="padding:16px 20px;">
    <p>{{ dialogTitle }}</p>
    
    <div style="margin-block: 10px;">
      <span class="dialog-hover">日期</span>
      <el-date-picker 
        v-model="form.planDate" 
        type="date" 
        placeholder="选择日期"
        style="width: 200px;">
      </el-date-picker>
    </div>
    
    <div style="margin-block: 10px;">
      <span class="dialog-hover">目标热量</span>
      <el-input-number 
        v-model="form.targetCalories" 
        :min="1000" 
        :max="5000"
        style="width: 200px;">
      </el-input-number>
    </div>
    
    <div style="margin-block: 10px;">
      <span class="dialog-hover">运动时间</span>
      <el-input-number 
        v-model="form.exerciseMinutes" 
        :min="0" 
        :max="300"
        style="width: 200px;">
      </el-input-number>
    </div>
    
    <div style="margin-block: 10px;">
      <span class="dialog-hover">睡眠时间</span>
      <el-input-number 
        v-model="form.sleepHours" 
        :min="4" 
        :max="12" 
        :step="0.5"
        style="width: 200px;">
      </el-input-number>
    </div>
    
    <div style="margin-block: 10px;">
      <span class="dialog-hover">饮水量</span>
      <el-input-number 
        v-model="form.waterCups" 
        :min="0" 
        :max="20"
        style="width: 200px;">
      </el-input-number>
    </div>
  </div>
  
  <span slot="footer" class="dialog-footer" style="margin-top: 10px;">
    <span class="channel-button" @click="dialogVisible = false">
      取消操作
    </span>
    <span class="edit-button" @click="submitForm">
      {{ form.id ? '确定修改' : '确定新增' }}
    </span>
  </span>
</el-dialog>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      healthPlans: [],
      latestHealthPlan: null,
      dialogVisible: false,
      dialogTitle: '添加计划',
      form: {
        planDate: '',
        targetCalories: 2000,
        exerciseMinutes: 30,
        sleepHours: 8,
        waterCups: 8
      },
      rules: {
        planDate: [{ required: true, message: '请选择日期', trigger: 'change' }],
        targetCalories: [{ required: true, message: '请输入目标热量', trigger: 'blur' }]
      }
    };
  },
  created() {
    this.fetchPlans();
    this.fetchLatestPlan();
  },
  methods: {
    formatDate(dateString) {
      if (!dateString) return '';
      const date = new Date(dateString);
      return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`;
    },
    async fetchPlans() {
      try {
        const response = await this.$axios.post('/health-plans/queryUser', {});
        this.healthPlans = response.data.data;
      } catch (error) {
        console.error('获取计划列表失败:', error);
        this.$message.error('获取计划列表失败');
      }
    },
    async fetchLatestPlan() {
      try {
        const response = await this.$axios.get('/health-plans/latest');
        this.latestHealthPlan = response.data.data;
        if (this.latestHealthPlan) {
          this.latestHealthPlan.formattedDate = this.formatDate(this.latestHealthPlan.planDate);
        }
      } catch (error) {
        console.error('获取最近一次计划失败:', error);
        this.$message.error('获取最近一次计划失败');
      }
    },
    handleAdd() {
      this.dialogTitle = '添加计划';
      this.form = {
        planDate: new Date(),
        targetCalories: 2000,
        exerciseMinutes: 30,
        sleepHours: 8,
        waterCups: 8
      };
      this.dialogVisible = true;
    },
    handleEdit(row) {
      this.dialogTitle = '编辑计划';
      this.form = { ...row };
      this.dialogVisible = true;
    },
    async handleDelete(row) {
      try {
        await this.$confirm('确认删除该计划?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        });
        await this.$axios.post('/health-plans/batchDelete', [row.id]);
        this.$message.success('删除成功');
        this.fetchPlans();
        this.fetchLatestPlan();
      } catch (error) {
        if (error !== 'cancel') {
          console.error('删除计划失败:', error);
          this.$message.error('删除失败');
        }
      }
    },
    async submitForm() {
      try {
        let response;
        if (this.form.id) {
          response = await this.$axios.put(`/health-plans/update`, this.form);
        } else {
          response = await this.$axios.post('/health-plans/save', this.form);
        }
        this.$message.success(this.form.id ? '更新成功' : '添加成功');
        this.dialogVisible = false;
        this.fetchPlans();
      } catch (error) {
        console.error('保存失败:', error);
        this.$message.error('保存失败');
      }
    }
  }
};
</script>

<style scoped lang="scss">
.box-card {
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 20px;
}

.form-container {
  padding: 20px;
}

.dialog-footer {
  padding: 10px;
}

.custom-dialog {
  width: 60%;
  margin: 0 auto;
  margin-top: 10vh;

  ::v-deep.el-dialog__header {
    padding-top: 40px;
    padding-bottom: 10px;
  }

  ::v-deep.el-dialog__body {
    padding-top: 10px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center; /* 添加水平居中 */
  }

  ::v-deep.el-form {
    width: 100%; /* 确保表单宽度占满对话框 */
    max-width: 400px; /* 设置最大宽度，防止表单过宽 */
    margin: 0 auto; /* 水平居中 */
  }
}
</style>