const FaviconsWebpackPlugin = require('favicons-webpack-plugin');
const commonConfig = require('./../../build-config/common.config');

module.exports = {
    plugins: [
        new FaviconsWebpackPlugin({
            // Your source logo
            logo: './src/images/favicon/logo.png',
            // The prefix for all image files (might be a folder or a name)
            prefix: '/',
            // Emit all stats of the generated icons
            emitStats: false,
            // Generate a cache file with control hashes and
            // don't rebuild the favicons until those hashes change
            persistentCache: false,
            // Inject the html into the html-webpack-plugin
            inject: false,
            // favicon background color (see https://github.com/haydenbleasel/favicons#usage)
            background: '#fff',
            theme_color: '#fff',
            manifest: true,
            start_url: commonConfig.urls.staging,
            // which icons should be generated (see https://github.com/haydenbleasel/favicons#usage)
            icons: {
                android: true, // Create Android homescreen icon. `boolean`
                appleIcon: true, // Create Apple touch icons. `boolean`
                appleStartup: false, // Create Apple startup images. `boolean`
                coast: true, // Create Opera Coast icon. `boolean`
                favicons: true, // Create regular favicons. `boolean`
                firefox: true, // Create Firefox OS icons. `boolean`
                opengraph: false, // Create Facebook OpenGraph image. `boolean`
                twitter: false, // Create Twitter Summary Card image. `boolean`
                windows: true, // Create Windows 8 tile icons. `boolean`
                yandex: true, // Create Yandex browser icon. `boolean`
            },
        }),
    ],
};
