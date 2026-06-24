---
# ==========================================
# 使用方法：
# 模板叶子包使用
# hugo new --kind post-bundle post/your_blog_name
# ==========================================
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
# draft: true         # 是否为草稿
description: ""
image: "cover.jpg"
categories: []
tags: []
# weight: 1          # 数字越小越靠前
# comments: true        # 是否开启评论
# math: true      # 需要数学公式时取消注释
# license: ""      # 如有特殊许可，填写内容
---

<!-- 文章正文从这里开始 -->
