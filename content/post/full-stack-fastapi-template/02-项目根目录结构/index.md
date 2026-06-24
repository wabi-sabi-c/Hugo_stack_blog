---
# ==========================================
# 系列文章模板 - 用于 Full Stack FastAPI Template
# 使用方法: ./new-chapter.sh "章节标题"
#          .\New-Chapter.ps1 "章节标题"
# ==========================================

# 标题: 自动从文件名生成，将 "-" 替换为空格并转为标题格式[reference:5]
title: "02 项目根目录结构"

# 日期: 自动填充当前时间[reference:6]
date: 2026-06-23T18:19:23+08:00

# 草稿状态: 新文章默认为草稿，防止未完成内容被发布[reference:7]
# draft: true

# 系列名称: 固定值，用于将同一系列的文章关联起来
series: "Full Stack FastAPI Template"

# 章节权重: 控制文章在系列中的显示顺序，数字越小越靠前[reference:8]
# 脚本会自动根据你输入的章节号设置此值
weight: 2

# 章节编号: 便于在文章中引用和显示
chapter: "2"

# 文章描述: 简要介绍本章内容
description: "简单介绍项目根目录结构，有什么文件，什么文件夹，都是干什么的"

# 封面图片: 建议将图片放在同章节文件夹内，作为页面资源引用[reference:9]
image: "cover.jpg"

# 分类与标签: 用于网站的分类导航
categories: ["project"]
tags: ["FastAPI", "全栈开发", "Python"]

# 其他可选配置
# comments: true   # 是否开启评论
# math: false      # 是否需要数学公式支持
# license: ""      # 文章的特殊许可
# slug: ""         # 自定义URL，若不填则使用文件夹名

---

<!--more-->

## 本章导读

<!-- 在这里写下本章的简要介绍和学习目标 -->
这个项目采用 **monorepo（单体仓库）** 结构，将后端、前端以及所有基础设施配置统一放在一个仓库中管理。
项目根目录结构：

```bash

full-stack-fastapi-template/
├── .copier/              # Copier 项目生成器配置
├── .github/              # GitHub Actions CI/CD 工作流
├── .vscode/              # VS Code 编辑器配置
├── backend/              # FastAPI 后端（Python + uv）
├── frontend/             # React 前端（TypeScript + Vite + Bun）
├── hooks/                # Git 钩子脚本
├── img/                  # 项目图片资源（README 中用）
├── scripts/              # 自动化脚本
├── .env                  # 环境变量配置模板
├── .gitattributes        # Git 属性配置
├── .gitignore            # Git 忽略文件
├── .pre-commit-config.yaml # pre-commit 钩子配置
├── bun.lock              # Bun 包管理器锁文件
├── compose.override.yml  # Docker Compose 开发环境覆盖配置
├── compose.traefik.yml   # Traefik 生产环境反向代理配置
├── compose.yml           # Docker Compose 基础服务定义
├── CONTRIBUTING.md       # 贡献指南
├── copier.yml            # Copier 项目模板配置
├── deployment.md         # 部署文档
├── development.md        # 开发文档
├── LICENSE               # MIT 许可证
├── package.json          # Node.js 项目配置（主要用于 Bun）
├── pyproject.toml        # Python 项目配置（uv）
├── README.md             # 项目说明文档
├── release-notes.md      # 版本发布记录
└── uv.lock               # uv 包管理器锁文件

```


<!-- 从这里开始撰写你的学习笔记 -->

## 一、根目录详解

### 🗂️ `.copier/` — Copier 项目生成器

**作用**：Copier 是一个项目模板生成工具，类似于 `cookiecutter`。这个目录存放 Copier 的模板配置和生成脚本。

**关联工具**：Copier（Python 项目生成器）

**使用方式**：
```bash
pipx run copier copy https://github.com/fastapi/full-stack-fastapi-template my-project --trust
```
执行后会交互式询问配置项（项目名、域名、数据库密码等），自动生成完整的项目副本。
**要提前安装吗？**：
直接用 `pipx run` 一行命令运行，**不需要提前安装**。如果你想长期使用，也可以提前安装：`pipx install copier`

**不必须**：如果你只是想看看代码、学习一下，直接 Clone 就行，完全不需要 Copier(推荐，自动化程度最高)。

---

### 🗂️ `.github/` — GitHub Actions CI/CD

**作用**：存放 GitHub Actions 工作流配置文件（CI/CD 流水线）。包括自动化测试、代码检查、自动部署等流程。GitHub Actions 是 GitHub 自带的 CI/CD（持续集成/持续部署）自动化工具。

**关联工具**：GitHub Actions

**不必须**：如果你只是在本地学习，或者不想用 GitHub 的自动化功能，完全可以忽略这个目录，甚至删除它。它只在你使用 GitHub 仓库并启用 Actions 时才会生效。

---

