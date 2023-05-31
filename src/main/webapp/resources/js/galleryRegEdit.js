$(document).ready(function() {
	$('#file').change(function(event) {
		let file = event.target.files[0];
		let reader = new FileReader();

		reader.onload = function(e) {
			$('.gallery_img').css('background-image', 'url(' + e.target.result + ')');
			
		};
		reader.readAsDataURL(file);
	});
});