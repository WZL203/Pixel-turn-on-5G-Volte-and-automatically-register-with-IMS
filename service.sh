#!/system/bin/sh
# 等待系统完全启动
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 1
done

# 日志文件路径
LOG_FILE="/data/adb/modules/wzl02/log.txt"

# 确保日志目录存在
mkdir -p "/data/adb/modules/wzl02" 2>/dev/null

# 记录脚本开始
echo "$(date): Script started" >> "$LOG_FILE"

# 获取运营商并清理值（去掉逗号、括号等）
OPERATOR=$(getprop gsm.operator.numeric | tr -d '(),')
echo "$(date): Raw operator value: $(getprop gsm.operator.numeric)" >> "$LOG_FILE"
echo "$(date): Cleaned operator value: $OPERATOR" >> "$LOG_FILE"

# 延迟 10 秒，确保 IMS 服务就绪
sleep 10
echo "$(date): Waited 10 seconds for system stability" >> "$LOG_FILE"

# 根据运营商执行逻辑
case "$OPERATOR" in
    "46000" | "46002" | "46007")  # 中国移动
        echo "$(date): Applying China Mobile VoLTE settings" >> "$LOG_FILE"
        setprop persist.dbg.volte_avail_ovr 1
        setprop persist.dbg.ims_volte_enable 1
        setprop persist.dbg.vt_avail_ovr 1
        setprop persist.radio.volte_enabled 1
        setprop persist.radio.nr.volte 1
        setprop persist.radio.imsregistered 1
        setprop persist.dbg.allow_ims_off 0
        echo "$(date): VoLTE properties set for China Mobile" >> "$LOG_FILE"
        
        setprop ctl.restart vendor.imsd
        echo "$(date): Restarted IMS service (vendor.imsd)" >> "$LOG_FILE"
        
        setprop ctl.restart ril-daemon
        echo "$(date): Restarted ril-daemon for China Mobile" >> "$LOG_FILE"
        ;;

    "46001")  # 中国联通
        echo "$(date): Applying China Unicom VoLTE settings" >> "$LOG_FILE"
        setprop persist.dbg.volte_avail_ovr 1
        setprop persist.dbg.ims_volte_enable 1
        setprop persist.dbg.vt_avail_ovr 1
        setprop persist.radio.volte_enabled 1
        setprop persist.radio.imsregistered 1
        setprop persist.dbg.allow_ims_off 0
        echo "$(date): VoLTE properties set for China Unicom" >> "$LOG_FILE"
        
        setprop ctl.restart vendor.imsd
        echo "$(date): Restarted IMS service (vendor.imsd)" >> "$LOG_FILE"
        
        setprop ctl.restart ril-daemon
        echo "$(date): Restarted ril-daemon for China Unicom" >> "$LOG_FILE"
        ;;

    "46003" | "46005" | "46011")  # 中国电信
        echo "$(date): Applying China Telecom VoLTE settings" >> "$LOG_FILE"
        setprop persist.dbg.volte_avail_ovr 1
        setprop persist.dbg.ims_volte_enable 1
        setprop persist.dbg.vt_avail_ovr 1
        setprop persist.radio.volte_enabled 1
        setprop persist.radio.imsregistered 1
        setprop persist.dbg.allow_ims_off 0
        echo "$(date): VoLTE properties set for China Telecom" >> "$LOG_FILE"
        
        setprop ctl.restart vendor.imsd
        echo "$(date): Restarted IMS service (vendor.imsd)" >> "$LOG_FILE"
        
        setprop ctl.restart ril-daemon
        echo "$(date): Restarted ril-daemon for China Telecom" >> "$LOG_FILE"
        ;;

    *)
        echo "$(date): Unknown operator ($OPERATOR), skipping VoLTE setup" >> "$LOG_FILE"
        ;;
esac

# 添加延迟，确保 IMS 服务重启后注册完成
sleep 10
echo "$(date): Waited 10 seconds for IMS registration" >> "$LOG_FILE"

# 检查 IMS 状态并记录（优化检查命令）
IMS_STATUS=$(dumpsys telephony.registry | grep -i "ims" | grep -E "true|1")
if [ -n "$IMS_STATUS" ]; then
    echo "$(date): IMS is registered" >> "$LOG_FILE"
else
    echo "$(date): IMS is NOT registered" >> "$LOG_FILE"
fi

# 记录脚本结束
echo "$(date): Script finished" >> "$LOG_FILE"