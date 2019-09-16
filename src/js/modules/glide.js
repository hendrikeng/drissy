import Glide, {
    Autoplay,
    Controls,
    Swipe,
    Breakpoints,
    Keyboard,
} from '@glidejs/glide/dist/glide.modular.esm';

export const slider = {
    selector: [...document.querySelectorAll('.js-slider')],
    options: {
        animationTimingFunc: 'ease',
        animationDuration: 400,
        type: 'carousel',
        gap: 0,
        hoverpause: false,
        autoplay: 4000,
        //  bound: false,
        //  rewind: false,
    },

    init() {
        this.selector.forEach.call(this.selector, item => {
            this.slider = new Glide(item, this.options);
            this.slider.mount({ Swipe, Autoplay, Keyboard, Controls });
        });
    },

    destroy() {
        this.selector.forEach.call(this.selector, () => {
            if (typeof this.slider === 'undefined') return;
            this.slider.destroy();
        });
    },
};

export const carousel = {
    selector: [...document.querySelectorAll('.js-carousel')],
    options: {
        type: 'carousel',
        animationTimingFunc: 'cubic-bezier(0.680, -0.550, 0.265, 1.550)',
        animationDuration: 800,
        // hoverpause: true,
        // autoplay: 2000,
        // focusAt: 'center',
        bound: false,
        gap: 0,
        perView: 8,
        breakpoints: {
            1024: {
                perView: 2,
            },
            600: {
                perView: 1,
            },
        },
    },

    init() {
        this.selector.forEach.call(this.selector, item => {
            this.carousel = new Glide(item, this.options);
            this.carousel.mount({ Controls, Swipe, Breakpoints });
            this.carousel = true;
        });
    },

    destroy() {
        if (typeof this.carousel === 'undefined' || !this.carousel) return;
        this.selector.forEach.call(this.selector, () => {
            this.carousel.destroy();
            this.carousel = false;
        });
    },
};
