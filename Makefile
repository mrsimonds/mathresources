## ********************************************************************* ##
## Copyright 2015                                                        ##
## Robert A. Beezer, Michael Gage, Geoff Goehle, Alex Jordan             ##
##                                                                       ##
## This file is part of MathBook XML.                                    ##
##                                                                       ##
## MathBook XML is free software: you can redistribute it and/or modify  ##
## it under the terms of the GNU General Public License as published by  ##
## the Free Software Foundation, either version 2 or version 3 of the    ##
## License (at your option).                                             ##
##                                                                       ##
## MathBook XML is distributed in the hope that it will be useful,       ##
## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         ##
## GNU General Public License for more details.                          ##
##                                                                       ##
## You should have received a copy of the GNU General Public License     ##
## along with MathBook XML.  If not, see <http://www.gnu.org/licenses/>. ##
## ********************************************************************* ##

#######################
# DO NOT EDIT THIS FILE
#######################

#   1) Do make a copy of Makefile.paths.original
#      as Makefile.paths
#   2) Edit Makefile.paths as directed there
#   3) This file (Makefile) and Makefile.paths.original
#      are managed by revision control and edits will conflict
#   4) See updated history in Makefile.paths.original
#      for changes, or follow the revision control history

##############
# Introduction
##############

# This is not a "true" makefile, since it does not
# operate on dependencies.  It is more of a shell
# script, sharing common configurations

######################
# System Prerequisites
######################

#   install         (system tool to make directories)
#   xsltproc        (xml/xsl text processor)
#   xmllint         (only to check source against DTD)
#   <helpers>       (PDF viewer, web browser, pager, Sage executable, etc)

#####
# Use
#####

#	A) Set default directory to be the location of this file
#	B) At command line:  make <some-target>

# The included file contains customized versions
# of locations of the principal components of this
# project and names of various helper executables
include Makefile.paths

# These paths are subdirectories of
# the Mathbook XML distribution
# MBUSR is where extension files get copied
# so relative paths work properly
MBXSL = $(MB)/xsl
MBUSR = $(MB)/user
RNG = $(MB)/schema/pretext.rng

# These paths are subdirectories of
# the project
SRC        = $(PRJ)/src
CSS	   = $(PRJ)/style/css
OUTPUT     = $(PRJ)/output
IMGSRC     = $(SRC)/images
PRJXSL     = $(PRJ)/xsl

# The main file
MAINFILE   = $(SRC)/mathresources.ptx

# Places where output lands
HTML       = $(OUTPUT)/html
IMGOUT     = $(OUTPUT)/images

# Some aspects of producing these examples require a WeBWorK server.
# For all but trivial testing or examples, please look into setting
# up your own WeBWorK server, or consult Alex Jordan about the use
# of PCC's server in a nontrivial capacity.    <alex.jordan@pcc.edu>
SERVER = https://webwork.pcc.edu

# make all the image files in svg format
images:
	install -d $(OUTPUT)
	install -d $(IMGOUT)
	-rm $(IMGOUT)/*.svg
	$(MB)/script/mbx -c latex-image -f svg -d $(IMGOUT) $(MAINFILE)

# Make the HTML output
html:
	install -d $(OUTPUT)
	install -d $(HTML)
	install -d $(HTML)/images
	install -d $(HTML)/css
	install -d $(IMGOUT)
	install -d $(IMGSRC)
	-rm $(HTML)/*.html
	-rm $(HTML)/knowl/*.html
	-rm $(HTML)/images/*
	cp -a $(IMGSRC) $(HTML)
	cp -a $(IMGOUT) $(HTML)
	cp -a $(CSS) $(HTML)
	cd $(HTML); \
	xsltproc --xinclude --stringparam html.knowl.example no --stringparam html.knowl.list yes --stringparam webwork.server $(SERVER) $(PRJXSL)/math-resources-html.xsl $(MAINFILE)

###########
# Utilities
###########

# Verify Source integrity
#   Leaves "jingreport.txt" in OUTPUT
check:
	install -d $(OUTPUT)
	-rm $(OUTPUT)/jingreport.txt
	-java -classpath ~/jing-trang/build -Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration -jar ~/jing-trang/build/jing.jar $(RNG) $(MAINFILE) > $(OUTPUT)/jingreport.txt
	less $(OUTPUT)/jingreport.txt
