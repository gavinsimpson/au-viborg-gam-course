.PHONY : slides
slides:
	cd ./01-materials && make $@
	cd ./02-materials && make $@
	cd ./03-materials && make $@

.PHONY : purl
purl:
	cd ./01-materials && make $@
	cd ./02-materials && make $@
	cd ./03-materials && make $@

