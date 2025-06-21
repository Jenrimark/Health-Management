<template>
    <el-row style="background-color: #FFFFFF;padding: 5px 0;border-radius: 5px;">
        <el-row style="padding: 10px;margin-left: 5px;">
            <el-row style="display: flex;justify-content: left;gap: 6px;">
                <el-input size="small" style="width: 166px;" v-model="nutrimentQueryDto.name" placeholder="营养素名称"
                    clearable @clear="handleFilterClear">
                    <el-button slot="append" @click="handleFilter" icon="el-icon-search"></el-button>
                </el-input>
            </el-row>
        </el-row>
        <el-row style="margin: 0 22px;border-top: 1px solid rgb(245,245,245);">
            <el-table :stripe="true" :data="tableData" style="width: 100%">
                <el-table-column prop="userAvatar" width="68" label="头像">
                    <template slot-scope="scope">
                        <el-avatar :size="25" :src="scope.row.userAvatar" style="margin-top: 10px;"></el-avatar>
                    </template>
                </el-table-column>
                <el-table-column prop="userName" label="发布者" width="118"></el-table-column>
                <el-table-column prop="name" label="营养素名"></el-table-column>
                <el-table-column prop="detail" label="描述" width="368"></el-table-column>
                <el-table-column prop="unit" label="单位" width="108"></el-table-column>
                <el-table-column prop="createTime" label="创建时间" :sortable="true" width="168"></el-table-column>
            </el-table>
            <el-pagination style="margin:10px 0;float: right;" @size-change="handleSizeChange"
                @current-change="handleCurrentChange" :current-page="currentPage" :page-sizes="[20, 50]"
                :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                :total="totalItems"></el-pagination>
        </el-row>
    </el-row>
</template>

<script>
export default {
    data() {
        return {
            filterText: '',
            currentPage: 1,
            pageSize: 20,
            totalItems: 0,
            tableData: [],
            nutrimentQueryDto: { isPublish: true }, // 只查询公开的营养素
        };
    },
    created() {
        this.fetchFreshData();
    },
    methods: {
        // 查询公开营养素数据
        async fetchFreshData() {
            try {
                this.tableData = [];
                // 请求参数
                const params = {
                    current: this.currentPage,
                    size: this.pageSize,
                    key: this.filterText,
                    ...this.nutrimentQueryDto
                };
                const response = await this.$axios.post('/nutriment/query', params);
                const { data } = response;
                this.tableData = data.data;
                this.totalItems = data.total;
            } catch (error) {
                this.$message.error("查询公开营养素异常");
                console.error('查询公开营养素异常:', error);
            }
        },
        
        handleFilter() {
            this.currentPage = 1;
            this.fetchFreshData();
        },
        
        handleFilterClear() {
            this.filterText = '';
            this.handleFilter();
        },
        
        handleSizeChange(val) {
            this.pageSize = val;
            this.currentPage = 1;
            this.fetchFreshData();
        },
        
        handleCurrentChange(val) {
            this.currentPage = val;
            this.fetchFreshData();
        }
    }
};
</script>

<style scoped>
.text-button {
    color: #409EFF;
    margin-right: 10px;
    cursor: pointer;
}
</style> 