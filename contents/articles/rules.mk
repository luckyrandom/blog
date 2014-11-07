%.md:%.Rmd
	Rscript -e 'library("knitr"); knit("$<", "$@")'
