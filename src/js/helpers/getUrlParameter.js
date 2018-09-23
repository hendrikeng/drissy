/* global event */
/* eslint no-restricted-globals: ["error", "event"] */

function getUrlParameter(name) {
    const string = name.replace(/[[]/, '\\[').replace(/[\]]/, '\\]');
    const regex = new RegExp(`[?&]${string}=([^&#]*)`);
    const results = regex.exec(location.search);
    return results === null
        ? ''
        : decodeURIComponent(results[1].replace(/\+/g, ' '));
}

export default getUrlParameter;
