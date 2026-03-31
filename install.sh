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

# 检查 requests/urllib3 是否已安装（已安装则跳过）
CHECK_PYTHON=$(python3 -c "import requests; import urllib3; print('OK')" 2>/dev/null || true)
if [[ "$CHECK_PYTHON" == "OK" ]]; then
    echo "✅ Python 依赖已满足，跳过安装"
else
    # 尝试用 python3 -m pip 安装（更可靠）
    echo "📦 安装 Python 依赖..."
    if ! python3 -m pip install requests urllib3 --break-system-packages 2>/dev/null; then
        if ! pip3 install requests urllib3 --break-system-packages 2>/dev/null; then
            if ! python3 -m pip install requests urllib3 2>/dev/null; then
                pip3 install requests urllib3
            fi
        fi
    fi
    echo "✅ 依赖安装完成"
fi

# 下载 travel 脚本和 SKILL.md
echo ""
echo "📥 下载 travel CLI..."
curl -sSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/travel" -o "${TEMP_DIR}/travel"
chmod +x "${TEMP_DIR}/travel"

echo "📥 下载 SKILL.md..."
curl -sSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/SKILL.md" -o "${TEMP_DIR}/SKILL.md" || true

# 创建安装目录
mkdir -p "$INSTALL_DIR"
mkdir -p "$HOME/.openclaw/skills/travel-assistant"

# 复制文件
cp "${TEMP_DIR}/travel" "${INSTALL_DIR}/travel"
if [[ -f "${TEMP_DIR}/SKILL.md" ]]; then
    cp "${TEMP_DIR}/SKILL.md" "$HOME/.openclaw/skills/travel-assistant/SKILL.md"
fi

# 清理
rm -rf "$TEMP_DIR"

echo ""
echo "========================================"
echo "   ✅ 安装成功!"
echo "========================================"
echo ""
echo "📍 安装路径: ${INSTALL_DIR}/travel"
echo ""
echo "📝 首次使用 - 设置 Token:"
echo "   1. 访问 https://developer.sjst.st.sankuai.com/zh/v2/dev/token 注册"
echo "   2. travel token set <your-token>"
echo ""
echo "📝 用法示例:"
echo "   travel -c 北京 -q '天安门附近酒店'"
echo "   travel -c 昆明 -q '3日游行程规划'"
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
