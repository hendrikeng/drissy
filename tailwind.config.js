module.exports = {
    theme: {
        aspectRatio: {
            '1/1': [1, 1],
            '16/9': [16, 9],
            '4/3': [4, 3],
            '4/5': [4, 5],
            '21/9': [21, 9],
            auto: [1, 1],
        },
    },
    variants: {
        aspectRatio: ['responsive'],
    },
    // eslint-disable-next-line global-require
    plugins: [require('tailwindcss-aspect-ratio')()],
};
