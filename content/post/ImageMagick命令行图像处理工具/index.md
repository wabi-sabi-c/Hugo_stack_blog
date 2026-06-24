---
# ==========================================
# 使用方法：
# 模板叶子包使用
# hugo new --kind post-bundle post/your_blog_name
# ==========================================
title: "ImageMagick命令行图像处理工具"
date: 2026-06-24T10:11:27+08:00
# draft: true         # 是否为草稿
description: "批量、自动化的图像处理——当你要处理一张图时，Photoshop 是利器；当你要处理一百张图时，ImageMagick 就是答案。"
image: "cover.jpg"
categories: ["documentation"]
tags: ["工具"]
# weight: 1          # 数字越小越靠前
# comments: true        # 是否开启评论
# math: true      # 需要数学公式时取消注释
# license: ""      # 如有特殊许可，填写内容
---

<!-- 文章正文从这里开始 -->

## 📖 什么是 ImageMagick？

ImageMagick 是一款**免费、开源、跨平台**的命令行图像处理软件，支持 Windows、macOS、Linux 等主流操作系统。它的核心定位是**批量、自动化的图像处理**——当你要处理一张图时，Photoshop 是利器；当你要处理一百张图时，ImageMagick 就是答案。

它由一组命令行工具组成，支持超过 **200 种图像格式**的读写和转换，包括 JPEG、PNG、GIF、WebP、HEIC、PDF、SVG 等。你可以用它来**调整尺寸、转换格式、压缩质量、裁剪旋转、添加特效、批量处理**……几乎涵盖所有日常图片处理需求。

---

## ⚙️ 核心功能与常用命令

ImageMagick 的核心命令主要有两个：

| 命令 | 用途 | 特点 |
|------|------|------|
| **`magick`**（旧版叫 `convert`） | 处理单张图片，输出新文件 | 原图不受影响 |
| **`mogrify`** | 批量处理图片 | **直接修改原文件**，建议先备份 |

**常用操作示例：**

```powershell
# 格式转换：JPG → PNG
magick input.jpg output.png

# 调整尺寸：缩放到 800x600（等比）
magick input.jpg -resize 800x600 output.jpg

# 居中裁剪到 800x600
magick input.jpg -gravity center -extent 800x600 output.jpg

# 顺时针旋转 90 度
magick input.jpg -rotate 90 output.jpg

# 自动压缩到 200KB 以内
magick input.jpg -define jpeg:extent=200kb output.jpg

# 压缩质量：quality 值 0-100，建议 70-85
magick input.jpg -quality 80 output.jpg

# 移除 EXIF 等信息元数据，减小体积
magick input.jpg -strip output.jpg

# 批量缩放当前目录所有 JPG 到宽度 800px（等比）
magick mogrify -resize 800 *.jpg

# 批量转换当前目录所有图像格式：JPG → PNG
magick mogrify -format png *.jpg

# 生成缩略图（批量）
for ($img in Get-ChildItem *.png) { magick $img.FullName -resize 400x400 "thumb_$($img.Name)" }

# 批量旋转所有 PNG
for ($img in Get-ChildItem *.png) { magick $img.FullName -rotate 90 "rotated-$($img.Name)" }

# 查看图片信息
identify -format "%w x %h" image.jpg

# 在右下角添加水印图片
magick input.jpg -gravity southeast -draw "image Over 0,0 0,0 'watermark.png'" output.jpg

# 在图片右下角添加版权文字
magick input.jpg -gravity southeast -font Arial -pointsize 20 -fill white -annotate +10+10 "© 2026 My Blog" watermarked.jpg

# 创建纯色背景
magick -size 800x600 xc:black black-background.jpg
magick -size 800x600 xc:#3498db blue-background.jpg

# 创建渐变背景
magick -size 800x600 gradient:blue-purple gradient.jpg

# 创建带文字的占位图
magick -size 800x400 -background white -fill gray -font Arial -pointsize 48 -gravity center label:"文章封面" placeholder.jpg

# 缩放 + 压缩 + 添加水印 + 旋转
magick input.jpg -resize 800x600 -quality 85 -rotate 90 -gravity southeast -draw "text 10,10 '© 2026'" output.jpg

```


### 图片拼接

