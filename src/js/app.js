/**
 * Lazysizes
 */
import 'lazysizes';
import 'lazysizes/plugins/respimg/ls.respimg.js';
import 'lazysizes/plugins/parent-fit/ls.parent-fit.js';
import 'lazysizes/plugins/blur-up/ls.blur-up';
import 'lazysizes/plugins/object-fit/ls.object-fit.js';

// Import our CSS
import styles from '../css/app.pcss';

// import our fonts
import 'typeface-roboto-condensed';
import 'typeface-cabin';

// App main
const main = async () => {
    // Async load the vue module
    const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue');
    // Create our vue instance
    const vm = new Vue({
        el: '#app',
        components: {
            //     confetti: () =>
            //       import(
            //         /* webpackChunkName: "confetti" */ '../vue/Confetti.vue'
            //   ),
        },
        data: {},
        methods: {},
        mounted() {},
    });
    // load slider async
    if (document.getElementsByClassName('js-slider').length) {
        await import(/* webpackChunkName: "slider" */ './modules/glide.js')
            .then(glide => glide.slider.init())
            .catch(e => console.error(`${e.name} : ${e.message}`));
    }

    // load slider async
    if (document.getElementsByClassName('js-carousel').length) {
        await import(/* webpackChunkName: "glide" */ './modules/glide.js')
            .then(glide => glide.carousel.init())
            .catch(e => console.error(`${e.name} : ${e.message}`));
    }

    return vm;
};

// Execute async function
main().then(vm => {});

// accept HMR in dev
if (process.env.NODE_ENV !== 'production') {
    if (module.hot) {
        module.hot.accept();
    }
    import(/* webpackChunkName: "debug" */ './../vue/debug');
}
