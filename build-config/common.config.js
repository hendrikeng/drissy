
const path = require('path');

function resolve(dir) {
    return path.join(__dirname, '..', dir);
}

module.exports = {
    urls: {
        dev: 'drissy.test',
        staging: 'https://drissy.test',
        live: 'https://drissy.test',
    },
    entry: {
        'assets/app': './src/js/main.js',
    },
    output: {
        filename: '[name].[hash:7].js',
        path: resolve('./web/'),
        publicPath: {
            src: 'http://localhost:8080/',
            dist: '/',
        },
    },
    devServer: {
        errorOverlay: true,
        notifyOnErrors: true,
        openBrowser: false,
    },
    htmlWebpackPlugin: {
        template: './src/ejs/_layout.ejs',
        filename: `${resolve('./templates/_layouts/')}_layout.twig`,
        title: 'Drissy',
    },
    purgeCss: {
        paths: [
            `${resolve('./templates')}/**/*.+(twig|html|blade|js|jade|php|svg)`,
            `${resolve('./src/js')}/**/*.+(vue|js)`,
            `${resolve('./src/ejs')}/**/*.+(ejs)`,
        ],
        extensions: ['twig', 'html', 'blade', 'jade', 'php', 'vue', 'js', 'ejs', 'svg'],
        whitelist: [],
        whitelistPatterns: [/plyr/, /plyr--/, /plyr__/, /cc-/],
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
                urlPattern: new RegExp('/offline'),
                handler: 'staleWhileRevalidate',
            },
            {
                urlPattern: new RegExp('/'),
                handler: 'staleWhileRevalidate',
            },
        ],
    },
    miniCssExtractPlugin: {
        filename: '[name].[hash:7].css',
        chunkFilename: '[id].[hash:7].css',
    },
    contentBase: ['*', '_components/**/*', '_elements/**/*', '_macros/**/*', '_pieces/**/*', 'entry/**/*', 'item/**/*', 'matrix/**/*'],
    inlineJs: [
        './node_modules/fg-loadcss/src/loadCSS.js',
        './node_modules/fg-loadcss/src/cssrelpreload.js',
        './node_modules/fontfaceobserver/fontfaceobserver.js',
        './src/js/inline/tab-handler.js',
        './src/js/inline/load-fonts.js',
    ],
    criticalCss: [
        {
            url: '',
            template: 'index',
        },
        {
            url: 'offline',
            template: 'offline',
        },
        {
            url: '404',
            template: '404',
        },
        {
            url: 'work',
            template: 'work',
        },
    ],
};
