const StyleLintPlugin = require('stylelint-webpack-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const commonConfig = require('./../build-config/common.config');

module.exports = {
    // https://stackoverflow.com/questions/35903246/how-to-create-multiple-output-paths-in-webpack-config
    output: {
        path: commonConfig.output.path,
        filename: '[name].[hash:7].js',
    },
    resolve: {
        extensions: ['.js', '.vue', '.json'],
        alias: {
            vue$: 'vue/dist/vue.esm.js',
            '@': commonConfig.src.js,
        },
    },
    module: {
        rules: [
            {
                test: /\.(js|vue)$/,
                loader: 'eslint-loader',
                enforce: 'pre',
                include: commonConfig.src.js,
            },
            {
                test: /\.vue$/,
                loader: 'vue-loader',
                include: commonConfig.src.js,
            },
            {
                test: /\.js$/,
                loader: 'babel-loader',
                include: commonConfig.src.js,
            },
            {
                test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
                loader: 'url-loader',
                options: {
                    limit: 10000,
                    name: 'file-loader?img/[name].[ext]',
                },
            },
            {
                test: /\.(mp4|webm|ogg|mp3|wav|flac|aac)(\?.*)?$/,
                loader: 'url-loader',
                options: {
                    limit: 10000,
                    name: 'file-loader?media/[name].[ext]',
                },
            },
            {
                test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
                loader: 'url-loader',
                options: {
                    limit: 10000,
                    name: 'fonts/[name].[ext]',
                },
            },
        ],
    },
    node: {
        // prevent webpack from injecting useless setImmediate polyfill because Vue
        // source contains it (although only uses it if it's native).
        setImmediate: false,
        // prevent webpack from injecting mocks to Node native modules
        // that does not make sense for the client
        dgram: 'empty',
        fs: 'empty',
        net: 'empty',
        tls: 'empty',
        child_process: 'empty',
    },
    plugins: [
        new VueLoaderPlugin(),
        new StyleLintPlugin({
            configFile: './build-config/stylelint.config.js',
            context: './src/css/',
            syntax: 'css',
            failOnError: false,
            quiet: false,
        }),
    ],
};
