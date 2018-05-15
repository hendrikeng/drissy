const commonConfig = require('./../build-config/common.config');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');

module.exports = {
    mode: 'production',
    entry: commonConfig.entry,
    output: {
        publicPath: commonConfig.output.publicPath.dist,
    },
    devtool: false, // https://webpack.js/configuration/devtool
    optimization: {
        minimizer: [
            new UglifyJsPlugin({
                cache: true,
                parallel: true,
                sourceMap: false,
                uglifyOptions: {
                    compress: {
                        warnings: false,
                        drop_console: false,
                    },
                },
            }),
            new OptimizeCssAssetsPlugin({
                cssProcessorOptions: {
                    discardComments: {
                        removeAll: true,
                    },
                },
                map: {
                    inline: false,
                },
                canPrint: true,
                safe: true,
            }),
        ],
    },
    module: {
        rules: [{
            test: /\.css$/,
            use: [
                MiniCssExtractPlugin.loader,
                {
                    loader: 'css-loader',
                    options: {
                        importLoaders: 1,
                        minimize: true,
                    },
                },
                {
                    loader: 'postcss-loader',
                    options: {
                        config: {
                            path: './build-config/postcss.config.js',
                        },
                    },
                },
            ],
        }],
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: commonConfig.htmlWebpackPlugin.template,
            filename: commonConfig.htmlWebpackPlugin.filename,
            title: commonConfig.htmlWebpackPlugin.title,
            inject: false,
            // minifying html won't work with critical css
            minify: false,
            env: {
                dev: false,
                prod: true,
            },
        }),
        new MiniCssExtractPlugin(commonConfig.miniCssExtractPlugin),
    ],
};
