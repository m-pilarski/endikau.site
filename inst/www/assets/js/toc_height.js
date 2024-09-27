var tocContainer = document.querySelector('#page-toc-container');
var tocBody = tocContainer.querySelector('#page-toc');

if (tocContainer != null && tocBody != null) {
  function adjustTOCHeight() {
    tocContainer.style.height = tocBody.scrollHeight + 'px';
  }
  window.addEventListener('load', adjustTOCHeight);
  window.addEventListener('resize', adjustTOCHeight);
}