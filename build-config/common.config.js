const path = require('path');
const ipAddress = require('../build-utils/get-ip');
const pkg = require('../package.json');

function resolve(dir) {
    return path.join(__dirname, '..', dir);
}

const useHttps = false;

module.exports = {
    urls: {
        dev: useHttps ? `https://${pkg.name}.test` : `http://${pkg.name}.test`,
        staging: `https://staging.${pkg.name}.ch`,
        live: `https://${pkg.name}.ch`,
    },
    entry: {
        app: ['core-js/modules/es.array.iterator', './src/js/main.js'],
    },
    output: {
        // [chunkhash]
        filename: '[name].[hash:7].js',
        path: resolve('./web/assets'),
        publicPath: {
            src: useHttps
                ? `https://${ipAddress}:8080/`
                : `http://${ipAddress}:8080/`,
            dist: '/assets/',
        },
    },
    devServer: {
        https: useHttps,
        errorOverlay: true,
        notifyOnErrors: true,
        openBrowser: false,
    },
    htmlWebpackPlugin: {
        main: {
            template: './src/ejs/_layout.ejs',
            filename: `${resolve('./templates/_layouts/')}_layout.twig`,
            title: pkg.name,
        },
    },
    purgeCss: {
        paths: [
            `${resolve('./templates')}/**/*.+(twig|html|blade|js|jade|php|svg)`,
            `${resolve('./src/js')}/**/*.+(vue|js)`,
            `${resolve('./src/ejs')}/**/*.+(ejs)`,
        ],
        extensions: [
            'twig',
            'html',
            'blade',
            'jade',
            'php',
            'vue',
            'js',
            'ejs',
            'svg',
        ],
        whitelist: ['iframe', 'embedded'],
        whitelistPatterns: [
            /plyr/,
            /plyr--/,
            /plyr__/,
            /cc-/,
            /aspect-ratio/,
            /embedded/,
            /flash__message/,
            /glide/,
        ],
        whitelistPatternsChildren: [/embedded$/, /flash__message$/, /glide$/],
    },
    src: {
        js: resolve('./src/js/'),
    },
    workboxPlugin: {
        swDest: 'sw.js',
        clientsClaim: true,
        skipWaiting: true,
        runtimeCaching: [
            {
                urlPattern: '/',
                handler: 'staleWhileRevalidate',
            },
            {
                urlPattern: '/offline',
                handler: 'staleWhileRevalidate',
            },
        ],
        navigateFallbackBlacklist: [/admin/, /shop/, /spenden/],
    },
    miniCssExtractPlugin: {
        filename: '[name].[hash:7].css',
        // chunkFilename: '[name].[hash:7].css',
    },
    contentBase: [
        '*',
        '_components/**/*',
        '_elements/**/*',
        '_macros/**/*',
        '_pieces/**/*',
        'entry/**/*',
        'item/**/*',
        'matrix/**/*',
        'shop/**/*',
    ],
    inlineJs: [
        './node_modules/fg-loadcss/src/cssrelpreload.js',
        './node_modules/fontfaceobserver/fontfaceobserver.js',
        './src/js/inline/tab-handler.js',
        './src/js/inline/load-fonts.js',
        './src/js/inline/service-worker.js',
    ],
    criticalCss: [
        {
            url: '',
            template: 'index',
        },
        {
            url: '/offline',
            template: 'offline',
        },
        {
            url: '/404',
            template: '404',
        },
        {
            url: '/500',
            template: '500',
        },
        {
            url: '/503',
            template: '503',
        },
    ],
};