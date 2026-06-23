---
title: "Full Stack Fastapi Template"
description: "欢迎来到 Full Stack FastAPI 官方模板的学习系列！本系列将逐步解析该模板的架构、用法和最佳实践"
date: 2026-06-23T14:22:31+08:00
image: "cover.jpg"
tags: ["FastAPI", "全栈开发", "Python"]
categories: ["project"]
# 章节权重: 控制文章在系列中的显示顺序，数字越小越靠前[reference:8]
# 脚本会自动根据你输入的章节号设置此值
weight: -10
# draft: true            # 是否为草稿
# comments: true        # 是否开启评论
# math: true             # 需要数学公式时取消注释
# license:               # 如有特殊许可，填写内容
# build:
#     list: always    # Change to "never" to hide the page from the list
---



# 欢迎来到 Full Stack FastAPI 官方模板的学习系列！本系列将逐步解析该模板的架构、用法和最佳实践。

- 这个项目是一个全栈项目模板，用于快速开发一个完整的 Web 应用程序。
- 所以就有了这个系列就是学习这个全栈项目模板[Full Stack Fastapi Template](https://github.com/fastapi/full-stack-fastapi-template)

## 快速开始

为了后续写博客方便，这里将项目模板的快速开始步骤复制过来。

这里为你准备了一套**完整、可直接复制使用**的自动化方案，包含Hugo Archetypes模板和配套的Shell脚本，帮你一键创建结构规范的系列文章。

### 方案概述
*   **Archetypes（内容模板）**：定义新文章的默认Front Matter和内容结构，保证所有文章格式统一。
*   **自动化脚本**：一个Shell脚本，能自动处理创建文件夹、生成`index.md`、甚至批量生成多个章节等重复工作。

---

### 第一步：设置Archetypes模板

首先，在Hugo项目根目录下，创建`archetypes/series`文件夹，并在其中新建一个`index.md`文件：

```bash
# MacOS/Linux
mkdir -p archetypes/series
touch archetypes/series/index.md
# Windows PowerShell
New-Item -Path "archetypes/series" -ItemType Directory -Force
New-Item -Path "archetypes/series/index.md" -ItemType File -Force
```

然后，将以下内容复制到 `archetypes/series/index.md` 中。这个模板专为你的“Full Stack FastAPI Template”系列文章设计。

```yaml
---
# ==========================================
# 系列文章模板 - 用于 Full Stack FastAPI Template
# 使用方法: ./new-chapter.sh "章节标题"
# ==========================================

# 标题: 自动从文件名生成，将 "-" 替换为空格并转为标题格式
title: "{{ replace .Name "-" " " | title }}"

# 日期: 自动填充当前时间
date: {{ .Date }}

# 草稿状态: 新文章默认为草稿，防止未完成内容被发布
draft: true

# 系列名称: 固定值，用于将同一系列的文章关联起来
series: "Full Stack FastAPI Template"

# 章节权重: 控制文章在系列中的显示顺序，数字越小越靠前
# 脚本会自动根据你输入的章节号设置此值
weight: 1

# 章节编号: 便于在文章中引用和显示
chapter: "1"

# 文章描述: 简要介绍本章内容
description: ""

# 封面图片: 建议将图片放在同章节文件夹内，作为页面资源引用
image: "cover.jpg"

# 分类与标签: 用于网站的分类导航
categories: ["FastAPI", "全栈开发", "Python"]
tags: []

# 其他可选配置
# comments: true   # 是否开启评论
# math: false      # 是否需要数学公式支持
# license: ""      # 文章的特殊许可
# slug: ""         # 自定义URL，若不填则使用文件夹名

---

<!--more-->

## 本章导读

<!-- 在这里写下本章的简要介绍和学习目标 -->

## 正文内容

<!-- 从这里开始撰写你的学习笔记 -->

```

---

### 第二步：创建自动化脚本

在Hugo项目的**根目录**下，创建一个名为 `new-chapter.sh`/`New-Chapter.ps1` 的文件：

```bash
# MacOS/Linux
touch new-chapter.sh
# Windows PowerShell
New-Item -Path "New-Chapter.ps1" -ItemType File -Force
```
> 注意：脚本文件对中文可能会报错，编码设置为UTF-8，删除中文
> **作者使用的脚本为：windows powershell**测试可行

然后，将以下完整的脚本代码复制到该文件中：
#### 脚本内容MacOS/Linux
```bash
#!/bin/bash

# ==========================================
# Hugo 系列文章自动化创建脚本
# 功能: 一键创建系列文章（叶子包）
# 用法: ./new-chapter.sh "章节号. 章节标题"
# 示例: ./new-chapter.sh "1. 初识FastAPI全栈模板"
# ==========================================

# --- 配置区域 ---
# 系列文章存放的根目录（相对于 content 文件夹）
SERIES_DIR="full-stack-fastapi-template"
# 使用的 Archetype 类型
ARCHETYPE="series"

# --- 脚本开始 ---

# 检查是否提供了章节标题
if [ $# -eq 0 ]; then
    echo "❌ 错误：请提供章节标题。"
    echo "用法: $0 \"章节号. 章节标题\""
    echo "示例: $0 \"1. 初识FastAPI全栈模板\""
    exit 1
fi

# 获取用户输入的完整标题（如 "1. 初识FastAPI全栈模板"）
FULL_TITLE="$1"

# 提取章节号（数字部分）和纯文本标题
# 使用正则表达式匹配 "数字. 任意内容"
if [[ "$FULL_TITLE" =~ ^([0-9]+)\.\ (.*)$ ]]; then
    CHAPTER_NUM="${BASH_REMATCH[1]}"
    CHAPTER_TITLE="${BASH_REMATCH[2]}"
else
    echo "❌ 错误：标题格式不正确。请使用 '章节号. 章节标题' 的格式。"
    echo "示例: $0 \"1. 初识FastAPI全栈模板\""
    exit 1
fi

# 生成文件夹名称（用于URL和文件系统）
# 格式: 两位数字-标题（将空格替换为连字符）
# 示例: "01-initial-fastapi-template"
FOLDER_NAME=$(printf "%02d" "$CHAPTER_NUM")-$(echo "$CHAPTER_TITLE" | sed 's/ /-/g')

# 构建完整的文章路径
FULL_PATH="content/${SERIES_DIR}/${FOLDER_NAME}"

# 检查该章节是否已存在
if [ -d "$FULL_PATH" ]; then
    echo "⚠️  警告：章节 '${FULL_TITLE}' 已存在。"
    read -p "是否要覆盖？(y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "操作已取消。"
        exit 1
    fi
fi

# 使用 Hugo 命令创建新文章
# 注意：路径末尾不需要加 /index.md，Hugo 会自动根据 archetypes/series 目录生成
echo "🚀 正在创建新章节：${FULL_TITLE} ..."
hugo new --kind "${ARCHETYPE}" "${SERIES_DIR}/${FOLDER_NAME}"

# 检查 hugo new 命令是否执行成功
if [ $? -ne 0 ]; then
    echo "❌ 创建失败，请检查 Hugo 是否安装正确。"
    exit 1
fi

# 自动修正 index.md 中的 weight 和 chapter 字段
INDEX_FILE="${FULL_PATH}/index.md"
if [ -f "$INDEX_FILE" ]; then
    # 使用 sed 替换 weight 和 chapter 的值
    # macOS 和 Linux 的 sed 命令略有不同，这里做兼容处理
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS 需要 -i '' 和 -E 启用扩展正则
        sed -i '' -E "s/^weight: [0-9]+/weight: ${CHAPTER_NUM}/" "$INDEX_FILE"
        sed -i '' -E "s/^chapter: \"[0-9]+\"/chapter: \"${CHAPTER_NUM}\"/" "$INDEX_FILE"
    else
        # Linux 使用 -i 和 -r 启用扩展正则
        sed -i -r "s/^weight: [0-9]+/weight: ${CHAPTER_NUM}/" "$INDEX_FILE"
        sed -i -r "s/^chapter: \"[0-9]+\"/chapter: \"${CHAPTER_NUM}\"/" "$INDEX_FILE"
    fi
    echo "✅ 已自动设置 weight=${CHAPTER_NUM} 和 chapter=\"${CHAPTER_NUM}\""
else
    echo "⚠️  警告：未找到 index.md 文件，请检查创建过程。"
fi

# 输出成功信息
echo "✅ 章节创建成功！"
echo "📁 位置: ${FULL_PATH}"
echo ""
echo "下一步："
echo "1. 编辑文章: cd ${FULL_PATH} && vim index.md"
echo "2. 修改 draft: false 以发布文章"
echo "3. 添加封面图片到该文件夹（可选）"
```
#### 脚本内容Windows PowerShell
```powershell
<#
.SYNOPSIS
    Create a new Hugo series chapter (Leaf Bundle)
.DESCRIPTION
    Usage: .\New-Chapter.ps1 "1. Chapter Title"
.EXAMPLE
    .\New-Chapter.ps1 "1. Introduction to FastAPI"
#>

param([string]$Title)

$SeriesRoot = "full-stack-fastapi-template"
$ArchetypeKind = "series"

# Ensure archetype exists
$ArchetypeDir = "archetypes\$ArchetypeKind"
$ArchetypeFile = "$ArchetypeDir\index.md"
if (-not (Test-Path $ArchetypeFile)) {
    New-Item -Path $ArchetypeDir -ItemType Directory -Force | Out-Null
    $template = @"
---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
series: "Full Stack FastAPI Template"
weight: 1
chapter: "1"
description: ""
image: "cover.jpg"
categories: ["FastAPI", "全栈开发", "Python"]
tags: []
---

<!--more-->
"@
    $template | Set-Content -Path $ArchetypeFile -Encoding UTF8
}

# Parse title
if ($Title -match '^(\d+)\.\s+(.+)$') {
    $num = $matches[1]
    $name = $matches[2]
} else {
    Write-Host "ERROR: Title format must be 'number. Title' (e.g., '1. My Chapter')"
    exit 1
}

# Clean folder name
$clean = $name -replace '[^\w\-]', '-' -replace '-+', '-' -replace '^-|-$', ''
$folder = "{0:D2}-{1}" -f [int]$num, $clean
$full = "content\$SeriesRoot\$folder"

# Check existence
if (Test-Path $full) {
    $choice = Read-Host "Chapter exists. Overwrite? (y/N)"
    if ($choice -ne 'y' -and $choice -ne 'Y') { exit 0 }
    Remove-Item -Path $full -Recurse -Force
}

# Create with Hugo
Write-Host "Creating chapter: $Title"
hugo new --kind $ArchetypeKind "$SeriesRoot/$folder"

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Hugo command failed. Check Hugo installation."
    exit 1
}

# Fix weight and chapter (line-by-line replacement, more robust)
$idx = "$full\index.md"
if (Test-Path $idx) {
    $lines = Get-Content -Path $idx -Encoding UTF8
    $modified = $false
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^weight:\s*\d+') {
            $lines[$i] = "weight: $num"
            $modified = $true
            Write-Host "Updated weight to $num"
        }
        if ($lines[$i] -match '^chapter:\s*".*"') {
            $lines[$i] = "chapter: `"$num`""
            $modified = $true
            Write-Host "Updated chapter to `"$num`""
        }
    }
    if ($modified) {
        $lines | Set-Content -Path $idx -Encoding UTF8
        Write-Host "Successfully updated weight and chapter."
    } else {
        Write-Host "WARNING: weight/chapter fields not found. Please set manually."
    }
} else {
    Write-Host "ERROR: index.md not found at $idx"
    exit 1
}

Write-Host "Done! Location: $full"

```

创建完成后，**给脚本添加执行权限**：

```bash
# macOS/Linux
chmod +x new-chapter.sh
# Windows PowerShell暂时不用
```

---

### 第三步：创建系列总览页（只需一次）

在 `content/full-stack-fastapi-template/` 目录下，手动创建一个 `_index.md` 文件：

```bash
hugo new full-stack-fastapi-template/_index.md
```

然后编辑这个文件，写入整个系列的介绍，比如“正式开始学习这个 FastAPI 官方全栈项目模板”。

---

### 第四步：使用脚本创建文章

以后每次想写新章节时，只需在项目根目录运行：

```bash
# macOS/Linux
./new-chapter.sh "1. 初识FastAPI全栈模板"
# Windows PowerShell
.\New-Chapter.ps1 "1. 初识FastAPI全栈模板"

# 如果遇到 “无法加载文件，因为在此系统上禁止运行脚本” 的错误，请使用以下方式之一：
# 临时绕过策略（推荐）：
powershell -ExecutionPolicy Bypass -File .\New-Chapter.ps1 "1. 初识FastAPI全栈模板"
# 永久修改策略(管理员身份运行)：
Set-ExecutionPolicy RemoteSigned
# 然后输入 Y 确认。
```

脚本会自动完成以下所有工作：
1.  在 `content/full-stack-fastapi-template/` 下创建 `01-初识FastAPI全栈模板` 文件夹。
2.  使用 `archetypes/series` 模板在该文件夹中生成 `index.md`。
3.  自动从你的输入中提取章节号 `1`，并设置 `weight: 1` 和 `chapter: "1"`。
4.  输出成功信息，提示你接下来可以编辑文章。

最终生成的目录结构如下：

```
content/
└── full-stack-fastapi-template/      # 系列根目录 (Branch Bundle)
    ├── _index.md                      # 系列总览页 (需手动创建一次)
    ├── 01-初识FastAPI全栈模板/        # 第一章 (Leaf Bundle)
    │   ├── index.md                   # 文章内容
    │   └── cover.jpg                  # 封面图 (可选)
    ├── 02-环境搭建与项目初始化/        # 第二章 (Leaf Bundle)
    │   ├── index.md
    │   └── cover.jpg
    └── ...                            # 后续章节
```

---

### 方案优势总结

1.  **完全自动化**：一条命令创建完整的章节目录和文章文件，告别重复劳动。
2.  **格式统一**：所有文章共享同一个Archetypes模板，Front Matter字段保持一致。
3.  **智能排序**：脚本自动从标题提取章节号并设置`weight`，保证文章按正确顺序显示。
4.  **稳定可靠**：基于Hugo官方推荐的Page Bundles机制和Archetypes功能，兼容Hugo v0.49及以上版本。
5.  **跨平台兼容**：脚本同时支持macOS和Linux系统。
