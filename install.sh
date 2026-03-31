#!/usr/bin/env bash
#===============================================
# Travel Assistant CLI - GitHub 一键安装脚本
# 使用方式: 
#   curl -sSL https://raw.githubusercontent.com/Yuzhao163/travel-assistant-cli/main/install.sh | bash
#   或
#   bash <(curl -sSL https://raw.githubusercontent.com/Yuzhao163/travel-assistant-cli/main/install.sh)
#===============================================
set -e

INSTALL_DIR="${HOME}/.local/bin"
TEMP_DIR=$(mktemp -d)
REPO="Yuzhao163/travel-assistant-cli"
BRANCH="main"

echo "========================================"
echo "   Travel Assistant CLI 一键安装"
echo "========================================"
echo ""

# 检测操作系统
OS_TYPE=$(uname -s)
if [[ "$OS_TYPE" == "Darwin" ]]; then
    PLATFORM="macOS"
elif [[ "$OS_TYPE" == "Linux" ]]; then
    PLATFORM="Linux"
else
    echo "❌ 不支持的操作系统: $OS_TYPE"
    exit 1
fi
echo "🖥️  系统: $PLATFORM"

# 检测 Python3
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 未找到 python3，请先安装 Python3"
    echo "   macOS: brew install python3"
    echo "   Ubuntu: sudo apt install python3 python3-pip"
    exit 1
fi
echo "✅ Python3: $(python3 --version)"

# 检测 pip3
if ! command -v pip3 &> /dev/null; then
    echo "❌ 错误: 未找到 pip3，请先安装"
    echo "   pip3 install requests urllib3"
    exit 1
fi
echo "✅ pip3 已安装"

# 安装依赖
echo ""
echo "📦 安装 Python 依赖..."
pip3 install requests urllib3 --quiet 2>/dev/null || pip3 install requests urllib3
echo "✅ 依赖安装完成"

# 下载 travel 脚本和 SKILL.md
echo ""
echo "📥 下载 travel CLI..."
curl -sSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/travel" -o "${TEMP_DIR}/travel"
chmod +x "${TEMP_DIR}/travel"

echo "📥 下载 SKILL.md..."
curl -sSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/SKILL.md" -o "${TEMP_DIR}/SKILL.md"

# 创建安装目录
mkdir -p "$INSTALL_DIR"
mkdir -p "$HOME/.openclaw/skills/travel-assistant"

# 复制脚本
cp "${TEMP_DIR}/travel" "${INSTALL_DIR}/travel"
cp "${TEMP_DIR}/SKILL.md" "$HOME/.openclaw/skills/travel-assistant/SKILL.md"

# 清理
rm -rf "$TEMP_DIR"

echo ""
echo "========================================"
echo "   ✅ 安装成功!"
echo "========================================"
echo ""
echo "📍 安装路径: ${INSTALL_DIR}/travel"
echo ""
echo "📝 用法示例:"
echo "   travel -c 北京 -q '天安门附近酒店'"
echo "   travel -c 上海 -q '外滩五星级酒店'"
echo "   travel -c 昆明 -q '3日游行程规划'"
echo "   travel -c 北京 -q '北京到上海高铁'"
echo ""

# 检查 PATH
if [[ ":$PATH:" == *":${INSTALL_DIR}:"* ]]; then
    echo "✅ PATH 已包含安装目录"
else
    echo "⚠️  请将以下命令添加到 ~/.bashrc 或 ~/.zshrc:"
    echo ""
    echo "   export PATH=\"\${HOME}/.local/bin:\${PATH}\""
    echo ""
fi

echo "========================================"
