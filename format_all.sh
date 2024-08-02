#!/bin/bash  
# TODO:在DIRS里增加你要格式化代码的文件夹名称例如
# DIRS=("./Software/Project/Protocol/ ./Software/Project/Source/")

# 尝试执行Windows特有的命令，用于判断当前的OS类型 
if command -v cmd >/dev/null 2>&1; then  
    # windows下使用tools目录下的clang-format.exe格式化代码
    for dir in "${DIRS[@]}"; do  
        find "$dir" -type f \( -name "*.c" -o -name "*.h" \) -exec tools/clang-format/clang-format -i {} +  
    done 
else
    # linux下使用自带的clang-format格式化代码
    if [ -f /proc/version ]; then  
        for dir in "${DIRS[@]}"; do  
            find "$dir" -type f \( -name "*.c" -o -name "*.h" \) -exec clang-format -i {} +  
        done  
    else
    # unknow system
        echo "Unable to determine the operating system environment."  
    fi  
fi

