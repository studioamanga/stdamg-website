all:
	./generate.rb 
	sass style/main.scss rendered/style/main.css

install:
	bundle install
	
watch:
	sass --watch style/main.scss:rendered/style/main.css