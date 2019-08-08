<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */

return [
    // Global settings
    '*' => [
        // Default Week Start Day (0 = Sunday, 1 = Monday...)
        'defaultWeekStartDay' => 1,
        //
        'cacheDuration' => false,
        //
        'defaultSearchTermOptions' => array(
            'subLeft' => true,
            'subRight' => true,
        ),
        'convertFilenamesToAscii' => true,
        'limitAutoSlugsToAscii' => true,
        'sendPoweredByHeader' => false,
        //
        'enableCsrfProtection' => true,
        //
        'generateTransformsBeforePageLoad' => true,
        // Whether generated URLs should omit "index.php"
        'omitScriptNameInUrls' => true,

        // Control Panel trigger word
        'cpTrigger' => getenv('CP_TRIGGER') ?: 'admin',

        // The secure key Craft will use for hashing and encrypting data
        'securityKey' => getenv('SECURITY_KEY'),
        //
        'useEmailAsUsername' => true,
        //
        'usePathInfo' => true,
        // Whether to save the project config out to config/project.yaml
        // (see https://docs.craftcms.com/v3/project-config.html)
        'useProjectConfigFile' => true,
        // Aliases
        'aliases' => [
            '@web'    => getenv('DEFAULT_SITE_URL'),
            '@webroot' => dirname(__DIR__) . '/web',
        ],
    ],

    // Dev environment settings
    'dev' => [
        // Dev Mode (see https://craftcms.com/guides/what-dev-mode-does)
        'devMode' => true,
        //
        'allowUpdates' => true,
        //
        'backupOnUpdate' => true,
        //
        'enableTemplateCaching' => false,
        //
        'isSystemOn' => true,
    ],

    // Staging environment settings
    'staging' => [
        //
        'allowUpdates' => false,
        //
        'backupOnUpdate' => false,
        //
        'devMode' => false,
        //
        'enableTemplateCaching' => true,
        //
        'isSystemOn' => false,
        // Disable project config changes on staging
        'allowAdminChanges' => false,
    ],

    // Production environment settings
    'production' => [
        //
        'allowUpdates' => false,
        //
        'backupOnUpdate' => false,
        //
        'devMode' => false,
        //
        'enableTemplateCaching' => true,
        //
        'isSystemOn' => true,
        // Disable project config changes on production
        'allowAdminChanges' => false,
        'suppressTemplateErrors' => false,
    ],
];
