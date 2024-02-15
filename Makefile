default: preview

preview:
	quarto preview --no-serve --no-browser

build:
	quarto render

clean:
	rm -Rf _site
	rm -Rf _freeze
	rm -Rf week*/slides_cache
	rm -Rf week*/slides_files
