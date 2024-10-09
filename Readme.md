# Clang-format格式化代码

我们渴望代码的格式是统一的，这个是我们的朴素的一个愿望。

虽然代码格式没什么用，但是如果一个团队内的格式不统一，很影响心情。

这里采用的clang-format的脚本作为格式化工具，来格式化代码。

兼容windows和linux两个平台。

# 使用说明

1. 把tools文件夹放在你工程的根目录
2. 把format_all.sh从tools文件夹内复制出来，将**DIRS**填写成你要格式化的目录
3. 将.clang-format文件复制到你想要格式化的目录下。
4. 在根目录打开git-bash终端键入 `./format_all.sh`

或者你可以直接在你工程的根目录下添加子模块

`git submodule add git@github.com:FlyyingPiggy2020/clang-format.git tools/clang-format `

# 简单介绍

`format_all.sh`是格式化shell脚本，它的内容如下：

在windows环境下可以通过git-bash或者其他bash终端来执行。git自带了git-bash一般来说用这个就行了。在终端键入 `./format_all.sh`

```
#!/bin/bash  
# TODO:在DIRS里增加你要格式化代码的文件夹名称例如
# DIRS=("./Software/Project/Protocol/ ./Software/Project/Source/")

# 尝试执行Windows特有的命令，用于判断当前的OS类型 
if command -v cmd >/dev/null 2>&1; then  
    # windows下使用tools目录下的clang-format.exe格式化代码
    for dir in "${DIRS[@]}"; do  
        find "$dir" -type f \( -name "*.c" -o -name "*.h" \) -exec tools/clang-format -i {} +  
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


```

## 为什么要DIRS这个变量

我们会遇到如下情况：一部分代码是CubeMX生成的，或者其他第三方代码，我们不希望这些代码被格式化。而另外一部分自己的代码需要被格式化。

这个时候我们就需要一种方式，去选择哪些文件夹内的代码需要格式化，哪些不需要。

这里采用的方法是根据**DIRS**这个变量来决定，我这里没有设置，需要根据你的实际情况把**DIRS**变量填成你要格式化的代码的文件夹，它支持搜索里面的子文件夹中的所有.c和.h(小写)文件。

## 为什么要clang-format.exe

windows下会去利用“**tools/clang-format**”这个exe文件格式化代码。

而Linux下则不需要，你可以直接apt安装clang-format即可。这个clang-format的命令就在你环境变量里。

## .clang-format的逻辑

如果目录和子目录都有.clang-format，它会以子目录为准。

也就是说你可以给不同目录设置不同的规则。

如果嫌麻烦直接最上层的目录放一个.clang-format就行了，所有的文件都会按照这个规则格式化。

如果你希望每个目录不同，就需要在每个子目录里面用子目录的配置覆盖上层目录的配置。

## 如何让某段段码不格式化

在文件内部可以通过这样的方式，让某段代码不格式化。

```c
// clang-format off
...
...
...
// clang-format on
```
