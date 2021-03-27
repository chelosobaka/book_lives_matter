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
}

window.onresize = function() {
  updateReadMore();
}


function updateReadMore() {
  if (allOSB.length > 0) {
    for (let i = 0; i < allOSB.length; i++) {
      if (allOSB[i].scrollHeight > mxh) {
        if (allOSB[i].hasAttribute("style")) {
          updateHeight(allOSB[i]);
        }
        allOSB[i].nextElementSibling.className = "read-more";
      } else {
        allOSB[i].nextElementSibling.className = "read-more hid";
      }
    }
  }
}

function revealThis(current) {
  let el = current.previousElementSibling;
  if (el.hasAttribute("style")) {
    current.innerHTML = "...читать далее";
    el.removeAttribute("style");
  } else {
    updateHeight(el);
    current.innerHTML = "свернуть";
  }
}

function updateHeight(el) {
  el.style.maxHeight = el.scrollHeight + "px";
}


  function insertAfter(referenceNode, newNode) {
      referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling);
  }
