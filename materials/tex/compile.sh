#!/bin/bash

cd $(dirname ${0})

lualatex main.tex
biber main
lualatex main.tex
lualatex main.tex