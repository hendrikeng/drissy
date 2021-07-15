module.exports = {
    mode: 'jit',
    purge: {
        content: [
            './templates/**/*.{twig,html}',
            './src/vue/**/*.{vue,html}',
        ],
        layers: [
            'base',
            'components',
            'utilities',
        ],
        mode: 'layers',
        options: {
            whitelist: [
                './src/css/components/**/*.{css}',
            ],
        }
    },
    theme: {
        extend: {
            aspectRatio: {
                none: 0,
                '1/1': [1, 1],
                '16/9': [16, 9],
                '4/3': [4, 3],
                '3/4': [3, 4],
            },
        },
    },
    variants: {
        extend: {},
    },
    plugins: [],
    corePlugins: {},
};
