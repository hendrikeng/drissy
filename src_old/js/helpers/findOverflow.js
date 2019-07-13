const docWidth = document.documentElement.offsetWidth;

[].forEach.call(document.querySelectorAll('*'), el => {
    if (el.offsetWidth > docWidth) {
        console.log(el);
    }
});
