all:
	haml templates/index.html.haml index.html
	sass style/main.scss style/main.css

watch:
	sass --watch style:style