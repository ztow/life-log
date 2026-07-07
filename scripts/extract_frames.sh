#!/bin/bash
# 视频抽帧辅助脚本
# 用法: ./scripts/extract_frames.sh <视频路径> [输出目录]
# 默认在 /tmp/life-log-frames/ 输出

set -e

INPUT="$1"
if [ -z "$INPUT" ]; then
  echo "用法: $0 <视频文件路径> [输出目录]"
  exit 1
fi

OUTPUT_DIR="${2:-/tmp/life-log-frames}"
mkdir -p "$OUTPUT_DIR"

BASENAME=$(basename "$INPUT")
echo "视频: $BASENAME"
echo "抽帧到: $OUTPUT_DIR/"

DURATION=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$INPUT" 2>/dev/null)
echo "时长: $(echo "$DURATION" | awk '{printf "%02d:%02d", $1/60, $1%60}')"

ffmpeg -i "$INPUT" -vf fps=1 "$OUTPUT_DIR/frame_%03d.jpg" -y -hide_banner -loglevel error

COUNT=$(ls "$OUTPUT_DIR"/frame_*.jpg 2>/dev/null | wc -l | xargs)
echo "提取 $COUNT 帧"
echo "完成"
