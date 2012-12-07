all:
	haml templates/index.html.haml index.html
	haml templates/about.html.haml about.html
	sass style/main.scss style/main.css

watch:
	sass --watch style:style