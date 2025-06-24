<template>
    <div class="user-container">
        <div class="menus-container"
            style="position: sticky;top: 0;z-index: 1000;background-color: rgb(255, 255, 255);">
            <UserMenu :menus="routers" :userInfo="userInfo" @eventListener="eventListener" />
            <!-- 如果是家庭成员账号，显示关联信息 -->
            <div v-if="parentInfo" class="family-relation-info">
                您正在使用 {{ parentInfo.parentName }} 的家庭成员账号 ({{ parentInfo.relation }})
            </div>
        </div>
        <div class="content-container">
            <router-view class="route-container"></router-view>
        </div>
        <!-- 个人中心 -->
        <el-dialog :show-close="false" :visible.sync="dialogOperaion" width="26%">
            <div slot="title" style="padding: 25px 0 0 20px;">
                <span style="font-size: 18px;font-weight: 800;">个人中心</span>
            </div>
            <el-row style="padding: 10px 20px 20px 20px;">
                <el-row>
                    <p style="font-size: 12px;padding: 3px 0;margin-bottom: 10px;">
                        <span class="modelName">*头像</span>
                    </p>
                    <el-upload class="avatar-uploader" action="http://localhost:8080/api/personal-heath/v1.0/file/upload"
                        :show-file-list="false" :on-success="handleAvatarSuccess">
                        <img v-if="data.url" :src="data.url" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-row>
                <el-row>
                    <p style="font-size: 12px;padding: 3px 0;">
                        <span class="modelName">*用户名</span>
                    </p>
                    <input class="modelInput" type="text" v-model="data.name" placeholder="用户名">
                </el-row>
                <el-row>
                    <p style="font-size: 12px;padding: 3px 0;">
                        <span class="modelName">*个人邮箱</span>
                    </p>
                    <input class="modelInput" type="text" v-model="data.email" placeholder="用户名">
                </el-row>
                <div style="margin: 15px 0;">
                    <p style="font-size: 12px;padding: 3px 0; margin-bottom: 10px;">
                        <span class="modelName">*性别</span>
                    </p>
                    <el-radio-group v-model="data.gender" style="margin-left: 10px;">
                        <el-radio :label="false">女</el-radio>
                        <el-radio :label="true">男</el-radio>
                    </el-radio-group>
                </div>
                <div style="margin: 15px 0;">
                    <p style="font-size: 12px;padding: 3px 0; margin-bottom: 10px;">
                        <span class="modelName">*年龄</span>
                    </p>
                    <el-input-number v-model="data.age" :min="1" :max="120" style="margin-left: 10px;"></el-input-number>
                </div>
            </el-row>
            <span slot="footer" class="dialog-footer">
                <el-button class="customer" size="small" style="background-color: rgb(241, 241, 241);border: none;"
                    @click="dialogOperaion = false">取 消</el-button>
                <el-button size="small" style="background-color: #15559a;border: none;" class="customer" type="info"
                    @click="updateUserInfo">修改</el-button>
            </span>
        </el-dialog>
        <!-- 重置密码 -->
        <el-dialog :show-close="false" :visible.sync="dialogRetPwdOperaion" width="26%">
            <div slot="title" style="padding: 25px 0 0 20px;">
                <span style="font-size: 18px;font-weight: 800;">重置密码</span>
            </div>
            <el-row style="padding: 10px 20px 20px 20px;">
                <el-row>
                    <p style="font-size: 12px;padding: 3px 0;margin-bottom: 10px;">
                        <span class="modelName">*原始密码</span>
                    </p>
                    <input class="modelInput" type="password" v-model="pwdEntity.oldPwd" placeholder="原始密码">
                </el-row>
                <el-row>
                    <p style="font-size: 12px;padding: 3px 0;margin-bottom: 10px;">
                        <span class="modelName">*新密码</span>
                    </p>
                    <input class="modelInput" type="password" v-model="pwdEntity.newPwd" placeholder="新密码">
                </el-row>
                <el-row>
                    <p style="font-size: 12px;padding: 3px 0;margin-bottom: 10px;">
                        <span class="modelName">*确认密码</span>
                    </p>
                    <input class="modelInput" type="password" v-model="pwdEntity.againPwd" placeholder="确认密码">
                </el-row>
            </el-row>
            <span slot="footer" class="dialog-footer">
                <el-button class="customer" size="small" style="background-color: rgb(241, 241, 241);border: none;"
                    @click="dialogRetPwdOperaion = false">取 消</el-button>
                <el-button size="small" style="background-color: #15559a;border: none;" class="customer" type="info"
                    @click="updateUserPwd">修改</el-button>
            </span>
        </el-dialog>
    </div>
