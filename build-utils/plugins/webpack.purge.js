const commonConfig = require('./../../build-config/common.config');
const glob = require('glob-all');
const PurgecssPlugin = require('purgecss-webpack-plugin');

class TailwindExtractor {
    static extract(content) {
        // eslint-disable-next-line
        return content.match(/[A-z0-9-:\/]+/g) || [];
    }
}

module.exports = {
    plugins: [
        new PurgecssPlugin({
            extractor: TailwindExtractor,
            paths: glob.sync(commonConfig.purgeCss.paths),
            extractors: [{
                extractor: TailwindExtractor,
                extensions: commonConfig.purgeCss.extensions,
            }],
            whitelist: commonConfig.purgeCss.whitelist,
            whitelistPatterns: commonConfig.purgeCss.whitelistPatterns
        }),
    ],
};
