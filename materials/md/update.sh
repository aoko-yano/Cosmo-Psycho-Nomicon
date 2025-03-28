#!/bin/bash

function set_index() {
    local -r target=$1
    local -r wordlist_file=$2

    mv "$target" "${target}.bak"

    mapfile -t words < "$wordlist_file"

    # 単語リストを外部ファイルから読み込んで、各行の処理を行う
    while IFS= read -r line || [ -n "${line}" ]; do
        # \section{} などのコマンドを含む行はそのまま出力
        if [[ "$line" =~ \\(index|part|chapter|section|subsection|paragraph|subparagraph|item|footnote|label|ref) ]]; then
            printf "%s\n" "$line"
        else
            # 単語リスト中の単語に \index{} を追加
            for word in "${words[@]}"; do
                # line内で$wordを\index{$word}に置き換える
                line=$(echo "$line" | sed "s/$word/\\\\index{$word}/g")
            done
            printf "%s\n" "$line"
        fi
    done < "$target.bak" > "$target"
}

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
        set_index "$file" "materials/md/index_word_list.txt"
    fi
    echo "[End] Add index info to $file"
done

echo "Conversion complete!"