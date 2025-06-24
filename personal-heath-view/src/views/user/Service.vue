<template>
    <div class="service-container">
        <div class="page-header">
            <h2 class="page-title">内容中心</h2>
            <p class="page-subtitle">分享您的健康经验与见解，管理个人创作与收藏</p>
        </div>
        
        <div class="content-panel">
            <el-tabs v-model="activeName" @tab-click="handleClick" class="custom-tabs">
                <el-tab-pane label="我的帖子" name="first">
                    <div class="empty-placeholder" v-if="gourmetList.length === 0">
                        <el-empty description="您还没有发布任何帖子"></el-empty>
                        <el-button type="primary" size="medium" @click="activeName = 'third'">开始创作</el-button>
                    </div>
                    <div v-else class="post-list">
                        <div class="post-header">
                            <h3><i class="el-icon-document"></i> 我的帖子 <span class="count-badge">{{ gourmetList.length }}</span></h3>
                        </div>
                        <div class="post-item" v-for="(gourmet, index) in gourmetList" :key="index">
                            <div class="post-cover">
                                <img :src="gourmet.cover" :alt="gourmet.title">
                                <div class="hover-overlay">
                                    <i class="el-icon-view"></i>
                                </div>
                            </div>
                            <div class="post-content">
                                <div class="post-user">
                                    <img :src="gourmet.userAvatar" :alt="gourmet.userName">
                                    <span>{{ gourmet.userName }}</span>
                                    <el-tag size="mini" type="info">{{ formatTime(gourmet.createTime) }}</el-tag>
                                </div>
                                <h3 class="post-title" @click="readGourmet(gourmet)">{{ gourmet.title }}</h3>
                                <div class="post-excerpt">{{ trimText(gourmet.detail, 100) }}</div>
                                <div class="post-actions">
                                    <div class="action-stats">
                                        <span class="action-stat"><i class="el-icon-thumb"></i>{{ gourmet.upvoteCount }}</span>
                                        <span class="action-stat"><i class="el-icon-view"></i>{{ gourmet.viewCount }}</span>
                                        <span class="action-stat"><i class="el-icon-star-off"></i>{{ gourmet.saveCount }}</span>
                                    </div>
                                    <div class="action-buttons">
                                        <el-button size="mini" type="primary" icon="el-icon-edit" @click="edit(gourmet)">编辑</el-button>
                                        <el-button size="mini" type="danger" icon="el-icon-delete" @click="del(gourmet)">删除</el-button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </el-tab-pane>
                <el-tab-pane label="我的收藏" name="second">
                    <MySave />
                </el-tab-pane>
                <el-tab-pane label="内容创作" name="third">
                    <CreateGourmet @refresh="fetchMyslefGourmet" />
                </el-tab-pane>
            </el-tabs>
        </div>
    </div>
</template>

<script>
import MySave from "@/views/user/MySave"
import CreateGourmet from "@/views/user/CreateGourmet"
import { timeAgo } from "@/utils/data"

export default {
    components: { MySave, CreateGourmet },
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
        trimText(text, maxLength) {
            if (!text) return '';
            return text.length > maxLength ? text.substring(0, maxLength) + '...' : text;
        },
        formatTime(time) {
            return timeAgo(time);
        },
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
.service-container {
    background-color: #f9fafb;
    min-height: calc(100vh - 60px);
    padding: 30px;
}

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
    
    &:after {
        display: none;
    }
}

.page-subtitle {
    font-size: 14px;
    margin: 0;
    opacity: 0.9;
}

.content-panel {
    background-color: white;
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    padding: 25px;
}

.custom-tabs {
    .el-tabs__item {
        font-size: 16px;
        font-weight: 500;
        height: 50px;
        line-height: 50px;
        
        &.is-active {
            color: #0f753f;
            font-weight: 600;
        }
    }
    
    .el-tabs__active-bar {
        background-color: #0f753f;
        height: 3px;
    }
}

.empty-placeholder {
    padding: 40px 0;
    text-align: center;
    
    .el-button {
        margin-top: 20px;
        background-color: #0f753f;
        border-color: #0f753f;
        
        &:hover {
            background-color: #0b5e32;
            border-color: #0b5e32;
        }
    }
}

.post-list {
    margin-top: 20px;
}

.post-header {
    margin-bottom: 20px;
    border-bottom: 1px solid #eaeaea;
    padding-bottom: 15px;
    
    h3 {
        font-size: 20px;
        font-weight: 600;
        color: #1f2937;
        margin: 0;
        display: flex;
        align-items: center;
        
        i {
            color: #0f753f;
            margin-right: 8px;
            font-size: 22px;
        }
        
        .count-badge {
            background-color: #0f753f;
            color: white;
            font-size: 14px;
            padding: 2px 8px;
            border-radius: 12px;
            margin-left: 10px;
            font-weight: 500;
        }
    }
}

.post-item {
    display: flex;
    margin-bottom: 20px;
    padding: 16px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    transition: all 0.3s ease;
    border: 1px solid #f0f0f0;
    
    &:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 16px rgba(0,0,0,0.1);
        
        .hover-overlay {
            opacity: 1;
        }
        
        .post-title {
            color: #0f753f;
        }
    }
}

.post-cover {
    flex-shrink: 0;
    width: 180px;
    height: 130px;
    position: relative;
    overflow: hidden;
    border-radius: 8px;
    
    img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    
    .hover-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        transition: all 0.3s ease;
        
        i {
            font-size: 24px;
            color: white;
            background: rgba(15, 117, 63, 0.8);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    }
}

.post-content {
    flex: 1;
    padding-left: 20px;
    display: flex;
    flex-direction: column;
}

.post-user {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    
    img {
        width: 24px;
        height: 24px;
        border-radius: 50%;
        margin-right: 8px;
        border: 2px solid #fff;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    span {
        font-size: 14px;
        color: #4b5563;
        margin-right: 10px;
    }
    
    .el-tag {
        background-color: #f3f4f6;
        color: #6b7280;
        border: none;
    }
}

.post-title {
    font-size: 18px;
    font-weight: 700;
    margin-bottom: 10px;
    line-height: 1.4;
    color: #1f2937;
    cursor: pointer;
    transition: color 0.3s ease;
    
    &:hover {
        color: #0f753f;
    }
}

.post-excerpt {
    font-size: 14px;
    color: #6b7280;
    line-height: 1.5;
    margin-bottom: 16px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.post-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: auto;
}

.action-stats {
    display: flex;
    
    .action-stat {
        display: flex;
        align-items: center;
        margin-right: 16px;
        font-size: 13px;
        color: #6b7280;
        
        i {
            margin-right: 5px;
            font-size: 14px;
        }
        
        &:nth-child(1) i {
            color: #ef4444;
        }
        
        &:nth-child(2) i {
            color: #3b82f6;
        }
        
        &:nth-child(3) i {
            color: #f59e0b;
        }
    }
}

.action-buttons {
    .el-button {
        margin-left: 8px;
        
        &.el-button--primary {
            background-color: #0f753f;
            border-color: #0f753f;
            
            &:hover {
                background-color: #0b5e32;
                border-color: #0b5e32;
            }
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
