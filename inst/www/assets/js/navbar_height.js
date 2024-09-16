function adjustNavbarSpacer() {
    var Container = document.querySelector('#page-navbar-container');
	var Spacer = document.querySelector('#page-navbar-spacer');
    var Height = Container.scrollHeight;
    Spacer.style.height = Height + 'px';
}
/* Run the function when the page loads */
window.addEventListener('load', adjustNavbarSpacer);
/* Run the function when the window is resized */
window.addEventListener('resize', adjustNavbarSpacer);
