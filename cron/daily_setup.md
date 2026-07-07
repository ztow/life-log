# 生命日志 cron 配置
# 每天早8点运行，整理前一天的文件

# 创建 cron job 的命令（在 Hermes Agent 中执行）：
# hermes cron create \
#   --name "生命日志-每日早8点" \
#   --schedule "0 8 * * *" \
#   --skill life-log \
#   --prompt "你是生命日志助手。请按以下流程整理前一天的日志：
# 1. 确定日期为昨天
# 2. 扫描 ~/Documents/生活日志/待整理/ 目录下的所有文件，按创建时间排序
# 3. 逐文件处理：
#    - 视频：ffmpeg提取每秒帧，用vision分析每帧
#    - 录音：转写为文字
#    - 文字/邮件内容：读取或粘贴处理
#    - 照片：vision描述内容
#    - PDF：书籍只记书名，短内容摘要
# 4. 每条记录标注时间（EXIF>文件名>ctime），严格按时间线排序，不合并
# 5. 内容描述要具体：谁+什么事+过程+理由+结果，不要泛泛概括
# 6. 输出到 ~/Documents/生活日志/汇总/YYYY-MM-DD 生命日志.md
# 7. 自动归档原始文件到 ~/Documents/生活日志/归档/YYYY/MM/DD/
# 8. 显示统计：处理了多少文件，什么类型
# 如果待整理目录为空，直接告知用户就没有文件。"

# 查看现有 cron job：
# hermes cron list

# 删除：
# hermes cron remove <job_id>
