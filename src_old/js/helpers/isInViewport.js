// https://gomakethings.com/how-to-test-if-an-element-is-in-the-viewport-with-vanilla-javascript/

const isInViewport = elem => {
    const bounding = elem.getBoundingClientRect();
    return (
        bounding.top >= 0 &&
        bounding.left >= 0 &&
        bounding.bottom <=
        (window.innerHeight || document.documentElement.clientHeight) &&
        bounding.right <=
        (window.innerWidth || document.documentElement.clientWidth)
    );
};

export default isInViewport;
