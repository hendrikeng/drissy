/* eslint-disable global-require,prettier/prettier */
module.exports = {
    theme: {
        extend: {
            colors: {},
        },
        screens: {
            'xs': '400px',
            'sm': '640px',
            'md': '768px',
            'lg': '1024px',
            'xl': '1280px',
        },
        aspectRatio: {
            '1/1': [1, 1],
            '16/9': [16, 9],
            '4/3': [4, 3],
            '4/5': [4, 5],
            '21/9': [21, 9],
        },
        fontSize: {
            xs: '0.75rem', // 12px
            sm: '0.875rem', // 14px
            base: '1rem', // 16px
            lg: '1.125rem', // 18px
            xl: '1.25rem', // 20px
            '2xl': '1.5rem', // 24px
            '3xl': '1.875rem', // 30px
            '4xl': '2.25rem', // 36px
            '5xl': '3rem', // 48px
            '6xl': '4rem', // 64 px
        },
        spacing: {
            px: '1px',
            '0': '0',
            '1': '0.25rem',
            '2': '0.5rem',
            '3': '0.75rem',
            '4': '1rem',
            '5': '1.25rem',
            '6': '1.5rem',
            '8': '2rem',
            '10': '2.5rem',
            '12': '3rem',
            '16': '4rem',
            '20': '5rem',
            '24': '6rem',
            '32': '8rem',
            '40': '10rem',
            '48': '12rem',
            '56': '14rem',
            '64': '16rem',
        },
        rotate: { // defaults to {}
            '90': '90deg',
            '180': '180deg',
            '270': '270deg',
            '3d': ['0', '1', '0.5', '45deg'],
        },
    },
    variants: {
        aspectRatio: ['responsive'],
        order: ['responsive'],
    },
    plugins: [
        require('tailwindcss-aspect-ratio')(),
        // require('tailwindcss-grid')({
        //     grids: [2, 3, 5, 6, 8, 10, 12],
        //     gaps: {
        //         0: '0',
        //         4: '1rem',
        //         8: '2rem',
        //         '4-x': '1rem',
        //         '4-y': '1rem',
        //     },
        //     autoMinWidths: {
        //         '16': '4rem',
        //         '24': '6rem',
        //         '300px': '300px',
        //     },
        //     variants: ['responsive'],
        // }),
        require('tailwindcss-fluid')({
            textSizes: {}
        }),
        require('tailwindcss-transforms')({
            '3d': false, // defaults to false
        }),
    ],
};
