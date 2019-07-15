import Vue from 'vue';

const debug = new Vue({
    name: 'debug',
    el: '#debug',
    methods: {
        openDebug() {
            this.$refs.debugMode.classList.toggle('hidden');
        },
    },
});

export default debug;