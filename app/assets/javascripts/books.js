function btnBookListWidth(){

  let selectTag;
  let selectWidth;
  let button;
//let buttonWidth;


  selectTag = document.getElementById('book_list_list_id');
  selectWidth = selectTag.getBoundingClientRect().width.toFixed(1);


  button = document.querySelector('.btn-book-list');
  //buttonWidth = button.getBoundingClientRect().width.toFixed(1);

  if (selectWidth > 170) {
    button.style.width = selectWidth + "px";
  }
}