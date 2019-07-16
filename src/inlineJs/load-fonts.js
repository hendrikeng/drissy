"use strict";

var FontA = new FontFaceObserver("Roboto Condensed");
var FontB = new FontFaceObserver("Cabin");

Promise.all([FontA.load(), FontB.load()]).then(function () {
    document.documentElement.className += "fonts-loaded";
    sessionStorage.foftFontsLoaded = true;
});

