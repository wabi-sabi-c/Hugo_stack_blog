---
title: Hello World
description: Welcome to Hugo Theme Stack
slug: hello-world
date: 2026-03-06 00:00:00+0000
image: cover.jpg
categories:
    - documentation
tags:
    - Example Tag
# weight: 1       # You can add weight to some posts to override the default sorting (date descending)
---

欢迎使用 Hugo 主题 Stack。这是你的第一篇文章。你可以编辑或删除它，然后开始创作！

如需了解该主题的更多信息，请查阅文档：https://stack.jimmycai.com/

想要搭建同款网站？可以查看 [hugo-theme-stack-stater](https://github.com/CaiJimmy/hugo-theme-stack-starter)

> 图片由[Pawel Czerwinski](https://unsplash.com/@pawel_czerwinski) 发布于[Unsplash](https://unsplash.com/)


# 代码块测试

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}

```


```python
from pydantic import Field, SecretStr
from pydantic_settings import BaseSettings, SettingsConfigDict
from app.utils.find_project_root import find_project_root


# ---------- 1. 定位项目根目录 ----------

BASE_DIR = find_project_root()
ENV_FILE_PATH = BASE_DIR / ".env"

# ---------- 3. 配置类定义 ----------

class DatabaseSettings(BaseSettings):
    """
    数据库相关配置
    关键修改：添加 env_prefix="POSTGRES_" 以匹配 .env 文件中的变量名
    """
    model_config = SettingsConfigDict(
        env_prefix="POSTGRES_",  # <--  关键：自动匹配 POSTGRES_ 前缀
        case_sensitive=False,
        extra="ignore",
    )

    # 字段名对应 .env 中的 POSTGRES_HOST, POSTGRES_PORT 等
    host: str = Field("localhost", description="数据库主机地址")
    port: int = Field(5432, description="数据库端口")
    user: str = Field(..., description="数据库用户名")       # 匹配 POSTGRES_USER
    password: SecretStr = Field(..., description="数据库密码") # 匹配 POSTGRES_PASSWORD
    db: str = Field(..., description="数据库名称")           # 匹配 POSTGRES_DB (注意：原 .env 是 POSTGRES_DB，所以字段名改为 db 或 db_name 需对应)

    @property
    def DATABASE_URL(self) -> str:
        """动态构建数据库连接 URL"""
        # 返回 str 类型兼容性最好
        # self.password.get_secret_value() 是处理 SecretStr 类型的标准方法
        # 通常直接打印 self.password 会显示 **********，这样更安全
        return (
            f"postgresql+asyncpg://{self.user}:"
            f"{self.password}@"
            f"{self.host}:{self.port}/{self.db}"
        )
    
    @property
    def safe_url(self) -> str:
        """构建用于日志打印的脱敏 URL"""
        return (
            f"postgresql+asyncpg://{self.user}:"
            f"******@"
            f"{self.host}:{self.port}/{self.db}"
        )


class Settings(BaseSettings):
    """主配置类"""
    model_config = SettingsConfigDict(
        env_file=ENV_FILE_PATH,       # 统一在此处加载 .env
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore",
    )

    # ---------- 应用基础配置 ----------
    environment: str = Field("development", description="运行环境")
    debug: bool = Field(False, description="调试模式")

    # ---------- 数据库配置 (嵌套) ----------
    # 使用 default_factory 确保每次实例化都重新读取环境（虽然单例模式下只读一次）
    db: DatabaseSettings = Field(default_factory=DatabaseSettings)    # type: ignore[call-arg]

    # ---------- JWT 认证配置 ----------
    # 注意：确保 .env 中有 JWT_SECRET 或 JWT_SECRET_KEY 等对应变量
    jwt_secret: SecretStr = Field(..., description="JWT 签名密钥")
    jwt_algorithm: str = Field("HS256", description="JWT 签名算法")
    jwt_expire_minutes: int = Field(30, description="JWT 访问令牌过期时间（分钟）")
    jwt_refresh_expire_days: int = Field(7, description="JWT 刷新令牌过期时间（天）")

    # ---------- 多租户配置 ----------
    tenant_mode: str = Field("single", description="租户模式: single / multi")
    tenant_header: str = Field("X-Tenant-Id", description="租户标识的 HTTP 头字段名")

# ---------- 4. 创建全局单例 ----------
# 如果 Pylance 报错，请取消下面行的注释并注释掉上一行
settings = Settings()  # type: ignore[call-arg]
# settings = Settings()

# ---------- 5. 测试输出 ----------
if __name__ == "__main__":
    print(f"✅ 配置加载成功")
    print(f"Environment: {settings.environment}")
    print(f"Debug: {settings.debug}")
    print(f"DB User: {settings.db.user}")
    print(f"DB Name: {settings.db.db}")
    # 生产环境请只打印 safe_url
    print(f"Database URL (Safe): {settings.db.safe_url}") 
    print(f"JWT Algorithm: {settings.jwt_algorithm}")
    print(f"Tenant Mode: {settings.tenant_mode}")

```

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}

```

```c
#include <stdio.h>
 
int main()
{
    /* 我的第一个 C 程序 */
    printf("Hello, World! \n");
 
    return 0;
}

```

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>你好</title>
</head>
<body>
    <h1>我的第一个标题</h1>
    <p>我的第一个段落。</p>
</body>
</html>
```

```css
body {
    background-color:#d0e4fe;
}
h1 {
    color:orange;
    text-align:center;
}
p {
    font-family:"Times New Roman";
    font-size:20px;
}

```
# 标题分割线测试

{{< title "绿色标题" "green" >}}
这是绿色分割线下的内容。

{{< title "自定义颜色 #E91E63" "#E91E63" >}}
也可以使用十六进制颜色值。

# 时间线

{{< timeline >}}

{{< timeline-item date="2026-01" >}}
开始学习 Hugo，了解静态博客的优势与生态。
{{< /timeline-item >}}

{{< timeline-item date="2026-06" >}}
博客正式上线，发布第一篇技术文章。
{{< /timeline-item >}}

{{< /timeline >}}


{{< timeline-item date="2025-09" >}}
对博客主题进行了**美化改造**，添加了 `代码块折叠` 和 [主页](/Hugo_stack_blog/)。
{{< /timeline-item >}}
