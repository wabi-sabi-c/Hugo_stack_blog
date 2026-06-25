---
# ==========================================
# 系列文章模板 - 用于 Full Stack FastAPI Template
# 使用方法: ./new-chapter.sh "章节标题"
#          .\New-Chapter.ps1 "章节标题"
# ==========================================

# 标题: 自动从文件名生成，将 "-" 替换为空格并转为标题格式
title: "03 后端文档README文件"

# 日期: 自动填充当前时间[reference:6]
date: 2026-06-25T11:09:21+08:00

# 草稿状态: 新文章默认为草稿，防止未完成内容被发布
draft: true

# 系列名称: 固定值，用于将同一系列的文章关联起来
series: "Full Stack FastAPI Template"

# 章节权重: 控制文章在系列中的显示顺序，数字越小越靠前
# 脚本会自动根据你输入的章节号设置此值
weight: 3

# 章节编号: 便于在文章中引用和显示
chapter: "3"

# 文章描述: 简要介绍本章内容
description: "翻译并解读 backend/README.md，掌握后端开发工作流"

# 封面图片: 建议将图片放在同章节文件夹内，作为页面资源引用
image: "cover.jpg"

# 分类与标签: 用于网站的分类导航
categories: ["project"]
tags: ["FastAPI", "全栈开发", "Python"]

# 其他可选配置
# comments: true   # 是否开启评论
# math: false      # 是否需要数学公式支持
# license: ""      # 文章底部显示自定义许可证信息
slug: "backend/README.md"         # 自定义URL，若不填则使用文件夹名
# links：[]        # 文章末尾显示外部链接列表
# aliases：[]      # 允许你为该页面设置多个 URL, 定义哪些旧的链接需要跳转到新文章（放置“路标”指向新地址）
# toc: false       # 关闭文章的目录

---

<!--more-->

## 本章导读

上两章我们成功跑通了项目，并翻译了根目录的 README和查看了项目根目录结构。现在，我们要把目光聚焦到真正的代码核心——**后端服务**。

`backend/README.md` 是专门写给后端开发者的指南。它不像根目录 README 那样介绍项目整体功能，而是更侧重于**实际开发流程**：如何管理依赖、如何配置 VS Code 调试、如何执行数据库迁移、如何编写测试，以及如何处理邮件模板。

> **学习目标**：
> - 理解后端开发的标准工作流（`uv sync` + 虚拟环境）
> - 掌握 Docker Compose 开发模式下的热重载技巧
> - 了解 Alembic 数据库迁移的完整流程
> - 学会使用 Mailcatcher 和 MJML 进行邮件开发

---

## 一、backend/README.md 全文双语翻译

以下是 `backend/README.md` 的逐段双语对照翻译（原文在上，中文在下）：

---

### FastAPI Project - Backend | **FastAPI 项目 - 后端**

---

### Requirements | **环境要求**