### 🗂️ `.vscode/` — VS Code 编辑器配置

**作用**：存放 VS Code 推荐扩展列表，确保团队使用一致的开发工具。推荐扩展包括 `ruff`（Python 代码检查）、`biome`（前端代码检查）、`fastapi-vscode` 等。

**关联工具**：Visual Studio Code

**不必须**：这只是为了方便团队保持一致的开发环境。你可以用任何你喜欢的编辑器（PyCharm、Sublime、Neovim 等），完全不受影响。

---

### 🗂️ `backend/` — FastAPI 后端

**作用**：整个项目的 **Python FastAPI 后端服务**根目录。采用模块化组织，包含 API 路由、数据模型、业务逻辑和配置。

**内部结构**（简要）：
- `app/api/` — API 路由和依赖注入
- `app/core/` — 核心配置、数据库引擎、安全模块（JWT/密码哈希）
- `app/models.py` — SQLModel 数据模型定义
- `app/crud.py` — 数据库 CRUD 操作
- `app/main.py` — FastAPI 应用入口
- `pyproject.toml` — Python 项目配置（uv 包管理器）

**关联工具与库**：FastAPI、SQLModel、Pydantic、PostgreSQL、Pytest、uv

**必须**：这是项目的核心之一，没有它就没有后端服务。

---

### 🗂️ `frontend/` — React 前端

**作用**：React + TypeScript 前端应用根目录。使用 Vite 作为构建工具，Bun 作为包管理器。

**关联技术栈**：React、TypeScript、Vite、Bun、Tailwind CSS、shadcn/ui、Playwright

**必须**：前端是项目的用户界面，没有它就没有用户界面。

---

### 🗂️ `hooks/` — Git 钩子

**作用**：存放 Git 钩子脚本（如 pre-commit、pre-push），Git 钩子是在特定 Git 事件（如提交前、推送前）自动执行的脚本。用于在提交或推送前自动执行代码检查、格式化等操作。

**关联工具**：Git Hooks、pre-commit

**不必须**：这些钩子通常配合 pre-commit 工具使用，用于在提交代码前自动检查代码格式。如果你不想要这个功能，可以忽略或删除。

---

### 🗂️ `img/` — 图片资源

**作用**：存放项目 README 等文档中使用的截图和示意图。

**不必须**：这只是文档配图，删除后不影响项目运行。

---

### 🗂️ `scripts/` — 自动化脚本

**作用**：存放项目构建、部署、测试等自动化脚本（`.sh` 和 `.py` 文件）。

**不必须**：这些脚本是为了方便开发者和 CI/CD 流程使用的，你可以手动执行，也可以忽略。

---

## 二、根目录文件详解

### 📄 `.env` — 环境变量模板

**作用**：定义所有环境变量（数据库连接、域名、密钥等），是项目配置的核心。

**⚠️ 重要**：此文件包含敏感信息（数据库密码、SECRET_KEY 等），**不应提交到版本控制**。项目提供了 `.env` 作为模板，实际使用时需要根据环境修改。

**关联工具**：python-dotenv、Docker Compose

**必须**：项目运行必须依赖这个文件中的配置。项目会提供一个 .env 模板，你需要根据实际情况修改里面的值。

---

### 📄 `.gitattributes` — Git 属性

**作用**：定义 Git 如何处理特定文件（如行尾符、diff 策略等）。

**不必须**：这是为了确保跨平台（Windows/Linux/macOS）协作时文件格式一致。

---

### 📄 `.gitignore` — Git 忽略文件

**作用**：指定哪些文件和目录不被 Git 追踪（如虚拟环境、node_modules、缓存文件等）。

**必须**：没有它，你会不小心把大量不必要的文件提交到git仓库中。

---

### 📄 `.pre-commit-config.yaml` — pre-commit 钩子配置

**作用**：配置 pre-commit 框架的 Git 钩子，在提交代码前自动运行代码格式化、静态检查等任务。

**关联工具**：pre-commit（Python 代码质量工具）

**不必须**：这是一个代码质量工具，如果你不想用，可以删除此文件，并卸载 pre-commit。

---

### 📄 `bun.lock` — Bun 锁文件

**作用**：Bun 包管理器的依赖锁定文件，确保团队使用相同版本的前端依赖。

**关联工具**：Bun（JavaScript/TypeScript 包管理器和运行时）

**必须（如果使用Bun）**：它保证了依赖版本的一致性，类似 package-lock.json 或 yarn.lock。

---

### 📄 `compose.yml` — Docker Compose 基础服务定义

**作用**：定义所有 Docker 服务（后端、前端、数据库等）的基础配置。

**关联工具**：Docker Compose

**必须（如果使用Docker）**: 项目一键启动的核心文件。

---

### 📄 `compose.override.yml` — 开发环境覆盖配置

