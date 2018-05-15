"use strict";

// if (document.documentElement.className.indexOf("fonts-loaded") < 0) {
//   var FontA = new FontFaceObserver("Lato");
//   Promise.all([FontA.load()]).then(function() {
//     document.documentElement.className += "fonts-loaded";
//     console.log('fonts-loaded');
//     console.log(FontFaceObserver);
//     console.log(FontA);
//   });
// }

if (document.documentElement.className.indexOf("fonts-loaded") < 0) {
var font = new FontFaceObserver('Lato');
  font.load().then(function () {
    document.documentElement.className += "fonts-loaded";
  });
}
