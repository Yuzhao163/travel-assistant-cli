# Travel Assistant CLI

美团旅行 API 命令行工具，支持酒店推荐、景点查询、火车票查询、行程规划。

## 功能

| 功能 | 说明 |
|------|------|
| 酒店推荐 | 按城市/区域/星级搜索酒店 |
| 景点推荐 | 热门景点查询 |
| 火车票 | 高铁/动车查询 |
| 行程规划 | 自由行/亲子游/CityWalk 等 |

## 安装

### 方式一：一键安装

```bash
git clone https://github.com/Yuzhao163/travel-assistant-cli.git
cd travel-assistant-cli
chmod +x install.sh
./install.sh
```

### 方式二：手动安装

```bash
# 复制脚本到 PATH
cp travel ~/.local/bin/travel
chmod +x ~/.local/bin/travel

# 确保 ~/.local/bin 在 PATH 中
export PATH="$HOME/.local/bin:$PATH"
```

## 依赖

- Python 3.7+
- urllib（标准库，无需安装）

## 使用方法

```bash
# 酒店推荐
travel -c 北京 -q "天安门附近酒店"
travel -c 上海 -q "外滩五星级酒店"
travel -c 三亚 -q "海棠湾海景酒店推荐"

# 景点查询
travel -c 北京 -q "故宫门票多少钱"
travel -c 北京 -q "北京必去景点推荐"
travel -c 杭州 -q "西湖附近景点"

# 火车票查询
travel -c 北京 -q "北京到上海高铁"
travel -c 上海 -q "上海到杭州高铁推荐"

# 行程规划
travel -c 昆明 -q "昆明7日游行程规划"
travel -c 北京 -q "北京5日亲子游推荐"
travel -c 天津 -q "天津两日游攻略"

# 输出原始 JSON（便于程序处理）
travel -c 北京 -q "天安门附近酒店" --json
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

其他城市会自动识别，无需传入 cityId。

## 完整帮助

```bash
travel --help
```

## 更新 CLI

```bash
cd travel-assistant-cli
git pull
./install.sh
```

## 项目地址

https://github.com/Yuzhao163/travel-assistant-cli
