const CompressionWebpackPlugin = require('compression-webpack-plugin');

module.exports = {
    plugins: [
        // Prepare compressed versions of assets to serve them with Content-Encoding
        new CompressionWebpackPlugin({
            asset: '[path].gz[query]',
            algorithm: 'gzip',
            test: /\.(js|html|css)$/,
            treshhold: 10240,
            minRatio: 0.8,
        }),
    ],
};
