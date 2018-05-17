/* eslint-disable global-require */

module.exports = {
    plugins: [
        require('postcss-import')(),
        require('tailwindcss')('./build-config/tailwind.config.js'),
        require('postcss-fixes'),
        require('postcss-cssnext'),
    ],
};
