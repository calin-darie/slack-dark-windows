var fs = require('fs');
document.addEventListener('DOMContentLoaded', () => {   
	fs.readFile('resources/themes/black.css', 'utf8', function(err, css) {
		if (err) {
			alert(err);
			return;
		}
		$("<style></style>").appendTo('head').html(css);
	});
});