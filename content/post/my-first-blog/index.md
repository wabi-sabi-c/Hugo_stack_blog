---
title: "My First Blog"
description: "这是个人博客的第一篇文章就写：“项目中如何找所需的依赖包”"
date: 2026-06-15T18:26:14+08:00
image: cover.jpg
categories: [project]
tags: [project]
# draft: true            # 是否为草稿
# comments: true        # 是否开启评论
# math: true             # 需要数学公式时取消注释
# license:               # 如有特殊许可，填写内容
# build:
#     list: always    # Change to "never" to hide the page from the list
---


# 🧠 为什么你能想到这些包？答案是：不能，也不需要。
在写一个项目的时候，我相信你也有这样的疑问？尤其是刚开始的小白。其实本质还是去搜索?
这篇博客就是告诉我**去哪里搜、用什么关键词搜、搜到后怎么快速判断靠不靠谱**

<!--more-->

## 🔍 我是怎么找到这些包的？（真实过程还原）
我现在是“小白”，接到这个“拍照识别进货单”的任务，我会这样一步步搜：
### 第一步：把需求翻译成搜索关键词
脑子里的想法："我要用Python识别图片里的文字"
打开浏览器搜索/GitHub, 搜：
```bash
python OCR 识别 图片文字 开源
```

### 第二步：从搜索结果里筛选
搜索结果会告诉我几个主流选择：
| 名称        | 特点                                            |
| ----------- | ----------------------------------------------- |
| Tesseract   | Google 维护，老牌，但对中文和表格的识别效果一般 |
| EasyOCR     | 开源，支持多种语言，准确率不错                  |
| PaddleOCR   | 百度开源，中文识别最准，专门有表格识别模块      |
| 各种在线API | 百度OCR、腾讯OCR等，要钱、要联网                |

我看到"中文最准"和"表格识别"这两个关键词，马上就锁定了 PaddleOCR。

### 第三步：验证可行性
再搜：
```bash
PaddleOCR FastAPI 上传图片 识别
```
找到一堆开源项目和博客，证明这条路有人走过，可行。

### 第四步：看官方文档，确认依赖
打开 PaddleOCR 的 GitHub 页面，看到安装命令：
```bash
pip install paddleocr paddlepaddle
```
所以我知道需要 paddleocr 和 paddlepaddle 这两个包。

### 📋 其他包是怎么确定的？
| 需求         | 我怎么搜                                   | 得到什么结论                                                                                        |
| ------------ | ------------------------------------------ | --------------------------------------------------------------------------------------------------- |
| 写Excel      | "Python 操作 Excel 写入 模板"              | 主流就两个：openpyxl（操作.xlsx）和 xlsxwriter（只能写不能读）。我需要打开已有模板，所以选 openpyxl |
| 接收图片上传 | 去看 FastAPI 官方文档里的"File Upload"一章 | 文档里写着安装 python-multipart                                                                     |
| 数据库操作   | 复用之前 AI ChatFlow 项目经验              | sqlmodel + psycopg2-binary                                                                          |
| 配置管理     | 同上，复用经验                             | python-dotenv + pydantic-settings                                                                   |
| 前端网页     | 极简 H5 页面可以直接用 FastAPI 返回 HTML   | FastAPI 官方推荐 jinja2 渲染模板                                                                    |

## ✅ 所以以后可以怎么做？
在这个人工智能的时代，完全可以**直接问任何AI**，而是效率最高。专业的开发者也是这么干的：Google → 搜关键词 → 看文档 → 确定技术选型。
比如：
>"AI，我要做一个手机拍照识别进货单、自动写入Excel台账的项目，帮我列一下需要哪些Python包，简单解释一下各自的用途。"


# 本质：“遇到问题 → 翻译成关键词 → 搜索 → 筛选 → 验证”  或者  直接问AI

