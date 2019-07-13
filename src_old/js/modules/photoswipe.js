import PhotoSwipe from 'photoswipe';
import PhotoSwipeUIDefault from 'photoswipe/dist/photoswipe-ui-default';

const photoswipe = {
    selector: [...document.querySelectorAll('.js-gallery')],
    options: {},
    controls: `<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="pswp__bg"></div>
                    <div class="pswp__scroll-wrap">
                        <div class="pswp__container">
                            <div class="pswp__item"></div>
                            <div class="pswp__item"></div>
                            <div class="pswp__item"></div>
                        </div>
                        <div class="pswp__ui pswp__ui--hidden">
                            <div class="pswp__top-bar">
                                <div class="pswp__counter"></div>
                                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
                                <button class="pswp__button pswp__button--share" title="Share"></button>
                                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
                                <div class="pswp__preloader">
                                    <div class="pswp__preloader__icn">
                                        <div class="pswp__preloader__cut">
                                            <div class="pswp__preloader__donut"></div>
                                        </div>
                                    </div>
                                </div>
                             </div>
                            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                                <div class="pswp__share-tooltip"></div> 
                            </div>
                            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)"></button>
                            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)"></button>
                            <div class="pswp__caption">
                                <div class="pswp__caption__center"></div>
                            </div>
                        </div>
                    </div>
                </div>`,

    init(el) {
        const div = document.createElement('div');
        div.innerHTML = this.controls;
        document.getElementsByTagName('body')[0].appendChild(div);

        // eslint-disable-next-line no-shadow
        const parseThumbnailElements = el => {
            const thumbElements = el.childNodes;
            const numNodes = thumbElements.length;
            const items = [];
            let figureEl;
            let linkEl;
            let size;
            let item;

            for (let i = 0; i < numNodes; i += 1) {
                figureEl = thumbElements[i]; // <figure> element

                // include only element nodes
                if (figureEl.nodeType !== 1) {
                    // eslint-disable-next-line no-continue
                    continue;
                }

                // eslint-disable-next-line prefer-destructuring
                linkEl = figureEl.children[0]; // <a> element

                size = linkEl.getAttribute('data-size').split('x');

                // create slide object
                item = {
                    src: linkEl.getAttribute('href'),
                    w: parseInt(size[0], 10),
                    h: parseInt(size[1], 10),
                };

                if (figureEl.children.length > 1) {
                    // <figcaption> content
                    item.title = figureEl.children[1].innerHTML;
                }

                if (linkEl.children.length > 0) {
                    // <img> thumbnail element, retrieving thumbnail url
                    item.msrc = linkEl.children[0].getAttribute('src');
                }

                item.el = figureEl; // save link to element for getThumbBoundsFn
                items.push(item);
            }
            return items;
        };

        // eslint-disable-next-line no-shadow
        const closest = function closest(el, fn) {
            return el && (fn(el) ? el : closest(el.parentNode, fn));
        };

        const onThumbnailsClick = e => {
            // eslint-disable-next-line no-param-reassign
            e = e || window.event;
            // eslint-disable-next-line no-unused-expressions
            e.preventDefault ? e.preventDefault() : (e.returnValue = false);

            const eTarget = e.target || e.srcElement;

            // find root element of slide
            const clickedListItem = closest(
                eTarget,
                // eslint-disable-next-line no-shadow
                el => el.tagName && el.tagName.toUpperCase() === 'FIGURE',
            );

            if (!clickedListItem) {
                return;
            }

            // find index of clicked item by looping through all child nodes
            // alternatively, you may define index via data- attribute
            const clickedGallery = clickedListItem.parentNode;

            // eslint-disable-next-line prefer-destructuring
            const childNodes = clickedListItem.parentNode.childNodes;

            const numChildNodes = childNodes.length;

            let nodeIndex = 0;

            let index;

            for (let i = 0; i < numChildNodes; i += 1) {
                if (childNodes[i].nodeType !== 1) {
                    // eslint-disable-next-line no-continue
                    continue;
                }

                if (childNodes[i] === clickedListItem) {
                    index = nodeIndex;
                    break;
                }
                // eslint-disable-next-line no-plusplus
                nodeIndex++;
            }

            if (index >= 0) {
                // open PhotoSwipe if valid index found
                // eslint-disable-next-line no-use-before-define
                openPhotoSwipe(index, clickedGallery);
            }
            // eslint-disable-next-line consistent-return
            return false;
        };

        // eslint-disable-next-line func-names
        const photoswipeParseHash = function() {
            const hash = window.location.hash.substring(1);

            const params = {};

            if (hash.length < 5) {
                return params;
            }

            const vars = hash.split('&');
            for (let i = 0; i < vars.length; i += 1) {
                if (!vars[i]) {
                    // eslint-disable-next-line no-continue
                    continue;
                }
                const pair = vars[i].split('=');
                if (pair.length < 2) {
                    // eslint-disable-next-line no-continue
                    continue;
                }
                // eslint-disable-next-line prefer-destructuring
                params[pair[0]] = pair[1];
            }

            if (params.gid) {
                params.gid = parseInt(params.gid, 10);
            }

            return params;
        };

        const openPhotoSwipe = (
            index,
            galleryElement,
            disableAnimation,
            fromURL,
        ) => {
            const pswpElement = document.querySelectorAll('.pswp')[0];

            let gallery;

            let options;

            let items;

            // eslint-disable-next-line prefer-const
            items = parseThumbnailElements(galleryElement);

            // define options (if needed)
            // eslint-disable-next-line prefer-const
            options = {
                // define gallery index (for URL)
                galleryUID: galleryElement.getAttribute('data-pswp-uid'),

                // eslint-disable-next-line no-shadow
                getThumbBoundsFn(index) {
                    // See Options -> getThumbBoundsFn section of documentation for more info
                    const thumbnail = items[index].el.getElementsByTagName(
                        'img',
                    )[0];
                    // find thumbnail
                    const pageYScroll =
                        window.pageYOffset ||
                        document.documentElement.scrollTop;

                    const rect = thumbnail.getBoundingClientRect();

                    return {
                        x: rect.left,
                        y: rect.top + pageYScroll,
                        w: rect.width,
                    };
                },

                shareButtons: [
                    {
                        id: 'download',
                        label: 'Download',
                        url: '{{raw_image_url}}',
                        download: true,
                    },
                ],
            };

            // PhotoSwipe opened from URL
            if (fromURL) {
                if (options.galleryPIDs) {
                    // parse real index when custom PIDs are used
                    // http://photoswipe.com/documentation/faq.html#custom-pid-in-url
                    for (let j = 0; j < items.length; j += 1) {
                        if (items[j].pid === index) {
                            options.index = j;
                            break;
                        }
                    }
                } else {
                    // in URL indexes start from 1
                    options.index = parseInt(index, 10) - 1;
                }
            } else {
                options.index = parseInt(index, 10);
            }

            // exit if index not found
            // eslint-disable-next-line no-restricted-globals
            if (isNaN(options.index)) {
                return;
            }

            if (disableAnimation) {
                options.showAnimationDuration = 0;
            }

            // Pass data to PhotoSwipe and initialize it
            // eslint-disable-next-line prefer-const
            gallery = new PhotoSwipe(
                pswpElement,
                PhotoSwipeUIDefault,
                items,
                options,
            );
            gallery.init();
        };

        // loop through all gallery elements and bind events
        const galleryElements = document.querySelectorAll(el);

        for (let i = 0, l = galleryElements.length; i < l; i += 1) {
            galleryElements[i].setAttribute('data-pswp-uid', i + 1);
            galleryElements[i].onclick = onThumbnailsClick;
        }

        // Parse URL and open gallery if it contains #&pid=3&gid=1
        const hashData = photoswipeParseHash();
        if (hashData.pid && hashData.gid) {
            openPhotoSwipe(
                hashData.pid,
                galleryElements[hashData.gid - 1],
                true,
                true,
            );
        }
    },
};

export default photoswipe;
