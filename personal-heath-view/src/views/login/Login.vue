<template>
    <div class="login-container">
        <video class="background-video" autoplay loop muted playsinline>
            <source src="/background.mp4" type="video/mp4">
        </video>
        <div class="login-panel">
            <div class="login-logo">
                <div class="large-logo-wrapper">
                    <img src="/LOGO0.png" alt="健康图标" class="large-logo-icon" />
                    <div class="large-logo-text">
                        <span class="large-brand-text">蝶启新生</span>
                    </div>
                </div>
            </div>
            <div class="text">
                <input v-model="act" class="act" placeholder="账号" />
            </div>
            <div class="text">
                <input v-model="pwd" class="pwd" type="password" placeholder="密码" />
            </div>
            <div>
                <span class="login-btn" @click="login">立即登录</span>
            </div>
            <div class="tip">
                <p>没有账号？<span class="no-act" @click="toDoRegister">点此注册</span></p>
            </div>
        </div>
    </div>
</template>

<script>
const ADMIN_ROLE = 1;
const USER_ROLE = 2;
const DELAY_TIME = 1300;
import request from "@/utils/request.js";
import { setToken } from "@/utils/storage.js";
import md5 from 'js-md5';
export default {
    name: "Login",
    data() {
        return {
            act: '',
            pwd: '',
            colorLogo: 'rgb(38,38,38)',
        }
    },
    methods: {
        // 跳转注册页面
        toDoRegister(){
            this.$router.push('/register');
        },
        async login() {
            if (!this.act || !this.pwd) {
                this.$swal.fire({
                    title: '填写校验',
                    text: '账号或密码不能为空',
                    icon: 'error',
                    showConfirmButton: false,
                    timer: DELAY_TIME,
                });
                return;
            }
            const hashedPwd = md5(md5(this.pwd));
            const paramDTO = { userAccount: this.act, userPwd: hashedPwd };
            try {
                const { data } = await request.post(`user/login`, paramDTO);
                if (data.code !== 200) {
                    this.$swal.fire({
                        title: '登录失败',
                        text: data.msg,
                        icon: 'error',
                        showConfirmButton: false,
                        timer: DELAY_TIME,
                    });
                    return;
                }
                setToken(data.data.token);
                
                // 检查是否是家庭成员账号（是否有parentUserId）
                if (data.data.parentUserId) {
                    // 获取关联的主账号信息
                    try {
                        const parentResponse = await request.get(`user/parentInfo/${data.data.parentUserId}`);
                        if (parentResponse.data.code === 200) {
                            const parentInfo = parentResponse.data.data;
                            // 保存关联关系信息
                            sessionStorage.setItem('parentInfo', JSON.stringify({
                                parentId: data.data.parentUserId,
                                parentName: parentInfo.userName,
                                relation: data.data.relation
                            }));
                            
                            // 显示关联关系提示
                            this.$message.success(`您已登录 ${parentInfo.userName} 的家庭成员账号 (${data.data.relation})`);
                        }
                    } catch (error) {
                        console.error('获取关联用户信息失败:', error);
                    }
                }
                
                // 根据角色延迟跳转
                setTimeout(() => {
                    const { role } = data.data;
                    this.navigateToRole(role);
                }, DELAY_TIME);
            } catch (error) {
                console.error('登录请求错误:', error);
                this.$message.error('登录请求出错，请重试！');
            }
        },
        navigateToRole(role) {
            switch (role) {
                case ADMIN_ROLE:
                    this.$router.push('/admin');
                    break;
                case USER_ROLE:
                    this.$router.push('/user');
                    break;
                default:
                    console.warn('未知的角色类型:', role);
                    break;
            }
        },
    }
};
</script>

<style lang="scss" scoped>
* {
    user-select: none;
}

/* 直接创建更大尺寸的Logo而不是调整组件样式 */
.login-logo {
  display: flex;
  align-items: center;
  padding: 10px 0;
  margin-bottom: 20px;
}

