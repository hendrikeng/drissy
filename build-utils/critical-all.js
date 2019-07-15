const critical = require('critical');
const fs = require('fs');
const commonConfig = require('./../build-config/common.config');

const json = JSON.parse(fs.readFileSync('compilation-stats.json'));
const assetLink = [`web/assets/${json.assetsByChunkName.styles[0]}`];
const source = assetLink.toString();
// eslint-disable-next-line
console.log(`\nGenerating critical CSS from:\n${source}:\n`);
// eslint-disable-next-line
console.log(fs.readFileSync(source) + '\n');
// https://futurestud.io/tutorials/node-js-how-to-run-an-asynchronous-function-in-array-map
// Process data in an array synchronously, moving onto the n+1 item only after the nth item callback
const doSynchronousLoop = (data, processData, done) => {
    if (data.length > 0) {
        // eslint-disable-next-line
        const loop = (data, i, processData, done) => {
            processData(data[i], i, () => {
                // eslint-disable-next-line
                if (++i < data.length) {
                    loop(data, i, processData, done);
                } else {
                    done();
                }
            });
        };
        loop(data, 0, processData, done);
    } else {
        done();
    }
};

const createCriticalCSS = (element, i, callback) => {
    const url = commonConfig.urls.staging;
    const criticalSrc = url + element.url;
    const BASE_PATH = './templates/';
    const criticalDest = `${`${BASE_PATH}${
        element.template
        }`}_critical.min.css`;
    // eslint-disable-next-line
    console.log(
        `-> Generating critical CSS:\n${criticalSrc} -> ${criticalDest}`,
    );

    critical
        .generate({
            src: criticalSrc,
            dest: criticalDest,
            css: assetLink,
            inline: false,
            ignore: [],
            minify: true,
            width: 1200,
            height: 1200,
            extract: false,
            penthouse: {
                blockJSRequests: false,
                strict: true,
            },
        })
        // eslint-disable-next-line
        .then(output => {
            // eslint-disable-next-line
            console.log(
                `-> Critical CSS generated: ${
                    element.template
                    }_critical.min.css \n`,
            );
            // eslint-disable-next-line
            console.log(output + '\n');
            callback();
        })
        .error(err => {
            // eslint-disable-next-line
            console.log(`-> Something went wrong ${err}`);
        });
};

doSynchronousLoop(commonConfig.criticalCss, createCriticalCSS, () => {
    // eslint-disable-next-line
    console.log('Done!');
});