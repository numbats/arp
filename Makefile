default: build

preview:
	quarto preview

build:
	quarto render --profile noslides --no-clean

clean:
	rm -Rf _site
	rm -Rf _freeze
	rm -Rf week*/slides_cache
	rm -Rf week*/slides_files