关于**图片拼接**，ImageMagick 主要有两种拼接方式：

#### 📸 垂直拼接（上下拼接）

使用 `-append` 参数将多张图片按顺序垂直拼接成一张长图。

```powershell
# 两张图垂直拼接（第一张在上，第二张在下）
magick image1.jpg image2.jpg -append vertical-output.jpg

# 多张图垂直拼接（所有 JPG 按字母顺序）
magick *.jpg -append vertical-all.jpg

# 指定顺序拼接（手动控制）
magick top.jpg mid.jpg bottom.jpg -append vertical-3.jpg
```


#### 📸 水平拼接（左右拼接）

使用 `+append` 参数将多张图片按顺序水平拼接成一张宽图。

```powershell
# 两张图水平拼接（第一张在左，第二张在右）
magick image1.jpg image2.jpg +append horizontal-output.jpg

# 多张图水平拼接（所有 PNG 按字母顺序）
magick *.png +append horizontal-all.jpg

# 指定顺序拼接
magick left.jpg center.jpg right.jpg +append horizontal-3.jpg
```


#### 📊 网格拼接（表格布局）

使用 `montage` 命令创建 N×M 的图片网格，并可添加边框和间距。

```powershell
# 2行2列网格，间距10px，边框5px
magick montage *.jpg -tile 2x2 -geometry 300x200+10+5 -frame 5 grid-output.jpg
```

| 参数 | 说明 |
|------|------|
| `-tile 2x2` | 2行2列网格 |
| `-geometry 300x200+10+5` | 每张图大小 300x200，水平和垂直间距 10px/5px |
| `-frame 5` | 每张图添加 5px 边框 |


#### 💡 在博客中的应用场景

- **制作教程对比图**（例如，优化前 vs 优化后）
  ```powershell
    magick before.jpg after.jpg +append compare.jpg

  # 带标签的对比图（使用 montage）
    magick montage before.jpg after.jpg -tile 2x1 -geometry 400x300+10+10 -label "压缩前" -label "压缩后" -frame 5 compare-labeled.jpg

  ```
- **创建组图(如系列截图、摄影集)**
  ```powershell
  magick *.jpg -append gallery.jpg
  ```
- **制作三联图（左中右布局）**
  ```powershell
  magick left.jpg center.jpg right.jpg +append triptych.jpg
  ```


#### ⚠️ 注意事项

1. **图片尺寸不一**：拼接前，建议先用 `-resize` 统一图片尺寸，否则可能出现变形或错位。
2. **图片数量较多时**：可先用 `-resize` 压缩每张图的大小，以减少内存占用。
3. **格式支持**：支持 JPG、PNG、WebP 等，输出格式由扩展名决定。


---

## 🖥️ Windows 安装指南

**方法一：包管理器安装（推荐）**

以管理员身份打开 PowerShell，执行：

```powershell
# 搜索 ImageMagick 版本
winget search imagemagick

# 安装 ImageMagick（会自动安装最新版）
winget install ImageMagick.ImageMagick
```

安装完成后**关闭并重新打开 PowerShell**，测试是否成功：

```powershell
magick -version
# 查找安装路径
where.exe magick
# 如果报错，可能是没有添加到环境变量，请手动添加
```

**方法二：官网下载安装包**

