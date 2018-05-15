const commonConfig = require('./../../build-config/common.config');
const SyncCriticalPlugin = require('./webpack.sync-critical-webpack-plugin');

module.exports = {
    plugins: [
        new SyncCriticalPlugin({
            // Your base directory
            base: commonConfig.syncCriticalWebpackPlugin.base,

            // Can be an array - HTML source file or path/segment on website
            // (set website url below!)
            srcPrefix: commonConfig.syncCriticalWebpackPlugin.srcPrefix,
            // Optional use if base is a website segment, prefixes path/segment
            url: commonConfig.syncCriticalWebpackPlugin.url,

            // Can be an array - Target file for final HTML/CSS output.
            // (set extension below!)
            dest: commonConfig.syncCriticalWebpackPlugin.dest,
            // Tagret files ext e.g. '.html' or '_min.css'
            destExt: commonConfig.syncCriticalWebpackPlugin.destExt,

            // Set to true if target is html (same as source)
            inline: false,

            // ignore CSS rules
            ignore: ['@font-face'],

            // Minify critical-path CSS when inlining
            minify: false,

            // Viewport width
            width: 1440,

            // Viewport height
            height: 1280,

            // Extract inlined styles from referenced stylesheets
            extract: false,

            // block JsRequests
            penthouse: {
                blockJSRequests: true,
                strict: true,
            },
        }),
    ],
};
