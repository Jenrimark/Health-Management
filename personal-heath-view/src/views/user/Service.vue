<template>
    <div>
        <el-row style="background-color: rgb(255,255,255);padding: 10px;">
            <el-col :span="24">
                <div style="margin-inline: 10px;">
                    <el-tabs v-model="activeName" @tab-click="handleClick">
                        <el-tab-pane label="我的帖子" name="first">
                            <div style="display: flex;justify-content: left;" class="item-gourmet"
                                v-for="(gourmet, index) in gourmetList" :key="index">
                                <div class="left">
                                    <img :src="gourmet.cover">
                                </div>
                                <div class="right">
                                    <div class="info">
                                        <img style="width: 20px;height: 20px;border-radius: 10px;"
                                            :src="gourmet.userAvatar" alt="">
                                        <span>{{ gourmet.userName }}</span>
                                    </div>
                                    <div class="title" @click="readGourmet(gourmet)">
                                        {{ gourmet.title }}
                                    </div>
                                    <div class="detail">
                                        {{ gourmet.detail }}
                                    </div>
                                    <div class="detail">
                                        <span>
                                            {{ gourmet.createTime }}
                                        </span>
                                        <span>
                                            <i class="el-icon-discount" style="margin-right: 4px;"></i>({{
                                                gourmet.upvoteCount }})
                                        </span>
                                        <span>
                                            <i class="el-icon-view" style="margin-right: 4px;"></i>({{ gourmet.viewCount
                                            }})
                                        </span>
                                        <span>
                                            <i class="el-icon-star-off" style="margin-right: 4px;"></i>({{
                                                gourmet.saveCount
                                            }})
                                        </span>
                                        <span style="color: rgb(143, 94, 38);" @click="del(gourmet)">
                                            删除
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="我的收藏" name="second">
                            <MySave />
                        </el-tab-pane>
                        <el-tab-pane label="内容创作" name="third">
                             <CreateGourmet />
                        </el-tab-pane>
                    </el-tabs>
                </div>
            </el-col>
        </el-row>
        <el-row  style="background-color: rgb(255,255,255);padding: 20px;">
            <div style="padding: 30px;margin-top: 30px;">

            </div>
        </el-row>
    </div>

</template>
<script>
import MySave  from "@/views/user/MySave"
import CreateGourmet from "@/views/user/CreateGourmet"

export default {
    components: { MySave, CreateGourmet},
    name: "Service",
    data() {
        return {
            contentNet: { passwordAuth: false },
            gourmet: {},
            info: {},
            activeName: 'first',
            gourmetList: [],
            dialogShareOperaion: false,
        }
    },
    created() {
        this.fetchMyslefGourmet();
        this.fetchCenter();
    },
    methods: {
        addOperation() {
            const dayList = [this.contentNet.validDay];
            const validDayList = dayList.map(text => {
                const match = text.match(/\d+/g); // 使用正则表达式匹配数字
                return match ? match : []; // 如果找到数字，返回数组，否则返回空数组
            });
            if (this.contentNet.passwordAuth) {
                this.contentNet.accessPassword = this.$md5(this.contentNet.accessPassword);
            }
        },
        cannel() {
            this.dialogShareOperaion = false;
            this.url = '';
            this.contentNet = {};
        },
        shareOperation() {

        },
        // 跳转美食帖子修改信息页面
        edit(gourmet) {
            console.log("论坛：",gourmet);
            
            sessionStorage.setItem('gourmetId', gourmet.id);
            this.$router.push('/editGourmet');
        },
        share(gourmet) {
            this.gourmet = gourmet;
            this.dialogShareOperaion = true;
        },
        async del(gourmet) {
            const confirmed = await this.$swalConfirm({
                title: '删除论坛数据',
                text: `删除后不可恢复，是否继续？`,
                icon: 'warning',
            });
            if (confirmed) {
                try {
                    let ids = [gourmet.id];
                    const response = await this.$axios.post(`/gourmet/batchDelete`, ids);
                    if (response.data.code === 200) {
                        this.$notify({
                            duration: 1000,
                            title: '信息删除',
                            message: '删除成功',
                            type: 'success'
                        });
                        this.fetchMyslefGourmet();
                        return;
                    }
                } catch (error) {
                    this.$notify.error({
                        duration: 1000,
                        title: '删除错误',
                        message: error
                    });
                    console.error(`论坛信息删除异常：`, error);
                }
            }
        },
        handleClick(tab, event) {
            console.log(tab, event);
        },
        readGourmet(gourmet) {
            sessionStorage.setItem('gourmetId', gourmet.id);
            this.$router.push('/gourmetDetail');
        },
        fetchMyslefGourmet() {
            this.$axios.get('/gourmet/queryUser').then(res => {
                const { data } = res;
                if (data.code === 200) {
                    this.gourmetList = data.data;
                }
            }).catch(error => {
                console.log("查询数据异常", error);

            });
        },
        fetchCenter() {
            this.$axios.get('/user/center').then(res => {
                const { data } = res;
                if (data.code === 200) {
                    this.info = data.data;
                }
            }).catch(error => {
                console.log("查询用户中心数据异常", error);

            });
        },
    }
};
</script>
<style scoped lang="scss">
.item-gourmet:hover {
    background-color: rgb(248, 248, 248);
}

.item-gourmet {
    display: flex;
    justify-content: left;
    gap: 10px;
    padding: 10px;
    border-radius: 5px;
    cursor: pointer;

    .left {
        img {
            width: 190px;
            border-radius: 5px;
        }
    }

    .right {
        .info {
            padding: 4px 6px;
            display: flex;
            justify-content: left;
            align-items: center;
            gap: 5px;
            font-size: 14px;
            color: rgb(90, 89, 89);
        }

        .title {
            font-size: 20px;
            font-weight: 800;
        }

        .title:hover {
            text-decoration: underline;
            text-decoration-style: dashed;
        }

        .detail {
            font-size: 12px;
            padding: 4px 6px;
            color: rgb(90, 89, 89);
            display: flex;
            justify-content: left;
            gap: 10px;
        }
    }
}

.info {
    display: flex;
    justify-content: left;
    padding: 20px;
    gap: 20px;

    img {
        width: 100px;
        height: 100px;
        border-radius: 50px;
    }

    .title {
        font-size: 26px;
        font-weight: bold;
        color: rgb(51, 51, 51);
        margin-bottom: 20px;
        margin-top: 5px;
    }

    .point-info {
        display: flex;
        justify-content: left;
        gap: 20px;

        .count {
            font-size: 24px;
            display: inline-block;
            margin-right: 4px;
            font-weight: bold;
        }
    }
}
</style>