**作用**：在开发环境下覆盖 `compose.yml` 的配置，如启用热重载（watch mode）、关闭服务重启策略等。

**关联工具**：Docker Compose

**必须（开发环境）**：生产环境不会使用。

---

### 📄 `compose.traefik.yml` — Traefik 生产环境配置

**作用**：配置 Traefik 作为反向代理/负载均衡器，用于生产环境部署。Traefik 可自动处理 HTTPS 证书。

**关联工具**：Traefik、Docker Compose

**不必须**：只有当你准备部署到生产环境时才需要。

---

### 📄 `CONTRIBUTING.md` — 贡献指南

**作用**：为开源贡献者提供开发规范、PR 规则和 AI 使用策略。

**不必须**：这只是文档，不影响项目运行。

---

### 📄 `copier.yml` — Copier 模板配置

**作用**：Copier 项目生成器的主配置文件，定义了交互式问答的变量和默认值。

**关联工具**：Copier

**不必须**：只有当你使用 Copier 生成项目时才需要。

---

### 📄 `deployment.md` — 部署文档

**作用**：详细的部署指南，包括 Docker Compose 生产环境部署、Traefik 代理配置、HTTPS 证书设置等。

**不必须**：这是文档，不影响项目运行。

---

### 📄 `development.md` — 开发文档

**作用**：本地开发环境搭建指南。

**不必须**：这是文档，不影响项目运行。

---

### 📄 `LICENSE` — MIT 许可证

**作用**：声明项目采用 MIT 开源许可证。

**不必须**：对于开源项目是标准做法。

---

### 📄 `package.json` — Node.js 项目配置

**作用**：Bun/Node.js 项目的配置文件，定义依赖、脚本命令等。

**关联工具**：Bun、Node.js

**必须**：所有前端项目都需要。

---

### 📄 `pyproject.toml` — Python 项目配置

**作用**：Python 项目的配置文件（uv 包管理器），定义依赖和项目元数据。

**关联工具**：uv（Python 包管理器）、Pytest

**必须**：所有 Python 后端项目都需要。

---

### 📄 `README.md` — 项目说明

**作用**：项目的入口文档，介绍技术栈、功能特性、快速开始指南。

**不必须**：但强烈推荐，没有它别人不知道怎么用你的项目。

---

### 📄 `release-notes.md` — 版本发布记录

**作用**：记录每个版本的变更、重构、功能更新和升级日志。

**不必须**：但强烈推荐，没有它无法记录项目的历史和变化。

---

### 📄 `uv.lock` — uv 锁文件

**作用**：uv 包管理器的依赖锁定文件，确保 Python 依赖版本一致。

**关联工具**：uv（Python 包管理器）

**必须（如果使用uv）**：uv 可自动处理依赖版本，因此依赖版本一致性更易管理。

---

## 三、为什么这样设计？优劣分析

### ✅ 优势

**1. 前后端分离，独立演进**
- 后端（`backend/`）和前端（`frontend/`）完全独立，可以分别使用不同的技术栈、版本和构建工具。
- 团队可以前后端并行开发，互不阻塞。

**2. 一套配置，多环境运行**
- 通过 `compose.yml` + `compose.override.yml` + `compose.traefik.yml` 三层组合，实现开发、测试、生产环境的无缝切换。
- 开发环境支持热重载，生产环境支持负载均衡和自动 HTTPS。

**3. 现代化包管理**
- Python 使用 **uv**（极速的下一代 Python 包管理器），替代传统的 pip/poetry。
- 前端使用 **Bun**（快速的 JavaScript 运行时和包管理器），替代 npm/yarn。

**4. 完整的 CI/CD 流水线**
- `.github/` 内置 GitHub Actions 工作流，开箱即用。

**5. 项目模板化**
- 通过 Copier 实现交互式项目生成，可复用性强。

### ⚠️ 劣势

**1. 学习曲线较陡**
- 同时涉及 FastAPI、React、Docker、Traefik、GitHub Actions、uv、Bun 等多个技术栈，新手需要时间适应。

**2. 本地资源消耗大**
- Docker Compose 同时运行后端、前端、PostgreSQL、Redis、Traefik 等多个容器，对本地机器配置要求较高。

**3. 配置复杂度高**
- 环境变量分散在 `.env`、`compose.yml`、`pyproject.toml`、`package.json` 等多个文件中，排查问题需要跨文件追踪。

**4. monorepo 体积较大**
- 前后端代码、配置、文档都放在同一个仓库，克隆和构建时间相对较长。

---

> 💡 **核心原则**：这个项目最核心的部分是 `backend/`、`frontend/` 和 `compose.yml（Docker 启动用）`。其他所有文件和目录都是**辅助性**的——有的为了自动化（Copier、GitHub Actions），有的为了代码质量（pre-commit），有的为了文档说明。你可以根据自己的需要选择使用哪些，完全不必被“这么多文件”吓到。


