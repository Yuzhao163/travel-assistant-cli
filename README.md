# Travel Assistant CLI

美团旅行 API 命令行工具，支持酒店推荐、景点查询、火车票查询、行程规划。

## 安装

### 方式一：npm 一键安装（推荐）

```bash
npm install -g @yuzhao163/travel-assistant-cli
```

### 方式二：GitHub Packages（需要 token）

```bash
# 设置 registry
npm config set registry https://npm.pkg.github.com

# 登录（需要 GitHub Personal Access Token，scope 选 repo）
npm login --registry https://npm.pkg.github.com

# 安装
npm install -g @yuzhao163/travel-assistant-cli
```

### 方式三：Git 克隆

```bash
git clone https://github.com/Yuzhao163/travel-assistant-cli.git
cd travel-assistant-cli
chmod +x install.sh
./install.sh
```

## 更新

```bash
# npm 方式
npm update -g @yuzhao163/travel-assistant-cli

# 或手动
npm install -g @yuzhao163/travel-assistant-cli@latest
```

## 使用方法

```bash
# 酒店推荐
travel -c 北京 -q "天安门附近酒店"
travel -c 上海 -q "外滩五星级酒店"
travel -c 三亚 -q "海棠湾海景酒店推荐"

# 景点查询
travel -c 北京 -q "故宫门票多少钱"
travel -c 北京 -q "北京必去景点推荐"

# 火车票查询
travel -c 北京 -q "北京到上海高铁"

# 行程规划
travel -c 昆明 -q "3日游攻略"
travel -c 北京 -q "北京5日亲子游推荐"

# 输出原始 JSON
travel -c 北京 -q "天安门附近酒店" --json

# 查看帮助
travel --help
```

## 常用城市 ID

| 城市 | cityId | 城市 | cityId |
|------|--------|------|--------|
| 北京 | 110100 | 上海 | 310100 |
| 杭州 | 330100 | 广州 | 440100 |
| 深圳 | 440300 | 成都 | 510100 |
| 南京 | 320100 | 西安 | 610100 |
| 重庆 | 500100 | 天津 | 120100 |
| 石家庄 | 130100 | 昆明 | 530100 |
| 三亚 | 460200 | 大理 | 532900 |

城市 ID 可不传，CLI 会自动识别常用城市。

## 版本管理

发布新版本：

```bash
# 1. 更新版本号
npm version patch  # 1.0.0 -> 1.0.1
npm version minor  # 1.0.0 -> 1.1.0
npm version major  # 1.0.0 -> 2.0.0

# 2. 推送 tag
git push origin v1.0.1

# GitHub Actions 自动发布到 GitHub Packages
```

## 项目地址

https://github.com/Yuzhao163/travel-assistant-cli
