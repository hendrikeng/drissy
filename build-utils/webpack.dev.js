const HtmlWebpackPlugin = require('html-webpack-plugin');
const WriteFilePlugin = require('write-file-webpack-plugin');
const Stylish = require('webpack-stylish');
const WebpackBar = require('webpackbar');
const webpack = require('webpack');
const sane = require('sane');
const opn = require('opn');
const path = require('path');
const ipAddress = require('./get-ip');
const commonConfig = require('./../build-config/common.config');

/* eslint-disable no-console, no-unused-vars */

module.exports = {
    mode: 'development',
    entry: commonConfig.entry,
    output: {
        publicPath: commonConfig.output.publicPath.src,
    },
    cache: true,
    module: {
        rules: [
            {
                test: /\.css/,
                use: [
                    'style-loader',
                    {
                        loader: 'css-loader',
                        options: {
                            importLoaders: 1,
                            minimize: false,
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
    devServer: {
        publicPath: commonConfig.output.publicPath.src,
        clientLogLevel: 'warning',
        overlay: commonConfig.devServer.errorOverlay
            ? { warnings: false, errors: true }
            : false,
        contentBase: false,
        watchContentBase: false,
        stats: 'none',
        compress: true,
        hot: true,
        watchOptions: {
            poll: false,
        },
        historyApiFallback: {
            rewrites: [
                {
                    from: /.*/,
                    // was das?
                    to: path.posix.join('../templates/', '404'),
                },
            ],
        },
        https: commonConfig.devServer.https,
        host: ipAddress,
        port: 8080,
        proxy: {
            '**': {
                target: commonConfig.urls.dev,
                changeOrigin: true,
                secure: commonConfig.devServer.https,
            },
        },
        headers: {
            'Access-Control-Allow-Origin': '*',
        },
        before(app, server) {
            const watcher = sane('./templates/', {
                glob: commonConfig.contentBase,
            });
            watcher.on('change', (filepath, root, stat) => {
                console.log('file changed', filepath);
                server.sockWrite(server.sockets, 'content-changed');
            });
        },
        after(app) {
            if (commonConfig.devServer.openBrowser) {
                opn(commonConfig.urls.dev);
            }
        },
    },
    plugins: [
        new webpack.ProgressPlugin(),
        new webpack.HotModuleReplacementPlugin(),
        new webpack.NamedModulesPlugin(),
        new HtmlWebpackPlugin({
            template: commonConfig.htmlWebpackPlugin.template,
            filename: commonConfig.htmlWebpackPlugin.filename,
            title: commonConfig.htmlWebpackPlugin.title,
            inject: true,
            // minifying html won't work with critical css
            minify: false,
            env: {
                dev: true,
                prod: false,
                debug: false,
            },
        }),
        new WriteFilePlugin({
            // write ejs template to twig
            test: /\.twig$/,
            useHashIndex: false,
        }),
        new WebpackBar(),
        new Stylish(),
    ],
};