// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require cocoon
//= require popper
//= require bootstrap-sprockets
//= require activestorage
//= require_tree .


let allOSB = [];
let mxh = '';

window.onload = function() {

  allOSB = document.getElementsByClassName("review-body");

  if (allOSB.length > 0) {
    mxh = window.getComputedStyle(allOSB[0]).getPropertyValue('max-height');
    mxh = parseInt(mxh.replace('px', ''));


    for (let i = 0; i < allOSB.length; i++) {
      let el = document.createElement("button");
      el.innerHTML = "...читать далее";
      el.setAttribute("type", "button");
      el.setAttribute("class", "read-more hid");

      insertAfter(allOSB[i], el);
    }
  }


  let readMoreButtons = document.getElementsByClassName("read-more");
  for (let i = 0; i < readMoreButtons.length; i++) {
    readMoreButtons[i].addEventListener("click", function() {
      revealThis(this);
    }, false);
  }


  updateReadMore();
  btnBookListWidth();

}

window.onresize = function() {
  updateReadMore();
}
