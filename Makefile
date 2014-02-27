PATHNAME=$(shell pwd)
BASENAME=$(shell basename $(PATHNAME))
PROJECT=cyberaide

all:
	make -f Makefile sphinx

######################################################################
# GIT INTERFACES
######################################################################
push:
	make -f Makefile clean
	git commit -a 
	git push

pull:
	git pull 

gregor:
	git config --global user.name "Gregor von Laszewski"
	git config --global user.email laszewski@gmail.com

git-ssh:
	git remote set-url origin git@github.com:$(PROJECT)/$(BASENAME).git


######################################################################
# INSTALLATION
######################################################################
req:
	pip install -r requirements.txt

dist:
	make -f Makefile pip

sdist: clean
	#make -f Makefile clean
	python setup.py sdist --format=bztar,zip


force:
	make -f Makefile nova
	make -f Makefile pip
	pip install -U dist/*.tar.gz

install:
	pip install dist/*.tar.gz

# #####################################################################
# CLEAN
# #####################################################################


clean:
	rm -rf *.egg
	find . -name "*~" -exec rm {} \;  
	find . -name "*.pyc" -exec rm {} \;  
	rm -rf build doc/build dist *.egg-info *~ #*
	cd doc; make clean
	rm -rf *.egg-info

uninstall:
	yes | pip uninstall $(PROJECT)

#############################################################################
# SPHINX DOC
###############################################################################

sphinx:
	cd doc; make html
	open doc/build/html/index.html

#############################################################################
# PUBLISH GIT HUB PAGES
###############################################################################

gh-pages:
	git checkout gh-pages
	make pages


######################################################################
# ONLY RUN ON GH-PAGES
######################################################################

PROJECT=`basename $(PWD)`
DIR=/tmp/$(PROJECT)
DOC=$(DIR)/doc

pages: ghphtml ghpgit
	echo done

ghphtml:
	cd /tmp
	rm -rf $(DIR)
	cd /tmp; git clone git://github.com/$(PROJECT)/$(BASENAME).git
	cp $(DIR)/Makefile .
	cd $(DOC); ls; make html
	rm -fr _static
	rm -fr _source
	rm -fr *.html
	cp -r $(DOC)/build/html/* .

ghpgit:
	git add . _sources _static   
	git commit -a -m "updating the github pages"
	git push
	git checkout master

