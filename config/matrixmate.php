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
                                'fields' => [ 'layout', 'linkToEntry', 'limit' ],
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
                                'fields' => [ 'layout', 'linkToEntry' ],
                            ],
                        ],
                    ],
                ],
            ],
        ],
    ];
