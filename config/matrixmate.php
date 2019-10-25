<?php

    return [
        'fields' => [
            'contentBuilder' => [
                'hideUngroupedTypes' => true,
                'groups' => [
                    [
                        'label' => 'Elements',
                        'types' => [
                            'headline',
                            'richText',
                            'quote',
                            'form',
                            'embedded',
                            'separator',
                        ],
                    ],
                    [
                        'label' => 'Image',
                        'types' => [
                            'imageSingle',
                            'imageGrid',
                            'imageSlider',
                        ],
                    ],
                    [
                        'label' => 'Category',
                        'types' => [
                            'category',
                            'categorySlider',
                        ],
                    ],
                    [
                        'label' => 'Entry',
                        'types' => [
                            'entry',
                            'entrySlider',
                        ],
                    ]
                ],
                'types'  => [
                    'embedded' => [
                        'tabs' => [
                            [
                                'label'  => 'Content',
                                'fields' => [
                                    'code',
                                ],
                            ],
                            [
                                'label'  => 'Settings',
                                'fields' => [ 'ratio' ],
                            ],
                        ],
                    ],
                    'imageSingle' => [
                        'tabs' => [
                            [
                                'label'  => 'Content',
                                'fields' => [
                                    'image',
                                ],
                            ],
                            [
                                'label'  => 'Settings',
                                'fields' => [ 'ratio', 'caption' ],
                            ],
                        ],
                    ],
                    'imageGrid' => [
                        'tabs' => [
                            [
                                'label'  => 'Content',
                                'fields' => [
                                    'images',
                                ],
                            ],
                            [
                                'label'  => 'Settings',
                                'fields' => [ 'ratio', 'columns', 'caption', 'gallery' ],
                            ],
                        ],
                    ],
                    'imageSlider' => [
                        'tabs' => [
                            [
                                'label'  => 'Content',
                                'fields' => [
                                    'images',
                                ],
                            ],
                            [
                                'label'  => 'Settings',
                                'fields' => [ 'ratio', 'layout' ],
                            ],
                        ],
                    ],
                    'category' => [
                        'tabs' => [
                            [
                                'label'  => 'Content',
                                'fields' => [
                                    'category',
                                ],
                            ],
                            [
                                'label'  => 'Settings',
                                'fields' => [ 'layout', 'linkToEntry' ],
                            ],
                        ],
                    ],
                    'categorySlider' => [
                        'tabs' => [
                            [
                                'label'  => 'Content',
                                'fields' => [
                                    'category',
                                ],
                            ],
                            [
                                'label'  => 'Settings',
                                'fields' => [ 'ratio', 'layout', 'linkToEntry', 'limit' ],
                            ],
                        ],
                    ],
                    'entry' => [
                        'tabs' => [
                            [
                                'label'  => 'Content',
                                'fields' => [
                                    'entry',
                                ],
                            ],
                            [
                                'label'  => 'Settings',
                                'fields' => [ 'layout', 'linkToEntry' ],
                            ],
                        ],
                    ],
                    'entrySlider' => [
                        'tabs' => [
                            [
                                'label'  => 'Content',
                                'fields' => [
                                    'entry',
                                ],
                            ],
                            [
                                'label'  => 'Settings',
                                'fields' => [ 'ratio', 'layout', 'linkToEntry' ],
                            ],
                        ],
                    ],
                ],
            ],
        ],
    ];
