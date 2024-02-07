default: build

preview:
	quarto preview

build:
	quarto render

clean:
	rm -rf _site
	rm -rf _freeze
	rm -rf slides/*_cache
	rm -rf slides/*_files
