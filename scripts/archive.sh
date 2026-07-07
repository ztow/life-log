#!/bin/bash
# 归档脚本 — 将已处理的文件按规则归档
# 用法: ./scripts/archive.sh <原文件路径> <日志日期(YYYY-MM-DD)>

set -e

if [ $# -lt 2 ]; then
  echo "用法: $0 <文件路径> <日志日期 YYYY-MM-DD>"
  exit 1
fi

FILE_PATH="$1"
LOG_DATE="$2"
BASE_ARCHIVE="$HOME/Documents/生活日志/归档"

# 解析日期
YEAR=$(echo "$LOG_DATE" | cut -d- -f1)
MONTH=$(echo "$LOG_DATE" | cut -d- -f2)
DAY=$(echo "$LOG_DATE" | cut -d- -f3)

TARGET_DIR="$BASE_ARCHIVE/$YEAR/$MONTH/$DAY"
mkdir -p "$TARGET_DIR"

BASENAME=$(basename "$FILE_PATH")

# 防覆盖：同名文件加时间戳
if [ -f "$TARGET_DIR/$BASENAME" ]; then
  BASENAME="${BASENAME%.*}_$(date +%H%M%S).${BASENAME##*.}"
fi

mv "$FILE_PATH" "$TARGET_DIR/$BASENAME"
echo "已归档: $TARGET_DIR/$BASENAME"
