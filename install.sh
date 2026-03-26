#!/usr/bin/env bash
set -e

echo "📦 安装 Travel Assistant CLI..."

# 探测 Python3
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 未找到 python3，请先安装 Python3"
    exit 1
fi

# 探测 pip3
if ! command -v pip3 &> /dev/null; then
    echo "❌ 错误: 未找到 pip3，请先安装 pip3"
    exit 1
fi

# 安装依赖
echo "📦 安装依赖..."
pip3 install requests urllib3 2>/dev/null || true

# 确定安装目录
DEST="${1:-$HOME/.local/bin}"
mkdir -p "$DEST"

# 复制脚本
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "$SCRIPT_DIR/travel" "$DEST/travel"
chmod +x "$DEST/travel"

echo "✅ 安装成功!"
echo ""
echo "安装路径: $DEST/travel"
echo ""
echo "用法示例:"
echo "  travel -c 北京 -q '天安门附近酒店'"
echo "  travel -c 上海 -q '外滩五星级酒店'"
echo "  travel -c 昆明 -q '3日游行程规划'"
echo "  travel -c 北京 -q '北京到上海高铁'"
echo ""
echo "添加到 PATH（如果尚未包含）:"
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
echo ""
echo "或在 ~/.bashrc 或 ~/.zshrc 中永久添加以上行"
