#!/bin/bash

# .md ファイルの差分を取得
md_files=$(git diff --name-only --diff-filter=AM HEAD | grep '\.md$')

# .md ファイルがなければ終了
if [ -z "$md_files" ]; then
    echo "No modified or added .md files."
    exit 0
fi

# 各 .md ファイルを .tex に変換
for file in $md_files; do
    filename=$(basename ${file})
    tex_file="materials/tex/${filename%.md}.tex"
    echo "Converting $file to $tex_file..."
    pandoc --from=markdown "$file" -o "$tex_file"
done

echo "Conversion complete!"