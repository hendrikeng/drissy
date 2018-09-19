import Glide, {
    Controls,
    Swipe,
    Breakpoints,
} from '@glidejs/glide/dist/glide.modular.esm';

export const slider = {
    selector: [...document.querySelectorAll('.js-slider')],
    options: {
        type: 'slider',
        // hoverpause: true,
        // autoplay: 2000,
    },

    init() {
        this.selector.forEach.call(this.selector, (item, i) => {
            this.slider = new Glide(item, this.options);
            this.slider.mount({ Controls, Swipe });
            this.slider = true;
            console.log(`Slider ${i} ${this.slider}`);
        });
    },

    destroy() {
        if (typeof this.slider === 'undefined' || !this.slider) return;
        this.selector.forEach.call(this.selector, (item, i) => {
            this.slider.destroy();
            this.slider = false;
            console.log(`Slider ${i} ${this.slider}`);
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
        bound: true,
        gap: 16,
        perView: 3,
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
        this.selector.forEach.call(this.selector, (item, i) => {
            this.carousel = new Glide(item, this.options);
            this.carousel.mount({ Controls, Swipe, Breakpoints });
            this.carousel = true;
            console.log(`Carousel ${i} ${this.carousel}`);
        });
    },

    destroy() {
        if (typeof this.carousel === 'undefined' || !this.carousel) return;
        this.selector.forEach.call(this.selector, (item, i) => {
            this.carousel.destroy();
            this.carousel = false;
            console.log(`Carousel ${i} ${this.carousel}`);
        });
    },
};
