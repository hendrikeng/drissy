/**
 * Lazysizes
 */
import 'lazysizes';
import 'lazysizes/plugins/respimg/ls.respimg.js';
import 'lazysizes/plugins/parent-fit/ls.parent-fit.js';
import 'lazysizes/plugins/blur-up/ls.blur-up';
import 'lazysizes/plugins/object-fit/ls.object-fit.js';

// import 'lazysizes/plugins/bgset/ls.bgset.js';

/**
 * Css
 */
import 'typeface-roboto-condensed';
import 'typeface-cabin';
import '../css/styles.css';

/**
 * Vue
 */
import Vue from 'vue';
// import axios from 'axios';
// import qs from 'qs';
// import VeeValidate, { Validator } from 'vee-validate';
// import de from 'vee-validate/dist/locale/de';
// import store from './store';

/**
 * Helpers
 */
// import getUrlParameter from './helpers/getUrlParameter.js';
// import setAttributes from './helpers/setAttributes.js';

/**
 * Serviceworker
 */
if (process.env.NODE_ENV === 'production') {
    if ('serviceWorker' in navigator) {
        window.addEventListener('load', () => {
            navigator.serviceWorker
                .register('/sw.js')
                .then(registration => {
                    console.log('SW registered: ', registration);
                })
                .catch(registrationError => {
                    console.log('SW registration failed: ', registrationError);
                });
        });
    }
}

/**
 * Vee Validate
 * @type {{classes: boolean, classNames: {touched: string, untouched: string, valid: string, invalid: string, pristine: string, dirty: string}, locale: string}}
 */

// const config = {
//     classes: true,
//     classNames: {
//         touched: '', // the control has been blurred
//         untouched: 'border-grey-lighter', // the control hasn't been blurred
//         valid: 'bg-green-lightest', // model is valid
//         invalid: 'bg-red-lightest', // model is not valid
//         pristine: '', // control has not been interacted with
//         dirty: '', // control has been interacted with
//     },
//     locale: 'de',
// };
//
// Validator.localize({ de });
// Vue.use(VeeValidate, config);

/**
 * Vue
 */
new Vue({
    delimiters: ['${', '}'],
    el: '#app',
    data: () => ({}),
    methods: {
        // Pre-render pages when the user mouses over a link
        // Usage: <a href="" @mouseover="prerenderLink">
        prerenderLink(e) {
            console.log(`prerendering${e}`);
            const head = document.getElementsByTagName('head')[0];
            const refs = head.childNodes;
            const ref = refs[refs.length - 1];
            const elements = head.getElementsByTagName('link');
            Array.prototype.forEach.call(elements, el => {
                if ('rel' in el && el.rel === 'prerender')
                    el.parentNode.removeChild(el);
            });
            const prerenderTag = document.createElement('link');
            prerenderTag.rel = 'prerender';
            prerenderTag.href = e.currentTarget.href;
            ref.parentNode.insertBefore(prerenderTag, ref);
        },
        // validateForm(scope) {
        //     console.log(`validating ${scope}`);
        //     this.$validator.validateAll(scope).then(result => {
        //         if (result) {
        //             const el = document.getElementById(scope);
        //             el.submit();
        //         }
        //     });
        // },
    },
    created() {},
});

/**
 * Domready
 */
const interval = setInterval(() => {
    if (document.readyState === 'complete') {
        clearInterval(interval);

        /**
         * write DOMContentLoaded status to body
         * when Dom is fully loaded
         */
        document.querySelector('body').classList.add('is-complete');

        /**
         * Cookie warning
         */
        // import(/* webpackChunkName: "cookieconsent" */ './modules/cookie.js');

        /**
         * Slider
         */
        if (document.getElementsByClassName('js-slider').length) {
            import(/* webpackChunkName: "slider" */ './modules/glide.js')
                .then(glide => glide.slider.init())
                .catch(e => console.error(`${e.name} : ${e.message}`));
        }

        /**
         * Carousel
         */
        if (document.getElementsByClassName('js-carousel').length) {
            import(/* webpackChunkName: "glide" */ './modules/glide.js')
                .then(glide => glide.carousel.init())
                .catch(e => console.error(`${e.name} : ${e.message}`));
        }

        /**
         * Image Gallery
         */
        if (document.getElementsByClassName('js-gallery').length) {
            console.log('selector found');
            import(/* webpackChunkName: "photoswipe" */ './modules/photoswipe.js')
                .then(photoswipe => photoswipe.default.init('.js-gallery'))
                .catch(e => console.error(`${e.name} : ${e.message}`));
        }
    }
}, 100);

// log to console if in DEV mode and accept HMR
if (process.env.NODE_ENV !== 'production') {
    // eslint-disable-next-line
    console.log('%c DEV MODE ', 'background: red; color: black');

    // Enable HMR
    if (module.hot) {
        module.hot.accept();
    }
}
