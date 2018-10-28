var FontA = new FontFaceObserver("Lato");
var FontB = new FontFaceObserver("Lato");

Promise.all([FontA.load(), FontB.load()]).then(function () {
    document.documentElement.className += "fonts-loaded";
    sessionStorage.foftFontsLoaded = true;
});

