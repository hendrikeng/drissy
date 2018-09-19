import "core-js/modules/es6.promise";
import "core-js/modules/web.dom.iterable";

if (document.documentElement.className.indexOf("fonts-loaded") < 0) {
  var FontA = new FontFaceObserver("Lato");
  var FontB = new FontFaceObserver("Lato");
  Promise.all([FontA.load(), FontB.load()]).then(function () {
    document.documentElement.className += "fonts-loaded";
  });
}