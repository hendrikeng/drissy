const HardSourceWebpackPlugin = require('hard-source-webpack-plugin');

module.exports = {
    plugins: [
        new HardSourceWebpackPlugin({
            cacheDirectory:
                './../../node_modules/.cache/hard-source/[confighash]',
        }),
    ],
};
