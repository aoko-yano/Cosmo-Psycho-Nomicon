#!/bin/bash

# リポジトリのルートディレクトリに移動
cd $(git rev-parse --show-toplevel)
echo "Current: $(pwd)"

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

# 索引を付ける
for file in materials/tex/*.tex; do
    echo "[Start] Add index info to $file"
    if [ -f "$file" ]; then
        python3 scripts/add_index.py "$file" "materials/md/index_word_list.txt"
    fi
    echo "[End] Add index info to $file"
done

echo "Conversion complete!"