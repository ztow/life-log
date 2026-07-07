#!/bin/bash
# Life Log 初始化脚本
# 用途：创建目录结构，检查依赖，配置 cron job

set -e

BASE_DIR="$HOME/Documents/生活日志"
SKILL_DIR="$HOME/.qclaw-hermes/skills/life/life-log"

echo "=== 生命日志初始化 ==="
echo ""

# 1. 创建目录结构
echo "[1/4] 创建目录结构..."
mkdir -p "$BASE_DIR/待整理"
mkdir -p "$BASE_DIR/汇总"
mkdir -p "$BASE_DIR/归档"
echo "  目录 $BASE_DIR 已就绪"

# 2. 检查命令依赖
echo "[2/4] 检查依赖..."
MISSING=""
for cmd in ffmpeg; do
  if ! command -v $cmd &>/dev/null; then
    MISSING="$MISSING $cmd"
    echo "  [缺少] $cmd"
  else
    echo "  [OK] $cmd"
  fi
done

if [ -n "$MISSING" ]; then
  echo "  警告：缺少命令:$MISSING"
  echo "  请安装后重新运行。视频处理需要 ffmpeg。"
else
  echo "  所有依赖已就绪。"
fi

# 3. 安装 skill 文件到 Hermes
echo "[3/4] 安装 Hermes skill..."
if [ -d "$SKILL_DIR" ]; then
  cp SKILL.md "$SKILL_DIR/"
  echo "  skill 已更新: $SKILL_DIR"
else
  echo "  提示: Hermes skill 目录不存在，请手动加载技能。"
  echo "  命令: hermes skill life-log"
fi

# 4. 注册 cron job
echo "[4/4] 注册定时任务..."
echo "  每天早上8点将自动整理前一天的文件"
echo "  可使用: hermes cron list 查看已注册的任务"

echo ""
echo "=== 初始化完成 ==="
echo ""
echo "你现在可以："
echo "  1. 往 $BASE_DIR/待整理/ 里放文件"
echo "  2. 对 Hermes 说：整理昨天的日志"
echo "  3. 或等待每天早上8点自动处理"
