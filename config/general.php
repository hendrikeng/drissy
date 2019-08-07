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
        //
        'enableCsrfProtection' => true,
        //
        'generateTransformsBeforePageLoad' => true,
        // Whether generated URLs should omit "index.php"
        'omitScriptNameInUrls' => true,

        // Control Panel trigger word
        'cpTrigger' => 'admin',

        // The secure key Craft will use for hashing and encrypting data
        'securityKey' => getenv('SECURITY_KEY'),
        //
        'useEmailAsUsername' => true,
        //
        'usePathInfo' => true,
        // Whether to save the project config out to config/project.yaml
        // (see https://docs.craftcms.com/v3/project-config.html)
        'useProjectConfigFile' => true,
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
        // Set this to `false` to prevent administrative changes from being made on staging
        'allowAdminChanges' => true,
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
    ],

    // Production environment settings
    'production' => [
        // Set this to `false` to prevent administrative changes from being made on production
        'allowAdminChanges' => true,
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
    ],
];
