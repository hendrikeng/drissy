module.exports = {
    presets: [
        [
            '@babel/preset-env',
            {
                modules: false,
                useBuiltIns: 'usage',
                debug: false,
            },
        ],
    ],
    plugins: ['syntax-dynamic-import', 'syntax-object-rest-spread'],
};
