#!/bin/bash

# リポジトリのルートディレクトリに移動
cd $(git rev-parse --show-toplevel)

# 作業ディレクトリに移動
cd materials/tex

# 作業ディレクトリにいることを確認
echo "Current: $(pwd)"

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