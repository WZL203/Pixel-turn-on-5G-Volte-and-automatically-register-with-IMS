#!/system/bin/sh
# uninstall.sh - 卸载模块脚本

# 定义模块和日志路径
MODULE_DIR="/data/adb/modules/wzl02"
LOG_FILE="/data/adb/modules/wzl02/log.txt"

# 删除模块目录并记录结果
rm -rf "$MODULE_DIR" && echo "$(date): Removed $MODULE_DIR" >> "$LOG_FILE" 2>/dev/null || echo "$(date): Failed to remove $MODULE_DIR" >> "$LOG_FILE" 2>/dev/null

# 提示完成
echo "Uninstallation done. Please reboot." >&2