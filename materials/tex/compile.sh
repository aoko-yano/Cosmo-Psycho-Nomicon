#!/bin/bash

cd $(dirname ${0})

lualatex main.tex
biber main
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

mv main.pdf ../../