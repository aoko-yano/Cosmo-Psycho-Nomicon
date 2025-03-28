#!/bin/bash

cd $(dirname ${0})

lualatex main.tex
biber main
makeindex main.idx
lualatex main.tex
lualatex main.tex

rm *.aux
rm *.log
rm *.bbl
rm *.idx
rm *.bcf
rm *.out
rm *.toc
rm *.xml
rm *.blg
rm *.ltjruby
rm *.ilg
rm *.ind

mv main.pdf ../../