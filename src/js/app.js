import 'core-js/stable';
import 'regenerator-runtime/runtime';

import '../css/app.pcss';

import 'typeface-roboto-condensed';
import 'typeface-cabin';

// App main
const main = async () => {
    // Async load the vue module
    const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue');
    // Async load LazySizes and it's plugins
    const LazySizes = await import(
        /* webpackChunkName: "LazySizes" */ 'lazysizes'
    );
    await import(
        /* webpackChunkName: "LazySizes" */ 'lazysizes/plugins/respimg/ls.respimg.js'
    );
    await import(
        /* webpackChunkName: "LazySizes" */ 'lazysizes/plugins/object-fit/ls.object-fit.js'
    );
    LazySizes.init();
    // Create our vue instance
    new Vue({
        el: '#app',
        delimiters: ['${', '}'],
        components: {},
        data: {},
        methods: {
            // Pre-render pages when the user mouses over a link
            // Usage: <a href="" @mouseover="prerenderLink">
            prerenderLink(e) {
                const head = document.getElementsByTagName('head')[0];
                const refs = head.childNodes;
                const ref = refs[refs.length - 1];

                const elements = head.getElementsByTagName('link');
                // eslint-disable-next-line func-names,no-unused-vars
                Array.prototype.forEach.call(elements, function(el, i) {
                    if ('rel' in el && el.rel === 'prerender') {
                        el.parentNode.removeChild(el);
                    }
                });

                const prerenderTag = document.createElement('link');
                prerenderTag.rel = 'prerender';
                prerenderTag.href = e.currentTarget.href;
                ref.parentNode.insertBefore(prerenderTag, ref);
            },
        },
        mounted() {},
    });

    // load slider async
    if (document.getElementsByClassName('js-slider').length) {
        await import(/* webpackChunkName: "glide" */ './modules/glide.js')
            .then(glide => glide.slider.init())
            .catch(e => console.error(`${e.name} : ${e.message}`));
    }

    // load slider async
    if (document.getElementsByClassName('js-carousel').length) {
        await import(/* webpackChunkName: "glide" */ './modules/glide.js')
            .then(glide => glide.carousel.init())
            .catch(e => console.error(`${e.name} : ${e.message}`));
    }
};

// Execute async function
main().then(() => {
    console.log('loaded');
});

// accept HMR in dev
if (process.env.NODE_ENV !== 'production') {
    if (module.hot) {
        module.hot.accept();
    }
    import(/* webpackChunkName: "debug" */ '../vue/debug');
}
