#Make file for github pages to run locally

help :
	@echo "Usage:"
	@echo "make serve               - Start a server locally."
	@echo "make install             - Install needed packages."
	@echo "make version             - Show version number of all needed packages."
	@echo "make clean               - Remove generated files."

serve :
	bundle exec jekyll serve --livereload

install :
	gem install bundler jekyll jekyll-theme-architect jekyll-sitemap

version :
	python --version
	ruby -v
	gem -v
	gcc --version
	g++ --version
	jekyll -v
	@echo "\n"

clean :
	rm -rf _site
	rm -rf .bundle
	rm -rf .jekyll-cache
	rm -rf .vendor
	mkdir .bundle
	