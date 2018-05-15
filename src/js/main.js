import 'lazysizes';
import 'lazysizes/plugins/respimg/ls.respimg.js';
// import 'lazysizes/plugins/object-fit/ls.object-fit.js';
// import 'lazysizes/plugins/bgset/ls.bgset.js';
// import 'lazysizes/plugins/parent-fit/ls.parent-fit.js';
// import Vue from 'vue';
// import App from './App.vue';
import 'typeface-lato';

import './../css/styles.css';

/* eslint-disable no-new */
// new Vue({
//     el: '#app',
//     ...App,
// });

// log to console if in DEV mode and accept HMR
if (process.env.NODE_ENV !== 'production') {
    // eslint-disable-next-line
    console.log('%c DEV MODE ', 'background: red; color: black');

    // Enable HMR
    if (module.hot) {
        module.hot.accept();
    }
}

if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker
            .register('/sw.js')
            .then((registration) => {
                // eslint-disable-next-line
                console.log('SW registered: ', registration);
            })
            .catch((registrationError) => {
                // eslint-disable-next-line
                console.log('SW registration failed: ', registrationError);
            });
    });
}


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

    }
}, 100);
