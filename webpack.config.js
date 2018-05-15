/* eslint-disable no-console, no-shadow, global-require, import/no-dynamic-require */
const webpackCommon = require('./build-utils/webpack.common');
const webpackMerge = require('webpack-merge');

// making use of node --args (--env.plugins=pluginName) to add plugins to be run
const plugins = (pluginsArg) => {
    const plugins = [].concat
        .apply([], [pluginsArg]) // Normalize array of plugins (flatten)
        .filter(Boolean); // If plugins is undefined, filter it out
    return plugins.map(pluginName => require(`./build-utils/plugins/webpack.${pluginName}.js`));
};

// export as a function to enable env based settings
module.exports = function mainConfig(env) {
    const envConfig = require(`./build-utils/webpack.${env.env}.js`);
    const mergedConfig = webpackMerge(webpackCommon, envConfig, ...plugins(env.plugins));
    return mergedConfig;
};
