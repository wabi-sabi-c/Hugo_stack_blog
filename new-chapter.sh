#!/bin/bash

# ==========================================
# Hugo 系列文章自动化创建脚本
# 功能: 一键创建系列文章（叶子包）[reference:10]
# 用法: ./new-chapter.sh "章节号. 章节标题"
# 示例: ./new-chapter.sh "1. 初识FastAPI全栈模板"
# ==========================================

# --- 配置区域 ---
# 系列文章存放的根目录（相对于 content 文件夹）
SERIES_DIR="full-stack-fastapi-template"
# 使用的 Archetype 类型[reference:11]
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

# 使用 Hugo 命令创建新文章[reference:12]
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