</template>
<script>
   
import { clearToken } from "@/utils/storage.js";
import router from "@/router";
import UserMenu from '@/components/LevelMenu.vue';
export default {
    name: "UserMain",
    components: {
        UserMenu
    },
    data() {
        return {
            userInfo: {},
            data: {},
            pwdEntity: { oldPwd: '', newPwd: '', againPwd: '' },
            dialogOperaion: false,
            dialogRetPwdOperaion: false,
            foodList: [],
            routers: [],
            isCheckFood: [],
            isCheckHealthModelConfig: [],
            healthModelConfig: [],
            selecedFoodIndex: 0,
            selecedHealthModelIndex: 0,
            dietDialog: false,
            healthModelConfigDialog: false,
            parentInfo: null
        };
    },
    created() {
        this.tokenCheckLoad();
        
        // 检查是否存在家庭关联信息
        const parentInfoStr = sessionStorage.getItem('parentInfo');
        if (parentInfoStr) {
            this.parentInfo = JSON.parse(parentInfoStr);
        }
    },
    methods: {
        healthModelChange() {
            const healthModel = this.healthModelConfig[this.selecedHealthModelIndex - 2];
            const exists = this.isCheckHealthModelConfig.some(item => item.id === healthModel.id);
            // 如果不存在，则添加新选的健康配置项
            if (!exists) {
                this.isCheckHealthModelConfig.unshift(healthModel);
            } else {
                console.log("指标项已经添加");
            }
        },
        updateUserPwd() {
            this.resetPwd();
        },
        async updateUserInfo() {
            try {
                const userUpdateDTO = {
                    userAvatar: this.data.url,
                    userName: this.data.name,
                    userEmail: this.data.email,
                    gender: this.data.gender,
                    age: this.data.age
                }
                const resposne = await this.$axios.put(`/user/update`, userUpdateDTO);
                const { data } = resposne;
                if (data.code === 200) {
                    this.dialogOperaion = false;
                    this.tokenCheckLoad();
                    this.$swal.fire({
                        title: '修改个人信息',
                        text: data.msg,
                        icon: 'success',
                        showConfirmButton: false,
                        timer: 1000,
                    });
                }
            } catch (e) {
                this.dialogOperaion = false;
                this.$swal.fire({
                    title: '修改个人信息异常',
                    text: e,
                    icon: 'error',
                    showConfirmButton: false,
                    timer: 2000,
                });
                console.error(`修改个人信息异常:${e}`);
            }
        },
        async resetPwd() {
            try {
                const { oldPwd, newPwd, againPwd } = this.pwdEntity;
                if (!oldPwd || !newPwd || !againPwd) {
                    this.$message(`任意项不为空`);
                    return;
                }
                if (newPwd !== againPwd) {
                    this.$message(`前后密码输入不一致`);
                    return;
                }
                const pwdDTO = {
                    oldPwd: this.$md5(this.$md5(oldPwd)),
                    newPwd: this.$md5(this.$md5(newPwd))
                }
                const resposne = await this.$axios.put(`/user/updatePwd`, pwdDTO);
                const { data } = resposne;
                if (data.code === 200) {
                    this.dialogRetPwdOperaion = false;
                    this.$swal.fire({
                        title: '修改密码',
                        text: data.msg,
                        icon: 'success',
                        showConfirmButton: false,
                        timer: 1000,
                    });
                    setTimeout(() => {
                        clearToken();
                        this.$router.push(`/login`);
                    }, 1200)
                } else {
                    this.$message.error(data.msg);
                }
            } catch (e) {
                this.dialogOperaion = false;
                this.$error(data.msg);
                console.error(`修改密码异常:${e}`);
            }
        },
        handleAvatarSuccess(res, file) {
            if (res.code !== 200) {
                this.$message.error(`头像上传异常`);
                return;
            }
            this.$message.success(`头像上传成功`);
            this.data.url = res.data;
        },
        // 监听菜单点击事件
        eventListener(event) {
            // 个人中心
            if (event === 'center') {
                this.dialogOperaion = !this.dialogOperaion;
            }
            // 密码重置
            else if (event === 'resetPwd') {
                this.dialogRetPwdOperaion = true;
                // 搜索页搜索
            } else if (event === 'search-detail') {
                this.$router.push('/search-detail');
            }
            // 退出登录
            else if (event === 'loginOut') {
                this.loginOutOperation();
            }
            // 健康指标记录
            else if (event === 'healthDataRecord') {
                this.$router.push('/record');
            }
            // 家庭管理
            else if (event === 'familyManagement') {
                this.$router.push('/family-management');
            }
        },
        async loginOutOperation() {
            const confirmed = await this.$swalConfirm({
                title: '退出登录',
                text: `退出登录后，需重新登录才能使用系统功能!`,
                icon: 'warning',
            });
            if (confirmed) { // 清除Token，路由至登录页
                clearToken();
                this.$router.push('/login');
            }
        },
        // Token检验
        async tokenCheckLoad() {
            try {
                const res = await this.$axios.get('user/auth');
                // 校验失败
                if (res.data.code === 400) {
                    clearToken();
                    this.$message.error(res.data.msg);
                    this.$router.push('/login');
                    return;
                }
                const { id: userId, userAvatar, userName, userRole, userEmail, gender, age, parentInfo } = res.data.data;
                // 将用户信息存储起来
                sessionStorage.setItem('userInfo', JSON.stringify(res.data.data));
                this.userInfo = {
                    url: userAvatar,
                    name: userName,
                    role: userRole,
                    email: userEmail,
                    gender: gender,
                    age: age
                };
                this.data = { ...this.userInfo };
                this.parentInfo = parentInfo;
                // 根据角色解析路由
                const roleRouteKey = userRole === 1 ? 'admin' : 'user';
                const roleRoute = router.options.routes.find(route => route.path.startsWith(`/${roleRouteKey}`));
                if (roleRoute) {
                    this.routers = roleRoute.children;
                } else {
                    console.error('未能找到对应角色的路由配置');
                }
            } catch (error) {
                console.error('Token检验时发生错误:', error);
            }
        }
    },
};
</script>
<style scoped lang="scss">
#nutrition-select {
    margin: 10px;
    padding: 5px;
    font-size: 16px;
    border: none;
    outline: none;
    width: 90%;
}

.family-relation-info {
    background-color: #ecf5ff;
    color: #409EFF;
    padding: 8px 20px;
    font-size: 14px;
    text-align: center;
    border-bottom: 1px solid #d9ecff;
}

.user-container {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    background-color: rgb(247, 247, 247);
}

.removeFood {
    color: rgba(0, 0, 0, 0.6);
    user-select: none;
    cursor: pointer;
    display: inline-block;
    margin-top: 10px;
}

.removeFood:hover {
    color: #1c1c1c;
}

label {
    font-size: 14px;
    color: rgba(0, 0, 0, 0.6);
}

.content-container {
    padding: 10px 180px;
    box-sizing: border-box;
    min-height: calc(100vh - 200px);
    overflow-x: hidden;
}

.modelInput {
    outline: none;
    border: none;
    font-size: 22px;
    width: 60%;
    font-weight: 800;
}

.avatar {
    width: 88px;
    height: 88px;
}
</style>
