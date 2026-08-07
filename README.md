# 小中医成长记

儿童中医启蒙作品集 —— 绘本 + 课程。**内容已加密，需密码访问。**

**在线阅读：** https://tczyliu.github.io/xiaozhongyi-pages/

## 目录结构

```
项目根目录/
├── site_src/               🔓 明文源文件（本地保留，绝不上传）
│   ├── book1.html
│   └── course1.html ~ course4.html
├── tools/lock.py           🔐 加密工具
└── site/                   📤 发布目录（就是 GitHub 仓库）
    ├── index.html          公开首页（不含正文内容）
    ├── book1/
    │   ├── index.html      解锁页（6.7 KB）
    │   └── data.enc        加密后的绘本（21 MB 密文）
    ├── course/
    │   ├── 1.html ~ 4.html 解锁页
    │   └── 1.enc ~ 4.enc   加密后的课程
    ├── 发布更新.sh          一键发布
    └── README.md
```

## 加密原理

- **AES-256-GCM** 加密正文，**PBKDF2-SHA256 / 20 万次迭代**从密码派生密钥
- 服务器上只有密文（`.enc`），密码从不上传、也不写在任何网页里
- 解密全在浏览器本地完成（Web Crypto API）
- 没有密码 → 查看源码、下载 `.enc` 都只能得到一串随机字节
- 密码错误 → GCM 校验失败，直接报错，无法暴力猜内容

## 怎么改密码

```bash
cd /Users/liu/WorkBuddy/2026-08-05-16-36-09
python3 tools/lock.py          # 交互式输入新密码（不回显、不留命令历史）
cd site && ./发布更新.sh "更换密码"
```

改密码后，旧密码立刻失效。已保存旧密码的设备会提示"密码不对"，重新输入新的即可。

## 怎么改内容

1. 编辑 `site_src/` 里的明文文件（**不要**直接改 `site/` 里的 `.enc`）
2. 重新加密：`python3 tools/lock.py`
3. 发布：`cd site && ./发布更新.sh "更新了某某内容"`

## 怎么加新作品

1. 新 HTML 放进 `site_src/`，例如 `book2.html`
2. 编辑 `tools/lock.py`，在 `ITEMS` 和 `PAGE_PATHS` 里各加一行
3. 编辑 `site/index.html`，复制一张卡片改标题和链接
4. `python3 tools/lock.py` → `cd site && ./发布更新.sh "新增第二册绘本"`

## 注意事项

- **`site_src/` 绝不能提交到 git**，它在仓库目录之外，正常操作不会被带上
- 单个文件上限 100 MB（GitHub 硬限制），仓库建议控制在 1 GB 内
- 免费额度每月 100 GB 流量，家庭自用远远够
- 首页是公开的（只有标题和简介，不含正文），已加 `noindex` 防搜索引擎收录

## 内容定位

养生科普 + 文化启蒙，**不教治病**。全套内容贯穿安全红线：
绝不自己采药吃药、穴位只轻揉、身体真不舒服要看医生。
