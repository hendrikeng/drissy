function setAttributes(el, attrs) {
    Object.keys(attrs).forEach(key => {
        if (Object.prototype.hasOwnProperty.call(attrs, key)) {
            el.setAttribute(key, attrs[key]);
        }
    });
}

export default setAttributes;
