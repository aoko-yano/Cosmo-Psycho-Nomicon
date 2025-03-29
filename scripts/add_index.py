#!/usr/bin/env python3

import re
import sys

def set_index(target: str, wordlist_file: str):
    # 元のファイルをバックアップ
    backup_file = f"{target}.bak"
    with open(target, "r", encoding="utf-8") as f:
        lines = f.readlines()
    with open(backup_file, "w", encoding="utf-8") as f:
        f.writelines(lines)
    
    # 単語リストを読み込む
    with open(wordlist_file, "r", encoding="utf-8") as f:
        words = [line.strip() for line in f if line.strip()]
    
    # LaTeX の特定のコマンドを含む行を判定する正規表現
    command_pattern = re.compile(r"\\(index|part|chapter|section|subsection|paragraph|subparagraph|item|footnote|label|ref)")
    
    with open(target, "w", encoding="utf-8") as f:
        for line in lines:
            if command_pattern.search(line):
                f.write(line)  # そのまま出力
            else:
                for word in words:
                    line = re.sub(rf'{re.escape(word)}', rf'\\index{{{word}}}', line)
                f.write(line)

if __name__ == "__main__":
    target = sys.argv[1]
    wordlist_file = sys.argv[2]

    set_index(target, wordlist_file)