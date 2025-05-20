#!/bin/bash  
# TODO:在DIRS里增加你要格式化代码的文件夹名称例如

VERBOSE=false
DIRS=("./board" "./protocol" "./fp-sdk" "./bsp" "./source")

while getopts "v" opt; do
  case $opt in
    v) VERBOSE=true ;;
    *) echo "Usage: $0 [-v]" >&2; exit 1 ;;
  esac
done

# 尝试执行Windows特有的命令，用于判断当前的OS类型 
if command -v cmd >/dev/null 2>&1; then
  for dir in "${DIRS[@]}"; do
    $VERBOSE && echo "Processing $dir:"
    $VERBOSE && find "$dir" -type f \( -name "*.c" -o -name "*.h" \) -print 
    find "$dir" -type f \( -name "*.c" -o -name "*.h" \) -exec tools/clang-format/clang-format -i {} +
  done
else
  if [ -f /proc/version ]; then
    for dir in "${DIRS[@]}"; do
      $VERBOSE && echo "Processing $dir:"
      find "$dir" -type f \( -name "*.c" -o -name "*.h" \) -print
      find "$dir" -type f \( -name "*.c" -o -name "*.h" \) -exec clang-format -i {} +
    done
  fi
fi

