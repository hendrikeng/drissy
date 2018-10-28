module.exports = {
    plugins: [
        require('postcss-import'),
        require('postcss-extend'),
        require('postcss-simple-vars'),
        require('postcss-nested-ancestors'),
        require('postcss-nested'),
        require('postcss-hexrgba'),
        require('tailwindcss')('./build-config/tailwind.config.js'),
        require('postcss-fixes'),
        require('postcss-preset-env'),
    ]
};
