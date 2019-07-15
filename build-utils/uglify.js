// TODO: https://github.com/babel/minify
const fs = require('fs');
const UglifyJS = require('uglify-js');
const commonConfig = require('./../build-config/common.config');

commonConfig.inlineJs.forEach(file => {
    // eslint-disable-next-line
    const newFilePath = `./templates/_inlinejs/${file.replace(/^.*[\\\/]/, '')}`;
    // eslint-disable-next-line
    console.log('Uglyfing -> ' + file +  ' -> ' + newFilePath);
    fs.writeFileSync(
        newFilePath,
        UglifyJS.minify(fs.readFileSync(file, 'utf8'), {
            mangle: {
                properties: false,
            },
        }).code,
        'utf8',
    );
});