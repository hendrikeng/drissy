<?php
/**
 * Asset Volume Configuration
 *
 * All of your system's volume configuration settings go in here.
 * Put the Asset Volume handle in `ASSET_HANDLE` key, and put the path
 * to the asset directory in `ASSET_PATH`. Create an array for each Asset
 * Volume your website uses.
 *
 * You must create each Asset Volume in the AdminCP first, and then override
 * the settings here.
 */

return [

    // All environments
    '*' => [
        'siteImages' => [
            'path' => '@webroot/uploads/images',
            'url' => '@web/assets/images',
        ],
        'siteMedia' => [
            'path' => '@webroot/uploads/media',
            'url' => '@web/assets/media',
        ],
        'siteUsers' => [
            'path' => '@webroot/uploads/users',
            'url' => '@web/assets/users',
        ],
        'siteDownloads' => [
            'path' => '@webroot/uploads/downloads',
            'url' => '@web/assets/downloads',
        ],
    ],

    // Live (production) environment
    'live'  => [
    ],

    // Staging (pre-production) environment
    'staging'  => [
    ],

    // Dev (development) environment
    'dev'  => [
    ],
];
