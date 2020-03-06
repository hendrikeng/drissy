// node modules
const merge = require('webpack-merge');
const path = require('path');
const webpack = require('webpack');

// config files
const common = require('./webpack.common.js');
const settings = require('./webpack.settings.js');

// Configure the webpack-dev-server
// eslint-disable-next-line no-unused-vars
const configureDevServer = () => {
    return {
        public: settings.devServerConfig.public(),
        contentBase: path.resolve(__dirname, settings.paths.templates),
        host: settings.devServerConfig.host(),
        port: settings.devServerConfig.port(),
        https: !!parseInt(settings.devServerConfig.https(), 10),
        disableHostCheck: true,
        hot: true,
        overlay: true,
        watchContentBase: true,
        watchOptions: {
            poll: !!parseInt(settings.devServerConfig.poll(), 10),
            ignored: /node_modules/,
        },
        headers: {
            'Access-Control-Allow-Origin': '*',
        },
    };
};

// Configure Image loader
const configureImageLoader = () => {
    return {
        test: /\.(png|jpe?g|gif|svg|webp)$/i,
        use: [
            {
                loader: 'file-loader',
                options: {
                    name: 'img/[name].[hash].[ext]',
                },
            },
        ],
    };
};

// Configure the Postcss loader
// eslint-disable-next-line consistent-return
const configurePostcssLoader = () => {
    return {
        test: /\.(pcss|css)$/,
        use: [
            {
                loader: 'style-loader',
            },
            {
                loader: 'vue-style-loader',
            },
            {
                loader: 'css-loader',
                options: {
                    importLoaders: 2,
                    sourceMap: true,
                },
            },
            {
                loader: 'resolve-url-loader',
            },
            {
                loader: 'postcss-loader',
                options: {
                    sourceMap: true,
                },
            },
        ],
    };
};

// Development module exports
module.exports = [
    merge(common.modernConfig, {
        output: {
            filename: path.join('./js', '[name].[hash].js'),
            publicPath: `${settings.devServerConfig.public()}/`,
        },
        mode: 'development',
        devtool: 'inline-source-map',
        devServer: configureDevServer(),
        module: {
            rules: [configurePostcssLoader(), configureImageLoader()],
        },
        plugins: [new webpack.HotModuleReplacementPlugin()],
    }),
];
