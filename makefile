all:
	mkdir -p rendered
	mkdir -p rendered/style
	cp -r static/* rendered/
	./generate.rb 
	sass style/main.scss rendered/style/main.css

install:
	bundle install
	
watch:
	sass --watch style/main.scss:rendered/style/main.css