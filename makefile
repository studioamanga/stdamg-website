all:
	mkdir -p rendered
	mkdir -p rendered/style
	cp -r static/* rendered/
	swift generate.swift
	sass style/main.scss rendered/style/main.css

watch:
	sass --watch style/main.scss:rendered/style/main.css
