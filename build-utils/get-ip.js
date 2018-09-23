const ifaces = require('os').networkInterfaces();

let ipAddress;

(function getIp() {
    Object.keys(ifaces).forEach(dev => {
        ifaces[dev].filter(details => {
            if (details.family === 'IPv4' && details.internal === false) {
                ipAddress = details.address;
            }
            return ipAddress;
        });
    });
})();

module.exports = ipAddress;
