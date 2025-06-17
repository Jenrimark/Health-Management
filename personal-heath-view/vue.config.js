module.exports = {
    lintOnSave: false,
    assetsDir: 'static',
    parallel: false,
    publicPath: './',
    devServer: {
        host: "localhost",
        port: 8081,
        https: false,
        proxy: {
            '/api': {
                target: 'http://localhost:8080',
                changeOrigin: true,
                pathRewrite: {
                    '^/api': ''
                }
            }
        },
        overlay: {
            warning: false,
            errors: false
        },
    },
}