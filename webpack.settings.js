// webpack.settings.js - webpack settings config

// node modules
require('dotenv').config();
const Terser = require('terser');
const Postcss = require('postcss');
const Cssnano = require('cssnano');

// Webpack settings exports
// noinspection WebpackConfigHighlighting
module.exports = {
    name: 'Example Project',
    copyright: 'Example Company, Inc.',
    paths: {
        src: {
            base: './src/',
            css: './src/css/',
            js: './src/js/',
        },
        dist: {
            base: './web/dist/',
            clean: ['**/*'],
        },
        templates: './templates/',
    },
    urls: {
        live: 'https://example.com/',
        local: 'http://example.test/',
        critical: 'http://example.test/',
        publicPath: () => process.env.PUBLIC_PATH || '/dist/',
    },
    vars: {
        cssName: 'styles',
    },
    entries: {
        app: 'app.js',
    },
    babelLoaderConfig: {
        exclude: [/(node_modules|bower_components)/],
    },
    copyWebpackConfig: [
        {
            from: './src/js/workbox-catch-handler.js',
            to: 'js/[name].[ext]',
        },
        // copy fontfaceobsever from node modules
        {
            from: './node_modules/fontfaceobserver/fontfaceobserver.js',
            to: 'js/[name].[ext]',
            transform: function(content, path) {
                return content;
            },
        },
        // copy and minify inlineJs
        {
            from: './src/inlineJs/load-fonts.js',
            to: 'js/[name].[ext]',
            transform: function(content, path) {
                return Terser.minify(content.toString()).code;
            },
        },
        // copy and minify inlineJs
        {
            from: './src/inlineJs/tab-handler.js',
            to: 'js/[name].[ext]',
            transform: function(content, path) {
                return Terser.minify(content.toString()).code;
            },
        },
        // copy and minify webfonts css
        {
            from: './src/css/components/webfonts.pcss',
            to: 'css/[name].css',
            transform: function(content, path) {
                return Postcss([Cssnano])
                    .process(content.toString())
                    .then(result => {
                        return result.css;
                    });
            },
        },
    ],
    criticalCssConfig: {
        base: './web/dist/criticalcss/',
        suffix: '_critical.min.css',
        criticalHeight: 1200,
        criticalWidth: 1200,
        ampPrefix: 'amp_',
        ampCriticalHeight: 19200,
        ampCriticalWidth: 600,
        pages: [
            {
                url: '',
                template: 'index',
            },
        ],
    },
    devServerConfig: {
        public: () => process.env.DEVSERVER_PUBLIC || 'http://localhost:8080',
        host: () => process.env.DEVSERVER_HOST || 'localhost',
        poll: () => process.env.DEVSERVER_POLL || false,
        port: () => process.env.DEVSERVER_PORT || 8080,
        https: () => process.env.DEVSERVER_HTTPS || false,
    },
    manifestConfig: {
        basePath: '',
    },
    purgeCssConfig: {
        paths: ['./templates/**/*.{twig,html}', './src/vue/**/*.{vue,html}'],
        whitelist: ['./src/css/components/**/*.{css}'],
        whitelistPatterns: [],
        extensions: ['html', 'js', 'twig', 'vue'],
    },
    saveRemoteFileConfig: [
        {
            url: 'https://www.google-analytics.com/analytics.js',
            filepath: 'js/analytics.js',
        },
    ],
    createSymlinkConfig: [
        {
            origin: 'img/favicons/favicon.ico',
            symlink: '../favicon.ico',
        },
    ],
    webappConfig: {
        logo: './src/img/favicon-src.png',
        prefix: 'img/favicons/',
    },
    workboxConfig: {
        swDest: '../sw.js',
        precacheManifestFilename: 'js/precache-manifest.[manifestHash].js',
        importScripts: ['/dist/workbox-catch-handler.js'],
        exclude: [
            /\.(png|jpe?g|gif|svg|webp)$/i,
            /\.map$/,
            /^manifest.*\\.js(?:on)?$/,
        ],
        globDirectory: './web/',
        globPatterns: [
            'offline.twig',
            // "offline.svg"
        ],
        offlineGoogleAnalytics: true,
        runtimeCaching: [
            {
                urlPattern: /\.(?:png|jpg|jpeg|svg|webp)$/,
                handler: 'cacheFirst',
                options: {
                    cacheName: 'images',
                    expiration: {
                        maxEntries: 20,
                    },
                },
            },
        ],
    },
};