.large-logo-wrapper {
  display: flex;
  align-items: center;
  gap: 15px;
  justify-content: flex-start;
}

.large-logo-icon {
  width: 50px;
  height: 50px;
  object-fit: contain;
  border-radius: 10px;
}

.large-logo-text {
  display: flex;
  flex-direction: column;
}

.large-brand-text {
  font-size: 48px;
  font-family: '行楷', '华文行楷', 'STXingkai', '行书', '楷体', serif;
  font-weight: 600;
  color: #3498db;
  text-shadow: 
    0 0 8px rgba(52, 152, 219, 0.6),
    0 0 12px rgba(52, 152, 219, 0.4);
  -webkit-text-stroke: 0.001px rgba(255, 255, 255, 0.7);
  background-image: 
    linear-gradient(to right, #2980b9, #3498db, #5dade2, #3498db, #2980b9);
  background-size: 200% auto;
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  letter-spacing: 2px;
  position: relative;
  animation: shimmer 8s ease infinite;
}

.large-brand-text::after {
  content: "";
  position: absolute;
  bottom: 2px;
  left: 2px;
  width: 90%;
  height: 1px;
  background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.4), rgba(52, 152, 219, 0.7), rgba(52, 152, 219, 0.4), transparent);
  filter: blur(1px);
}

@keyframes shimmer {
  0% {
    background-position: 0% center;
  }
  50% {
    background-position: 100% center;
  }
  100% {
    background-position: 0% center;
  }
}

.login-container {
    width: 100%;
    min-height: 100vh;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    flex-direction: column;
    position: relative;
    overflow: hidden;
}

.background-video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: -1;
}

.login-panel {
    width: 350px;
    height: auto;
    padding: 50px 35px 25px 35px;
    border-radius: 16px;
    background-color: rgba(255, 255, 255, 0.25);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    box-shadow: 0 4px 30px rgba(31, 38, 135, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.18);
    z-index: 1;
    position: absolute;
    right: 5%;
    top: 50%;
    transform: translateY(-50%);

    .logo {
        margin: 10px 0 35px 0;
        text-align: left;
    }

    .act,
    .pwd {
        margin: 8px 0;
        height: 53px;
        line-height: 53px;
        width: 100%;
        padding: 0 8px;
        background-color: rgba(255, 255, 255, 0.2);
        box-sizing: border-box;
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 10px;
        font-weight: 600;
        font-size: 18px;
        padding: 0 15px;
        margin-top: 13px;
        color: rgb(255, 255, 255);
        transition: all 0.3s ease;
    }

    .act:focus,
    .pwd:focus {
        outline: none;
        background-color: rgba(255, 255, 255, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.4);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
    }
    
    .role {
        display: inline-block;
        color: rgba(255, 255, 255, 0.8);
        font-size: 14px;
        padding-right: 10px;
    }
}

.login-btn {
    display: inline-block;
    text-align: center;
    border-radius: 10px;
    margin-top: 20px;
    height: 48px;
    line-height: 48px;
    width: 100%;
    background-color: rgba(255, 255, 255, 0.8);
    font-size: 16px !important;
    font-weight: 600;
    border: none;
    color: rgba(25, 30, 110, 0.9);
    padding: 0 !important;
    cursor: pointer;
    user-select: none;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.login-btn:hover {
    background-color: rgba(255, 255, 255, 0.95);
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

.tip {
    margin: 20px 0;

    p {
        padding: 3px 0;
        margin: 0;
        font-size: 14px;
        color: rgba(255, 255, 255, 0.8);
        font-weight: 500;

        i{
            margin-right: 3px;
        }

        span {
            color: rgba(255, 255, 255, 1);
            border-radius: 2px;
            margin: 0 6px;
            transition: all 0.3s ease;
        }
        
        .no-act:hover{
            color: rgba(255, 255, 255, 0.7);
            cursor: pointer;
            text-decoration: underline;
        }
    }
}
</style>