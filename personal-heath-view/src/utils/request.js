import axios from "axios"
import { getToken } from "@/utils/storage.js";

const request = axios.create({
    baseURL: 'http://localhost:8080/api/personal-heath/v1.0',
    timeout: 60000,  // 确保超时设置为60秒
    headers: {
        'Content-Type': 'application/json'
    }
});

// 请求拦截器
request.interceptors.request.use(config => {
    const token = getToken();
    if (token) {
        config.headers["token"] = token;
    }
    return config;
}, error => {
    return Promise.reject(error);
});

export default request;