* [Docker](https://www.docker.com/).
* [uv](https://docs.astral.sh/uv/) for Python package and environment management.
* [uv](https://docs.astral.sh/uv/) 用于 Python 包和环境管理。

---

### Docker Compose | **Docker Compose**

Start the local development environment with Docker Compose following the guide in [../development.md](../development.md).

按照 [../development.md](../development.md) 中的指南，使用 Docker Compose 启动本地开发环境。

---

### General Workflow | **通用工作流**

By default, the dependencies are managed with [uv](https://docs.astral.sh/uv/), go there and install it.

默认情况下，依赖项由 [uv](https://docs.astral.sh/uv/) 管理，请前往其官网安装。

From `./backend/` you can install all the dependencies with:

在 `./backend/` 目录下，你可以通过以下命令安装所有依赖：

```console
$ uv sync
```

Then you can activate the virtual environment with:

然后你可以通过以下命令激活虚拟环境：

```console
$ source .venv/bin/activate
```

Make sure your editor is using the correct Python virtual environment, with the interpreter at `backend/.venv/bin/python`.

请确保你的编辑器使用了正确的 Python 虚拟环境，解释器路径为 `backend/.venv/bin/python`。

Modify or add SQLModel models for data and SQL tables in `./backend/app/models.py`, API endpoints in `./backend/app/api/`, CRUD (Create, Read, Update, Delete) utils in `./backend/app/crud.py`.

在 `./backend/app/models.py` 中修改或添加 SQLModel 数据模型和 SQL 表，在 `./backend/app/api/` 中修改或添加 API 端点，在 `./backend/app/crud.py` 中修改或添加 CRUD（增删改查）工具函数。

---

### VS Code | **VS Code 配置**

There are already configurations in place to run the backend through the VS Code debugger, so that you can use breakpoints, pause and explore variables, etc.

项目已预先配置好 VS Code 调试器，你可以直接通过它运行后端，使用断点、暂停并查看变量等。

The setup is also already configured so you can run the tests through the VS Code Python tests tab.

配置也已同时支持你在 VS Code 的 Python 测试选项卡中运行测试。

---

### Docker Compose Override | **Docker Compose 覆盖配置**

During development, you can change Docker Compose settings that will only affect the local development environment in the file `compose.override.yml`.

在开发过程中，你可以通过 `compose.override.yml` 文件更改 Docker Compose 设置，这些更改仅影响本地开发环境。

The changes to that file only affect the local development environment, not the production environment. So, you can add "temporary" changes that help the development workflow.

对该文件的更改仅影响本地开发环境，不影响生产环境。因此，你可以添加有助于开发工作流的"临时"更改。

For example, the directory with the backend code is synchronized in the Docker container, copying the code you change live to the directory inside the container. That allows you to test your changes right away, without having to build the Docker image again. It should only be done during development, for production, you should build the Docker image with a recent version of the backend code. But during development, it allows you to iterate very fast.

例如，后端代码目录会与 Docker 容器同步，将你实时更改的代码复制到容器内的目录中。这样你就可以立即测试更改，而无需重新构建 Docker 镜像。这只能在开发阶段进行，生产环境应使用最新代码构建 Docker 镜像。但在开发阶段，这能让你非常快速地迭代。

There is also a command override that runs `fastapi run --reload` instead of the default `fastapi run`. It starts a single server process (instead of multiple, as would be for production) and reloads the process whenever the code changes. Have in mind that if you have a syntax error and save the Python file, it will break and exit, and the container will stop. After that, you can restart the container by fixing the error and running again:

这里还有一个命令覆盖，它运行 `fastapi run --reload` 而不是默认的 `fastapi run`。它会启动单个服务器进程（而不是生产环境中的多个进程），并在代码更改时重新加载进程。请注意，如果你有语法错误并保存了 Python 文件，程序会崩溃退出，容器也会停止。之后，你可以修复错误并重新运行以下命令来重启容器：

```console
$ docker compose watch
```

There is also a commented out `command` override, you can uncomment it and comment the default one. It makes the backend container run a process that does "nothing", but keeps the container alive. That allows you to get inside your running container and execute commands inside, for example a Python interpreter to test installed dependencies, or start the development server that reloads when it detects changes.

这里还有一个被注释掉的 `command` 覆盖，你可以取消注释并注释掉默认的那个。它会让后端容器运行一个"什么都不做"的进程，但保持容器存活。这样你就可以进入正在运行的容器内部执行命令，例如启动 Python 解释器测试已安装的依赖，或启动检测到更改时自动重载的开发服务器。

To get inside the container with a `bash` session you can start the stack with:

要进入容器并开启 `bash` 会话，你可以先用以下命令启动服务栈：

```console
$ docker compose watch
```

and then in another terminal, `exec` inside the running container:

然后在另一个终端中，执行 `exec` 进入正在运行的容器：

```console
$ docker compose exec backend bash
```

You should see an output like:

你应该会看到类似这样的输出：

```console
root@7f2607af31c3:/app#
```

that means that you are in a `bash` session inside your container, as a `root` user, under the `/app` directory, this directory has another directory called "app" inside, that's where your code lives inside the container: `/app/app`.

这意味着你在容器内以 `root` 用户身份进入了 `/app` 目录下的 `bash` 会话，该目录下还有一个名为 `app` 的子目录，那就是你代码在容器内的存放位置：`/app/app`。

There you can use the `fastapi run --reload` command to run the debug live reloading server.

在那里你可以使用 `fastapi run --reload` 命令来运行调试热重载服务器。

```console
$ fastapi run --reload app/main.py
```

...it will look like:

……看起来像这样：

```console
root@7f2607af31c3:/app# fastapi run --reload app/main.py
```

and then hit enter. That runs the live reloading server that auto reloads when it detects code changes.

然后按回车键。这将运行热重载服务器，检测到代码更改时自动重载。

Nevertheless, if it doesn't detect a change but a syntax error, it will just stop with an error. But as the container is still alive and you are in a Bash session, you can quickly restart it after fixing the error, running the same command ("up arrow" and "Enter").

然而，如果它不是检测到更改而是遇到了语法错误，它会报错停止。但由于容器仍然存活，且你处于 Bash 会话中，你可以在修复错误后快速重启它，运行同样的命令（按"上箭头"和"回车"）。

...this previous detail is what makes it useful to have the container alive doing nothing and then, in a Bash session, make it run the live reload server.

……上述细节正是让容器保持存活、然后在 Bash 会话中运行热重载服务器这种做法的便利之处。

---

### Backend tests | **后端测试**

To test the backend run:

要测试后端，请运行：

```console
$ bash ./scripts/test.sh
```

The tests run with Pytest, modify and add tests to `./backend/tests/`.

测试使用 Pytest 运行，请在 `./backend/tests/` 中修改或添加测试。

If you use GitHub Actions the tests will run automatically.

如果你使用 GitHub Actions，测试将自动运行。

#### Test running stack | **在服务栈中运行测试**

If your stack is already up and you just want to run the tests, you can use:

如果你的服务栈已经启动，只想运行测试，可以使用：

```bash
docker compose exec backend bash scripts/tests-start.sh
```

That `/app/scripts/tests-start.sh` script just calls `pytest` after making sure that the rest of the stack is running. If you need to pass extra arguments to `pytest`, you can pass them to that command and they will be forwarded.

`/app/scripts/tests-start.sh` 脚本会在确保服务栈其他部分正常运行后调用 `pytest`。如果你需要向 `pytest` 传递额外参数，可以直接加在该命令后面，它们会被转发。

For example, to stop on first error:

例如，在第一个错误处停止：

```bash
docker compose exec backend bash scripts/tests-start.sh -x
```

#### Test Coverage | **测试覆盖率**

When the tests are run, a file `htmlcov/index.html` is generated, you can open it in your browser to see the coverage of the tests.

运行测试后，会生成 `htmlcov/index.html` 文件，你可以在浏览器中打开它以查看测试覆盖率。

---

### Migrations | **数据库迁移**

As during local development your app directory is mounted as a volume inside the container, you can also run the migrations with `alembic` commands inside the container and the migration code will be in your app directory (instead of being only inside the container). So you can add it to your git repository.

由于在本地开发期间，你的应用目录会作为卷挂载到容器内，你也可以在容器内使用 `alembic` 命令运行迁移，迁移代码会位于你的应用目录中（而非仅存于容器内）。因此你可以将其添加到 git 仓库中。

Make sure you create a "revision" of your models and that you "upgrade" your database with that revision every time you change them. As this is what will update the tables in your database. Otherwise, your application will have errors.

请确保每次更改模型时都创建对应的"修订版本"，并用该修订版本"升级"你的数据库。因为这是更新数据库表的唯一方式，否则你的应用将会报错。

* Start an interactive session in the backend container:

* 在后端容器中启动交互式会话：

```console
$ docker compose exec backend bash
```

* Alembic is already configured to import your SQLModel models from `./backend/app/models.py`.

* Alembic 已配置好从 `./backend/app/models.py` 导入你的 SQLModel 模型。

* After changing a model (for example, adding a column), inside the container, create a revision, e.g.:

* 更改模型后（例如添加一列），在容器内创建修订版本，例如：

```console
$ alembic revision --autogenerate -m "Add column last_name to User model"
```

* Commit to the git repository the files generated in the alembic directory.

* 将 `alembic` 目录中生成的文件提交到 git 仓库。

* After creating the revision, run the migration in the database (this is what will actually change the database):

* 创建修订版本后，在数据库中运行迁移（这将实际更改数据库）：

```console
$ alembic upgrade head
```

If you don't want to use migrations at all, uncomment the lines in the file at `./backend/app/core/db.py` that end in:

如果你完全不想使用迁移，请取消 `./backend/app/core/db.py` 文件中以下面内容结尾的行的注释：

```python
SQLModel.metadata.create_all(engine)
```

and comment the line in the file `scripts/prestart.sh` that contains:

并注释 `scripts/prestart.sh` 文件中包含以下内容的行：

```console
$ alembic upgrade head
```

If you don't want to start with the default models and want to remove them / modify them, from the beginning, without having any previous revision, you can remove the revision files (`.py` Python files) under `./backend/app/alembic/versions/`. And then create a first migration as described above.

如果你不想使用默认模型，想从一开始就删除/修改它们，且没有之前的修订版本，你可以删除 `./backend/app/alembic/versions/` 下的修订文件（`.py` 文件）。然后按上述描述创建第一次迁移。

---

### Email Templates | **邮件模板**

The email templates are in `./backend/app/email-templates/`. Here, there are two directories: `build` and `src`. The `src` directory contains the source files that are used to build the final email templates. The `build` directory contains the final email templates that are used by the application.

邮件模板位于 `./backend/app/email-templates/`。该目录下有两个子目录：`build` 和 `src`。`src` 目录包含用于构建最终邮件模板的源文件。`build` 目录包含应用程序实际使用的最终邮件模板。

Before continuing, ensure you have the [MJML extension](https://github.com/mjmlio/vscode-mjml) installed in your VS Code.

在继续之前，请确保你在 VS Code 中安装了 [MJML 扩展](https://github.com/mjmlio/vscode-mjml)。

Once you have the MJML extension installed, you can create a new email template in the `src` directory. After creating the new email template and with the `.mjml` file open in your editor, open the command palette with `Ctrl+Shift+P` and search for `MJML: Export to HTML`. This will convert the `.mjml` file to a `.html` file and now you can save it in the build directory.

安装好 MJML 扩展后，你可以在 `src` 目录中创建新的邮件模板。创建好新的 `.mjml` 文件并在编辑器中打开后，按 `Ctrl+Shift+P` 打开命令面板，搜索 `MJML: Export to HTML`。这会将 `.mjml` 文件转换为 `.html` 文件，然后你可以将其保存到 `build` 目录中。

---

## 二、核心知识点提炼

翻译完文档，我们来划重点。这份文档实际上描绘了后端开发的**完整闭环**。

### 1. 开发模式 vs 生产模式的关键差异
| 特性 | 开发模式 (Docker Compose Override) | 生产模式 |
| :--- | :--- | :--- |
| **代码挂载** | 本地目录挂载到容器，修改即时生效 | 构建时打包进镜像，不挂载 |
| **启动命令** | `fastapi run --reload`（单进程+热重载） | `fastapi run`（多工作进程，无热重载） |
| **服务管理** | `docker compose watch` 监听文件变化 | 标准 `docker compose up` |

> **实践提示**：如果你像我一样遇到了网络问题导致 Docker 构建缓慢，文档中提到的“进入容器手动启动服务”（`docker compose exec backend bash` + `fastapi run --reload`）是一个绝佳的调试技巧，能让你绕开镜像重建的漫长等待。

### 2. 数据库迁移（Alembic）的工作流
文档详细给出了迁移四步走，这是日常开发最频繁的操作：
1. **修改模型**：在 `app/models.py` 改表结构。
2. **生成迁移文件**：`alembic revision --autogenerate -m "描述"`。
3. **审查迁移文件**：检查生成的 `versions/xxx.py` 是否符合预期。
4. **应用迁移**：`alembic upgrade head` 更新数据库表结构。

### 3. 测试策略
- **本地测试**：`bash ./scripts/test.sh`（一键运行全部）。
- **容器内测试**：`docker compose exec backend bash scripts/tests-start.sh`（服务不重启，只跑测试）。
- **覆盖率**：自动生成 `htmlcov/index.html`，可视化测试覆盖情况。

### 4. 邮件开发的现代化方案
项目放弃了在代码里拼接 HTML 字符串，而是引入了 **MJML**（一种响应式邮件标记语言）。开发者在 `src` 里写 `.mjml` 文件，通过 VS Code 插件一键导出为 `.html` 到 `build` 目录。这种方式让邮件模板的维护变得像写普通前端组件一样简单。

---

## 三、总结

`backend/README.md` 告诉我们，这个模板不仅仅是代码的堆砌，它定义了一整套**规范化的开发流程**。掌握了它，你不仅能写 API，还能安全地变更数据库、高效地调试代码、规范地编写邮件。

下一篇，我们将继续深入 `backend/`，看看后端部分又为我们准备了哪些利器。

---