1. 访问 [ImageMagick 官网下载页](https://imagemagick.org/download/)
2. 下载适用于 Windows 的安装程序（`.exe` 文件）
3. 运行安装程序，按提示完成安装
4. **务必勾选**“Add application directory to your system path”，将 ImageMagick 添加到系统环境变量

> **版本说明**：ImageMagick 7 使用 `magick` 命令；如果你安装的是 ImageMagick 6，可以省略 `magick` 前缀，直接用 `convert`。

---

## 🚀 在 Hugo 博客中的实际应用

既然你已经把 ImageMagick 装好了，以下是几个在博客工作流中非常实用的场景：

**1. 批量优化博客图片**

新建一个 `resized` 文件夹存放输出，防止覆盖原图：

```powershell
New-Item -ItemType Directory -Force -Path resized
Get-ChildItem *.jpg, *.png | ForEach-Object {
    magick $_.FullName -auto-orient -resize 1200x -strip -quality 85 "resized\$($_.Name)"
}
```

这条命令会：自动旋转、将长边缩放到 1200 像素、移除元数据、以 85% 质量压缩。

**2. 生成响应式图片（供 `srcset` 使用）**

一次生成 400w 和 800w 两种尺寸：

```powershell
magick input.jpg -resize 400x -quality 80 input-400w.jpg
magick input.jpg -resize 800x -quality 80 input-800w.jpg
```

**3. 批量转换为 WebP 格式**

WebP 比 JPG/PNG 体积小 30%~50%：

```powershell
Get-ChildItem *.jpg, *.png | ForEach-Object {
    magick $_.FullName -quality 85 "$($_.BaseName).webp"
}
```

**4. 为系列文章生成统一封面**

批量裁剪到 1200x630 并居中：

```powershell
Get-ChildItem *.jpg | ForEach-Object {
    magick $_.FullName -resize 1200x630^ -gravity center -extent 1200x630 "cover_$($_.Name)"
}
```

---

## ⚠️ 安全提示

ImageMagick 功能强大，历史上曾发现过安全漏洞。建议：

- **保持软件为最新版本**：定期执行 `winget upgrade ImageMagick.ImageMagick`
- **处理图片时注意来源**，避免处理不可信的图片文件

---


## 更多命令[官方文档](https://imagemagick.org/command-line-tools/)
```powershell
# 批量重命名（添加前缀/后缀）
Get-ChildItem *.jpg | ForEach-Object {
    Rename-Item $_.FullName -NewName "blog-$($_.Name)"
}

# 生成 PDF（将多张图合并为 PDF）
magick image1.jpg image2.jpg image3.jpg output.pdf

# 生成 PDF 并指定页面大小
magick image.jpg -page A4 output.pdf

# 批量生成 PDF（每张图单独一页）
magick *.jpg -page A4 -quality 80 output.pdf

# 1. 批量压缩并重命名（保留原图）
Get-ChildItem *.jpg | ForEach-Object {
    magick $_.FullName -resize 1200x -quality 80 -strip "optimized-$($_.Name)"
}

# 2. 批量添加边框
Get-ChildItem *.png | ForEach-Object {
    magick $_.FullName -border 5x5 -bordercolor black "framed-$($_.Name)"
}

# 3. 批量创建缩略图（100x100 居中裁剪）
Get-ChildItem *.jpg | ForEach-Object {
    magick $_.FullName -resize 100x100^ -gravity center -extent 100x100 "thumb-$($_.Name)"
}

# 4. 批量提取第一帧（适合处理 GIF）
Get-ChildItem *.gif | ForEach-Object {
    magick $_.FullName[0] "$($_.BaseName)-firstframe.jpg"
}

# 5. 按文件大小分类压缩
Get-ChildItem *.jpg | ForEach-Object {
    $size = $_.Length / 1MB
    if ($size -gt 2) {
        magick $_.FullName -quality 70 -resize 1600x "compressed-$($_.Name)"
    } elseif ($size -gt 1) {
        magick $_.FullName -quality 80 -resize 1200x "compressed-$($_.Name)"
    } else {
        magick $_.FullName -quality 85 "compressed-$($_.Name)"
    }
}

# 添加半透明文字
magick input.jpg -gravity center -font Arial -pointsize 48 -fill "rgba(255,255,255,0.3)" -annotate +0+0 "SAMPLE" sample.jpg
```

---

### 🖼️ 创建 GIF 动画 和 🎨 图像特效与滤镜

```powershell
# 从多张图片创建 GIF（-delay 100每帧显示 1 秒（100 厘秒） -loop 0无限循环）
magick -delay 100 -loop 0 frame1.jpg frame2.jpg frame3.jpg animation.gif

# 从视频帧提取 GIF（需要先提取帧）
# 调整 GIF 大小
magick animation.gif -resize 400x animated-small.gif

# 优化 GIF（压缩体积）
magick animation.gif -layers Optimize optimized.gif


# 添加圆角（适合制作头像/卡片）
magick input.jpg -resize 200x200 -gravity center -extent 200x200 \( +clone -threshold 101% -fill white -draw "roundrectangle 0,0,200,200,20,20" \) -composite -matte avatar-rounded.png

# 模糊效果（高斯模糊）
magick input.jpg -blur 0x8 blurred.jpg

# 黑白照片
magick input.jpg -colorspace gray black-white.jpg

# 锐化
magick input.jpg -sharpen 0x1 sharp.jpg

# 添加边框
magick input.jpg -border 10x10 -bordercolor black bordered.jpg

# 添加阴影
magick input.jpg \( +clone -background black -shadow 80x5+5+5 \) +swap -background none -layers merge +repage shadow.png

# 浮雕效果
magick input.jpg -emboss 1x2 embossed.jpg

# 油画效果
magick input.jpg -paint 3 oil-painting.jpg

```

---

### 🔲 九宫格切割 和 🖌️ 添加马赛克（像素化）


#### 九宫格切割

使用 `-crop` 参数将图片按行列切割成多份。

```powershell
# 将图片平均切成 3x3 的九宫格
magick input.jpg -crop 3x3@ +repage output-%d.jpg

# 输出文件为：output-0.jpg, output-1.jpg, ..., output-8.jpg
```

| 参数 | 说明 |
|------|------|
| `-crop 3x3@` | 将图片在水平方向切成3等份，竖直方向切成3等份（共9块） |
| `+repage` | 重置图片元数据，防止裁切后的图片残留位置信息 |
| `output-%d.jpg` | `%d` 是序号占位符，从 0 开始递增 |

```powershell
# 如果不想让图片被缩放，希望按真实像素尺寸切分：
# 将图片切成每块 400x300 像素（如果图片是 1200x900）
magick input.jpg -crop 400x300 +repage output-%d.jpg

# 或者只切水平方向为3块（垂直方向不切）
magick input.jpg -crop 3x1@ +repage output-%d.jpg
```


#### 添加马赛克（像素化）

使用 `-scale` 和 `-resize` 结合实现马赛克效果：

```powershell
# 1. 先缩小（像素化），再放大回原尺寸（产生马赛克块）
magick input.jpg -scale 10% -resize 1000% mosaic.jpg

# 2. 或者用更复杂的参数控制块大小
magick input.jpg -scale 5% -resize 2000% mosaic-block.jpg
```

| 参数 | 说明 |
|------|------|
| `-scale 10%` | 缩小到原图的 10%，丢失细节 |
| `-resize 1000%` | 放大回原尺寸，产生像素块 |
| 百分比乘积 = 1 | 最终尺寸不变（10% × 1000% = 100%） |


####  只对局部区域添加马赛克

如果只想遮挡图片中某个区域（如人脸、车牌、敏感信息）：

```powershell
# 用 region 参数指定区域：宽度、高度、X坐标、Y坐标
magick input.jpg -region 200x150+300+200 -scale 10% -resize 1000% +region mosaic-region.jpg

# 参数说明：200x150 是区域大小，+300+200 是起始坐标
```


#### 📝 组合用法示例

```powershell
# 1. 九宫格切割并统一压缩
magick input.jpg -crop 3x3@ -quality 80 +repage tile-%d.jpg

# 2. 马赛克整个图片并输出 WebP
magick input.jpg -scale 8% -resize 1250% -quality 80 mosaic.webp

# 3. 马赛克局部 + 保留背景清晰（适合遮挡人脸/车牌）
magick input.jpg \
    \( -clone 0 -region 200x150+300+200 -scale 10% -resize 1000% +region \) \
    -composite mosaic-blur.jpg

# 4. 九宫格切割后拼接水印（每块都加上文字）
Get-ChildItem tile-*.jpg | ForEach-Object {
    magick $_.FullName -gravity southeast -font Arial -pointsize 20 -fill white -annotate +10+10 "© 2026" "watermarked-$($_.Name)"
}
```


#### 💡 在博客中的应用场景

- **九宫格**：制作 Instagram 风格的拼图、步骤图拆解、产品细节展示
- **马赛克**：在教程中遮挡敏感信息、制作像素化风格预览图、给人脸/车牌打码


---


## 💎 总结

ImageMagick 是你博客图片处理的“瑞士军刀”——免费、强大、可脚本化。把它装好了就不要闲置，下次遇到“要把这几十张图都压缩一下”的需求时，一条命令就能搞定，不用再一张张打开 Photoshop 了。

