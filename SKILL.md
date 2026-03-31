---
name: travel-assistant
description: 酒店旅行助手技能，用于处理用户的所有旅行相关需求。当用户询问行程规划、机票预订、火车票推荐、交通方案、酒店推荐、酒店信息问答、门票预订、景点推荐或任何旅行咨询时触发。支持场景包括：1) 行程规划与攻略生成 2) 机票/火车票/汽车票查询与推荐 3) 酒店区域推荐、酒店信息问答、酒店预订 4) 景点门票推荐与预订 5) 交通方案规划（如机场接送、当地交通）6) 旅行咨询与问答。使用时需获取用户所在城市信息，若无法自动获取需主动询问用户。
---

# Travel Assistant Skill

## ⚠️ 首次使用：注册 Token

**使用前必须先注册并设置 Token**，否则所有查询会失败：

1. 访问 **https://developer.sjst.st.sankuai.com/zh/v2/dev/token** 注册获取 Token
2. 在终端运行：`travel token set <your-token>`
3. 确认 Token 已设置：`travel token show`

---

## Token 管理命令

```bash
travel token set <token>   # 设置 Token（只需运行一次）
travel token show          # 查看当前 Token
travel token clear         # 清除 Token
```

Token 保存在 `~/.openclaw/skills/travel-assistant/token.json`，无需重复设置。

---

## CLI 安装方式

```bash
git clone https://github.com/Yuzhao163/travel-assistant-cli.git \
  ~/.openclaw/skills/travel-assistant

cd ~/.openclaw/skills/travel-assistant
chmod +x install.sh
./install.sh
```

## CLI 常用命令

```bash
# 景点推荐
travel -c 北京 -q "有哪些必去的景点"

# 酒店推荐
travel -c 上海 -q "外滩附近五星级酒店"

# 门票查询
travel -c 北京 -q "故宫门票多少钱"

# 高铁查询
travel -c 北京 -q "北京到上海高铁"

# 行程规划（推荐）— 复杂查询，可能需要 30-180 秒
travel -c 昆明 -q "3日游攻略"
travel -c 北京 -q "北京三日游行程规划"

# 亲子游
travel -c 石家庄 -q "石家庄亲子游推荐"

# 美食推荐
travel -c 丽江 -q "丽江必吃美食餐厅推荐"

# 输出原始 JSON（程序处理用）
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
| 丽江 | 530700 | 桂林 | 450300 |

## 调用流程

1. **检查 Token** — 启动时自动检查 `token.json`，未设置则提示注册
2. **获取用户信息** — 确定用户所在城市和目标城市
3. **构建查询** — 将用户需求作为 query 参数
4. **执行 CLI** — `travel -c <城市> -q "<需求>"`
5. **补充查询** — 返回内容若缺少餐饮/酒店，追加专项查询补全

## 输出质量检查

- [ ] 每天包含：**景点 + 午/晚餐 + 住宿 + 交通**
- [ ] 餐厅有**名称 + 招牌菜**
- [ ] 酒店有**名称 + 评分 + 价格 + 特色**
- [ ] 有**天气参考**和**出行提醒**
- [ ] 行程若缺少餐饮/酒店，追加专项 CLI 查询补全

## 错误处理

| 错误类型 | 处理方式 |
|----------|----------|
| 未设置 Token | 提示访问 TOKEN_URL 注册并设置 |
| 进程超时 | 重试一次（最多2次），仍失败则降级为实时搜索 |
| 业务方服务出错 | 降级为实时搜索补充 |
| 网络超时 | 提示用户稍后重试 |
| 城市无法识别 | 询问用户确认目标城市 |
