<template>
    <div class="container">
        <div class="top">
            <el-tooltip class="item" effect="dark" content="返回首页" placement="bottom">
                <span class="last-page" @click="goBack">
                    <i class="el-icon-back"></i>
                </span>
            </el-tooltip>
            <span class="text">发表论坛帖子</span>
        </div>
        <div class="buttom">
            <div>
                <el-col :span="4" style="padding-left: 10px;border-right: 1px solid rgb(231, 231, 231);min-height: calc(100vh - 80px);">
                    <div style="padding-inline: 20px;">
                        <p style="font-size: 32px;">系列</p>
                        <el-select size="small" style="font-size: 20px;" v-model="gourmet.categoryId" placeholder="系列">
                            <el-option style="font-size: 16px;" v-for="item in categories" :key="item.id" :label="item.name" :value="item.id">
                            </el-option>
                        </el-select>
                    </div>
                    <div style="padding-inline: 20px;">
                        <p style="font-size: 32px;">封面</p>
                        <el-upload class="avatar-uploader"
                            action="http://localhost:8080/api/personal-heath/v1.0/file/upload" :show-file-list="false"
                            :on-success="handleCoverSuccess">
                            <img v-if="cover" :src="cover" style="width: 180px;height: 130px;">
                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                        </el-upload>
                    </div>
                    <div style="padding-inline: 20px;">
                        <p style="font-size: 32px;">公开权限</p>
                        <el-switch v-model="gourmet.isPublish" active-color="#13ce66" inactive-color="#3c3f41">
                        </el-switch>
                    </div>
                </el-col>
                <el-col :span="20">
                    <div style="padding-block: 20px;border-bottom: 1px solid rgb(234, 232, 232);">
                        <input v-model="gourmet.title" style="width: 80%;font-size: 40px;padding: 8px 30px;" type="text"
                            class="input-title" placeholder="请输入标题">
                    </div>
                    <div style="border-bottom: 1px solid rgb(234, 232, 232);">
                        <Editor height="calc(100vh - 300px)" :receiveContent="gourmet.content"
                            @on-receive="onReceive" />
                    </div>
                </el-col>
            </div>
            <div style="text-align: center;">
                <el-button @click="postGourmet" style="margin: 20px 0;" plain>发布帖子</el-button>
            </div>
        </div>
    </div>
</template>
<script>
import Editor from "@/components/Editor"
export default {
    components: { Editor },
    name: "CreateGourmet",
    data() {
        return {
            gourmet: {},
            categories: [], 
            cover: null,
        }
    },
    created() {
        this.fetchFreshCategories();
    },
    methods: {
        // 发布帖子
       postGourmet() {
    // 验证必填字段
    if (!this.gourmet.title || !this.gourmet.content || !this.cover) {
        this.$notify({
            duration: 1000,
            title: '论坛新增',
            message: '请填写所有必填字段（标题、内容和封面）',
            type: 'error'
        });
        return;
    }
    
    this.gourmet.cover = this.cover;
    this.$axios.post('/gourmet/save', this.gourmet).then(res => {
        if (res.data.code === 200) {
            this.$notify({
                duration: 1000,
                title: '论坛新增',
                message: '新增成功',
                type: 'success'
            });
            this.goBack();
        }
    }).catch(error => {
        console.log("新增论坛异常：", error);
    });
},
        // 封面上传回调函数
        handleCoverSuccess(res, file) {
            this.$notify({
                duration: 1500,
                title: '封面上传',
                message: res.code === 200 ? '上传成功' : '上传失败',
                type: res.code === 200 ? 'success' : 'error'
            });
            // 上传成功则更新用户头像
            if (res.code === 200) {
                this.cover = res.data;
            }
        },
        fetchFreshCategories() {
            this.$axios.post('/tags/query', {}).then(res => {
                if (res.data.code === 200) {
                    this.categories = res.data.data;
                    const allCategory = { id: null, name: '全部' };
                    // 头插
                    this.categories.unshift(allCategory);
                }
            }).catch(error => {
                console.log("查询信息异常：", error);
            });
        },
        // 返回上一页
        goBack() {
            this.$router.go(-1);
        },
        onReceive(content) {
            this.gourmet.content = content;
        },
    }
};
</script>
<style scoped lang="scss">
.container {
    min-height: 100vh;

    .buttom {
        margin-top: 6px;
    }

    .top {
        line-height: 64px;
        padding-inline: 40px;
        background-color: rgb(255, 255, 255);
        border-bottom: 1px solid rgb(231, 231, 231);

        .text {
            font-size: 18px;
            font-weight: 900;
            margin-left: 10px;
        }

        .last-page:hover {
            background-color: rgb(232, 232, 232);
        }

        .last-page {
            background-color: rgb(245, 245, 245);
            padding: 2px 4px;
            border-radius: 12px;
            border: 1px solid rgb(235, 235, 235);
            cursor: pointer;
        }
    }
}
</style>
