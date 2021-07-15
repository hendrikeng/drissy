"use strict";

var FontA = new FontFaceObserver("Poppins");

Promise.all([FontA.load()]).then(function () {
    document.documentElement.className += "fonts-loaded";
});
