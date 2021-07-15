import App from '@/vue/App.vue';
import { createApp } from 'vue';

// App main
const main = async () => {
    // Async load the Vue 3 APIs we need from the Vue ESM
    // Create our vue instance
    const app = createApp(App);

    // Mount the app
    return app.mount('#app');
};

// Execute async function
main().then( (root) => {
    const alpine = document.querySelectorAll('[x-data]');
    if (alpine.length) {
        // As long we do not use alpine.js we disable this library to improve site performance
        import(/* webpackChunkName: "alpineJs" */ 'alpinejs');
    }
});

// Accept HMR as per: https://webpack.js.org/api/hot-module-replacement#accept
if (module.hot) {
    module.hot.accept();
}
