<template>
  <el-row style="background-color: #FFFFFF;padding: 5px 0;border-radius: 5px;">
    <!-- 搜索区域 -->
    <el-row style="padding: 10px;margin-left: 5px;">
      <el-row style="display: flex;justify-content: left;gap: 6px;">
        <span class="edit-button" @click="handleAdd">
          新增食谱
        </span>
        <el-select 
          style="width: 100px;" 
          size="small"
          v-model="queryParams.regionId" 
          placeholder="地区"
          clearable
          @change="getList"
        >
          <el-option
            v-for="item in regions"
            :key="item.id"
            :label="item.name"
            :value="item.id"
          />
        </el-select>
        <el-select 
          style="width: 100px;" 
          size="small"
          v-model="queryParams.seasonId" 
          placeholder="季节"
          clearable
          @change="getList"
        >
          <el-option
            v-for="item in seasons"
            :key="item.id"
            :label="item.name"
            :value="item.id"
          />
        </el-select>
        <el-select 
          style="width: 100px;" 
          size="small"
          v-model="queryParams.mealType" 
          placeholder="餐类型"
          clearable
          @change="getList"
        >
          <el-option label="早餐" :value="1" />
          <el-option label="午餐" :value="2" />
          <el-option label="晚餐" :value="3" />
        </el-select>
        <el-input 
          size="small" 
          style="width: 166px;" 
          v-model="queryParams.name" 
          placeholder="食谱名称"
          clearable 
          @clear="resetSearch"
        >
          <el-button slot="append" @click="getList" icon="el-icon-search"></el-button>
        </el-input>
      </el-row>
    </el-row>

    <!-- 表格区域 -->
    <el-row style="margin: 0 22px;border-top: 1px solid rgb(245,245,245);">
      <el-table 
        :stripe="true" 
        :data="tableData" 
        style="width: 100%"
        v-loading="loading"
      >
        <el-table-column prop="id" label="ID" width="80"></el-table-column>
        <el-table-column prop="name" label="食谱名称"></el-table-column>
        <el-table-column prop="description" label="食谱描述"></el-table-column>
        <el-table-column prop="regionName" label="地区" width="120"></el-table-column>
        <el-table-column prop="seasonName" label="季节" width="120"></el-table-column>
        <el-table-column label="餐类型" width="100">
          <template slot-scope="scope">
            <span>{{ formatMealType(scope.row.mealType) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="封面图" width="120">
          <template slot-scope="scope">
            <el-image
              style="width: 100px; height: 60px"
              :src="scope.row.image"
              fit="cover"
              :preview-src-list="[scope.row.image]"
            />
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150">
          <template slot-scope="scope">
            <span class="text-button" @click="handleEdit(scope.row)">修改</span>
            <span class="text-button" @click="handleDelete(scope.row)">删除</span>
          </template>
        </el-table-column>
      </el-table>
      
      <!-- 分页 -->
      <el-pagination 
        style="margin:10px 0;float: right;" 
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange" 
        :current-page="queryParams.current" 
        :page-sizes="[20, 50]"
        :page-size="queryParams.size" 
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
      ></el-pagination>
    </el-row>

    <!-- 新增/编辑弹窗 -->
    <el-dialog 
      :show-close="false" 
      :visible.sync="dialogVisible" 
      width="40%"
    >
      <div style="padding:16px 20px;">
        <p>{{ dialogTitle }}</p>
        <el-row>
          <p>封面图片</p>
          <el-upload
            class="avatar-uploader"
            action="http://localhost:8080/api/personal-heath/v1.0/file/upload"
            :show-file-list="false"
            :on-success="handleImageSuccess"
          >
            <img v-if="form.image" :src="form.image" class="dialog-avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-row>
        <div>
          <input class="dialog-input" v-model="form.name" placeholder="食谱名称" />
        </div>
        <div style="margin-block: 10px;">
          <span class="dialog-hover">所属地区</span>
          <el-select 
            style="width: 100px;" 
            size="small" 
            v-model="form.regionId"
            placeholder="地区"
          >
            <el-option
              v-for="item in regions"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            />
          </el-select>
        </div>
        <div style="margin-block: 10px;">
          <span class="dialog-hover">所属季节</span>
          <el-select 
            style="width: 100px;" 
            size="small" 
            v-model="form.seasonId"
            placeholder="季节"
          >
            <el-option
              v-for="item in seasons"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            />
          </el-select>
        </div>
        <div style="margin-block: 10px;">
          <span class="dialog-hover">餐类型</span>
          <el-select 
            style="width: 100px;" 
            size="small" 
            v-model="form.mealType"
            placeholder="餐类型"
          >
            <el-option label="早餐" :value="1" />
            <el-option label="午餐" :value="2" />
            <el-option label="晚餐" :value="3" />
          </el-select>
        </div>
        <div>
          <textarea 
            class="dialog-textarea" 
            v-model="form.description" 
            placeholder="食谱描述"
          ></textarea>
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
  </el-row>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
      tableData: [],
      total: 0,
      regions: [],
      seasons: [],
      queryParams: {
        current: 1,
        size: 20,
        name: '',
        regionId: null,
        seasonId: null,
        mealType: null
      },
      dialogVisible: false,
      dialogTitle: '',
      form: {
        id: null,
        name: '',
        regionId: null,
        seasonId: null,
        mealType: null,
        image: '',
        description: ''
      }
    }
  },
  created() {
    this.getList()
    this.getRegions()
    this.getSeasons()
  },
  methods: {
    // 获取地区列表
    async getRegions() {
      const res = await this.$axios.get('/recipes/regions')
      if (res.data.code === 200) {
        this.regions = res.data.data
      }
    },
    // 获取季节列表
    async getSeasons() {
      const res = await this.$axios.get('/recipes/seasons')
      if (res.data.code === 200) {
        this.seasons = res.data.data
      }
    },
    // 获取食谱列表
    async getList() {
      this.loading = true
      try {
        const res = await this.$axios.post('/recipes/query', this.queryParams)
        if (res.data.code === 200) {
          this.tableData = res.data.data
          this.total = res.data.total || 0
        }
      } finally {
        this.loading = false
      }
    },
    // 重置搜索
    resetSearch() {
      this.queryParams = {
        current: 1,
        size: 20,
        name: '',
        regionId: null,
        seasonId: null,
        mealType: null
      }
      this.getList()
    },
    // 格式化餐类型
    formatMealType(type) {
      const map = { 1: '早餐', 2: '午餐', 3: '晚餐' }
      return map[type] || ''
    },
    // 分页大小变化
    handleSizeChange(val) {
      this.queryParams.size = val
      this.getList()
    },
    // 当前页变化
    handleCurrentChange(val) {
      this.queryParams.current = val
      this.getList()
    },
    // 打开新增弹窗
    handleAdd() {
      this.dialogTitle = '新增地区食谱'
      this.form = {
        id: null,
        name: '',
        regionId: null,
        seasonId: null,
        mealType: null,
        image: '',
        description: ''
      }
      this.dialogVisible = true
    },
    // 打开编辑弹窗
    handleEdit(row) {
      this.dialogTitle = '修改地区食谱'
      this.form = { ...row }
      this.dialogVisible = true
    },
    // 提交表单
    submitForm() {
      const api = this.form.id ? '/recipes' : '/recipes'
      const method = this.form.id ? 'put' : 'post'
      this.$axios[method](api, this.form).then(res => {
        if (res.data.code === 200) {
          this.$notify({
            duration: 1000,
            title: '食谱操作',
            message: this.form.id ? '修改成功' : '新增成功',
            type: 'success'
          })
          this.dialogVisible = false
          this.getList()
        }
      })
    },
    // 删除
    handleDelete(row) {
      this.$confirm('确定删除该食谱吗？', '提示', {
        type: 'warning'
      }).then(() => {
        this.$axios.delete(`/recipes/${[row.id]}`).then(res => {
          if (res.data.code === 200) {
            this.$notify({
              duration: 1000,
              title: '信息删除',
              message: '删除成功',
              type: 'success'
            })
            this.getList()
          }
        })
      })
    },
    // 图片上传成功
    handleImageSuccess(res) {
      if (res.code === 200) {
        this.form.image = res.data
        this.$notify({
          duration: 1500,
          title: '封面上传',
          message: '上传成功',
          type: 'success'
        })
      }
    }
  }
}
</script>

<style scoped>
.edit-button {
  display: inline-block;
  padding: 5px 10px;
  background-color: #409EFF;
  color: white;
  border-radius: 3px;
  cursor: pointer;
  font-size: 12px;
}

.channel-button {
  display: inline-block;
  padding: 5px 10px;
  background-color: #909399;
  color: white;
  border-radius: 3px;
  cursor: pointer;
  font-size: 12px;
  margin-right: 10px;
}

.text-button {
  color: #409EFF;
  cursor: pointer;
  margin-right: 10px;
}

.dialog-input {
  width: 100%;
  padding: 8px;
  border: 1px solid #DCDFE6;
  border-radius: 4px;
  margin-top: 10px;
}

.dialog-textarea {
  width: 100%;
  padding: 8px;
  border: 1px solid #DCDFE6;
  border-radius: 4px;
  margin-top: 10px;
  min-height: 80px;
}

.dialog-hover {
  display: inline-block;
  width: 60px;
  color: #606266;
}

.avatar-uploader {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  width: 100px;
  height: 100px;
  margin-top: 10px;
}
.avatar-uploader:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  line-height: 100px;
  text-align: center;
}
.dialog-avatar {
  width: 100px;
  height: 100px;
  display: block;
}
</style>