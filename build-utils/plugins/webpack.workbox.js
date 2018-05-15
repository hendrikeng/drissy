const WorkboxPlugin = require('workbox-webpack-plugin');
const commonConfig = require('./../../build-config/common.config');

module.exports = {
    plugins: [
        new WorkboxPlugin.GenerateSW(commonConfig.workboxPlugin),
    ],
};
