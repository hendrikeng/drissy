const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const commonConfig = require('./../build-config/common.config');

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
                extractComments: true,
                cache: true,
                parallel: true,
                sourceMap: false,
                uglifyOptions: {
                    mangle: true,
                    keep_fnames: false,
                    ie8: false,
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
        rules: [
            {
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
            },
        ],
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
                debug: false,
            },
        }),
        new MiniCssExtractPlugin(commonConfig.miniCssExtractPlugin),
    ],
};