default: preview

preview:
	quarto preview --no-serve --no-browser

build:
	quarto render

clean:
	rm -rf _site
	rm -rf _freeze
	rm -rf slides/*_cache
	rm -rf slides/*_files
