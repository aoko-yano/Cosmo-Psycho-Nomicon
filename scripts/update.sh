#!/bin/bash

# リポジトリのルートディレクトリに移動
cd $(git rev-parse --show-toplevel)
echo "Current: $(pwd)"

# 各 .md ファイルを .tex に変換
find "materials/md" -type f -name "*.md" | while read -r file; do
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