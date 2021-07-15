


import scrollama from 'scrollama';

const changeColor = document.querySelectorAll('.js-changeColor');

// instantiate the scrollama
const scroller = scrollama();

// setup the instance, pass callback functions
scroller
    .setup({
        step: '.js-sectionColor',
        debug: false,
        offset: '70px',
    })
    .onStepEnter(response => {
        changeColor.forEach(element => {
            if (response.element.style.color === 'rgb(255, 255, 255)') {
                element.classList.add('isWhite');
            } else {
                element.classList.remove('isWhite');
            }
        });
    });

// setup resize event
window.addEventListener('resize', scroller.resize);

/**
 * Bugglyfill mobile safari navbar-hacks
 */
const hacks = require('viewport-units-buggyfill/viewport-units-buggyfill.hacks');
require('viewport-units-buggyfill').init({
    hacks,
});

// App main
const main = async () => {
    // Async load LazySizes and it's plugins
    const LazySizes = await import(
        /* webpackChunkName: "LazySizes" */ 'lazysizes'
    );
    await import(
        /* webpackChunkName: "LazySizes" */ 'lazysizes/plugins/respimg/ls.respimg.js'
    );
    await import(
        /* webpackChunkName: "LazySizes" */ 'lazysizes/plugins/parent-fit/ls.parent-fit.js'
    );
    await import(
        /* webpackChunkName: "LazySizes" */ 'lazysizes/plugins/object-fit/ls.object-fit.js'
    );
    // fix issue when image is already in viewport and content is not loaded yet
    document.addEventListener('DOMContentLoaded', function () {
        LazySizes.init();
    });
};

// Execute async function
main().then(() => {
    const alpine = document.querySelectorAll('[x-data]');
    if (alpine.length) {
        // As long we do not use alpine.js we disable this library to improve site performance
        import(/* webpackChunkName: "alpineJs" */ 'alpinejs');
    }
});

// accept HMR in dev
if (process.env.NODE_ENV !== 'production') {
    if (module.hot) {
        module.hot.accept();
    }
    // eslint-disable-next-line no-unused-expressions
    // import(/* webpackChunkName: "debug" */ '../vue/debug');
}
