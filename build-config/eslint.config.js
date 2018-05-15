module.exports = {
    parser: 'vue-eslint-parser',
    parserOptions: {
        parser: 'babel-eslint',
        sourceType: 'module',
        allowImportExportEverywhere: false,
    },
    extends: ['airbnb', 'plugin:vue/essential'],
    settings: {
        'import/resolver': {
            webpack: {
                config: './webpack.config.js',
            },
        },
    },
    globals: {
        __DEV__: true,
    },
    env: {
        browser: true,
    },
    rules: {
        'generator-star-spacing': 'off',
        'import/extensions': 'off',
        'import/no-extraneous-dependencies': 'off',
        'react/forbid-prop-types': 'off',
        'react/jsx-filename-extension': 'off',
        'react/no-danger': 'off',
        'react/no-unused-prop-types': 'off',
        'react/prefer-stateless-function': 'off',
        'no-console': 2,
        'linebreak-style': 'off',
        'padded-blocks': 'off',
        'jsx-a11y/href-no-hash': 'off',
        'jsx-a11y/anchor-is-valid': ['warn', { aspects: ['invalidHref'] }],
        indent: ['error', 4],
    },
    overrides: [
        {
            files: ['*.vue'],
            rules: {
                indent: 'off',
                'vue/script-indent': ['error', 2, { baseIndent: 0 }],
            },
        },
    ],
};
