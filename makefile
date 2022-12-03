all:
	mkdir -p rendered
	mkdir -p rendered/style
	cp -r static/* rendered/
	swift generate.swift > rendered/index.html
	sass style/main.scss rendered/style/main.css

install:
	bundle install

watch:
	sass --watch style/main.scss:rendered/style/main.css
