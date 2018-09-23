/* eslint-disable no-console */

const critical = require('critical');

// save options passed from plugin
// https://developer.mozilla.org/de/docs/Web/JavaScript/Reference/Functions/rest_parameter
const passedOptions = {};

function SyncCriticalWebpackPlugin(options) {
    this.options = options;

    Object.assign(passedOptions, options);
}

// hier ist der wurm
// function processArray(items, createCriticalCSS) {
//     return items.reduce(
//         (promise, item) => promise.then(() => createCriticalCSS(item)),
//         Promise.resolve(),
//     );
// }

function processArray(array, createCriticalCSS) {
    console.log(array);
    const promises = array.map(createCriticalCSS);
    // console.log(promises);

    Promise.all(promises)
        .then(() => {
            console.log(createCriticalCSS);
            console.log('Processed critical CSS!');
        })
        .catch(e =>
            console.error(`processing failed: ${e.name}: ${e.message}`),
        );
}

// create critical css for each single source  ...hier wohl sync rein
const createCriticalCSS = (element, i) => {
    const options = {
        base: passedOptions.base,
        src: passedOptions.srcPrefix + passedOptions.src[i],
        dest: passedOptions.dest[i] + passedOptions.destExt,
    };
    console.log(element);
    console.log(`Extracting... -> ${options.src}`);

    critical
        .generate(options)
        .then(() => {
            console.log(element);
            console.log(`Generating... -> ${options.dest}`);
        })
        .catch(e => console.error(`critical failed: ${e.name}: ${e.message}`));
};

// process array of sources
SyncCriticalWebpackPlugin.prototype.emit = () => {
    // only pass arrays to process
    passedOptions.src =
        passedOptions.src instanceof Array
            ? passedOptions.src
            : [passedOptions.dest];

    passedOptions.dest =
        passedOptions.dest instanceof Array
            ? passedOptions.dest
            : [passedOptions.dest];

    processArray(passedOptions.src, createCriticalCSS);
};

// run plugin only after webpack emited all files
SyncCriticalWebpackPlugin.prototype.apply = function waitForAfterEmit(
    compiler,
) {
    const self = this;
    compiler.plugin('after-emit', (compilation, callback) => {
        self.emit(compilation, callback);
    });
};

module.exports = SyncCriticalWebpackPlugin;
