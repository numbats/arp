default: preview

preview:
	quarto preview

build:
	quarto render

deploy:
	quarto publish gh-pages --no-prompt --no-browser

clean:
	rm -Rf _site
	rm -Rf _freeze
	rm -Rf week*/slides_cache
	rm -Rf week*/slides_files
