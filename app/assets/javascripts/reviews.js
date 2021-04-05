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
