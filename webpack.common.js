// node modules
const path = require('path');
const merge = require('webpack-merge');

// webpack plugins
const CopyWebpackPlugin = require('copy-webpack-plugin');
const ManifestPlugin = require('webpack-manifest-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');

// config files
const pkg = require('./package.json');
const settings = require('./webpack.settings.js');

// Configure Babel loader
const configureBabelLoader = browserList => {
    return {
        test: /\.js$/,
        exclude: settings.babelLoaderConfig.exclude,
        use: {
            loader: 'babel-loader',
            options: {
                cacheDirectory: true,
                presets: [
                    [
                        '@babel/preset-env',
                        {
                            modules: false,
                            useBuiltIns: 'usage',
                            corejs: {
                                version: '3.1',
                                proposals: true,
                            },
                            include: [
                                // We need to include ie11 polyfills used by webpack dynamic import
                                // because webpack generated code does not go through babel
                                'es.promise',
                                'es.array.iterator',
                            ],
                            targets: {
                                browsers: browserList,
                            },
                        },
                    ],
                ],
                plugins: [
                    '@babel/plugin-syntax-dynamic-import',
                    [
                        '@babel/transform-runtime',
                        {
                            corejs: 3,
                        },
                    ],
                ],
            },
        },
    };
};

// Configure Entries
const configureEntries = () => {
    const entries = {};
    // eslint-disable-next-line no-restricted-syntax
    for (const [key, value] of Object.entries(settings.entries)) {
        entries[key] = path.resolve(__dirname, settings.paths.src.js + value);
    }

    return entries;
};

// Configure Font loader
const configureFontLoader = () => {
    return {
        test: /\.(ttf|eot|woff2?)$/i,
        use: [
            {
                loader: 'file-loader',
                options: {
                    name: 'fonts/[name].[ext]',
                },
            },
        ],
    };
};

// Configure Manifest
const configureManifest = fileName => {
    return {
        fileName,
        basePath: settings.manifestConfig.basePath,
        map: file => {
            // eslint-disable-next-line no-param-reassign
            file.name = file.name.replace(/(\.[a-f0-9]{32})(\..*)$/, '$2');
            return file;
        },
    };
};

// Configure Vue loader
const configureVueLoader = () => {
    return {
        test: /\.vue$/,
        loader: 'vue-loader',
    };
};

// The base webpack config
const baseConfig = {
    name: pkg.name,
    entry: configureEntries(),
    output: {
        path: path.resolve(__dirname, settings.paths.dist.base),
        publicPath: settings.urls.publicPath(),
    },
    resolve: {
        alias: {
            vue$: 'vue/dist/vue.esm.js',
        },
    },
    module: {
        rules: [configureFontLoader(), configureVueLoader()],
    },
    plugins: [new VueLoaderPlugin()],
};

// Legacy webpack config
const legacyConfig = {
    module: {
        rules: [
            configureBabelLoader(
                Object.values(pkg.browserslist.legacyBrowsers),
            ),
        ],
    },
    plugins: [
        new CopyWebpackPlugin(settings.copyWebpackConfig),
        new ManifestPlugin(configureManifest('manifest-legacy.json')),
    ],
};

// Modern webpack config
const modernConfig = {
    module: {
        rules: [
            configureBabelLoader(
                Object.values(pkg.browserslist.modernBrowsers),
            ),
        ],
    },
    plugins: [new ManifestPlugin(configureManifest('manifest.json'))],
};

// Common module exports
// noinspection WebpackConfigHighlighting
module.exports = {
    legacyConfig: merge.strategy({
        module: 'prepend',
        plugins: 'prepend',
    })(baseConfig, legacyConfig),
    modernConfig: merge.strategy({
        module: 'prepend',
        plugins: 'prepend',
    })(baseConfig, modernConfig),
};
