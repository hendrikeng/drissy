module.exports = {
    cacheDirectory: true,
    presets: [
        [
            '@babel/preset-env', {
                modules: false,
                corejs:  {
                    version: 3,
                    proposals: true
                },
                useBuiltIns: 'usage',
                targets: {
                    browsers: browserList,
                },
            }
        ],
    ],
    plugins: [
        '@babel/plugin-syntax-dynamic-import',
        '@babel/plugin-transform-runtime',
    ],
};
