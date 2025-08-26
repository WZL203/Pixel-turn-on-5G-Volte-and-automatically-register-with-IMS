#!/system/bin/sh
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 1
done

LOG_FILE="/data/adb/modules/wzl02/log.txt"
mkdir -p "/data/adb/modules/wzl02" 2>/dev/null
[ $(stat -c %s "$LOG_FILE" 2>/dev/null) -gt 1048576 ] && mv "$LOG_FILE" "$LOG_FILE.bak"

LOCK_FILE="/data/adb/modules/wzl02/script.lock"
if [ -f "$LOCK_FILE" ]; then
    echo "$(date): Script already running, exiting" >> "$LOG_FILE"
    exit 1
fi
touch "$LOCK_FILE"
trap 'rm -f $LOCK_FILE' EXIT

echo "$(date): Script started" >> "$LOG_FILE"

RAW_OPERATOR=$(getprop gsm.operator.numeric)
OPERATOR=$(echo "$RAW_OPERATOR" | cut -d',' -f1 | tr -d '() ')
echo "$(date): Raw operator value: $RAW_OPERATOR" >> "$LOG_FILE"
echo "$(date): Cleaned operator value: $OPERATOR" >> "$LOG_FILE"

if [ -z "$OPERATOR" ]; then
    echo "$(date): No operator detected, retrying after 10 seconds" >> "$LOG_FILE"
    sleep 10
    RAW_OPERATOR=$(getprop gsm.operator.numeric)
    OPERATOR=$(echo "$RAW_OPERATOR" | cut -d',' -f1 | tr -d '() ')
    echo "$(date): Retried - Raw operator value: $RAW_OPERATOR" >> "$LOG_FILE"
    echo "$(date): Retried - Cleaned operator value: $OPERATOR" >> "$LOG_FILE"
fi

sleep 10
echo "$(date): Waited 10 seconds for system stability" >> "$LOG_FILE"

case "$OPERATOR" in
    # 中国移动
    "46000"|"46002"|"46007")
        echo "$(date): Applying China Mobile VoLTE settings" >> "$LOG_FILE"
        ;;
    # 中国联通
    "46001")
        echo "$(date): Applying China Unicom VoLTE settings" >> "$LOG_FILE"
        ;;
    # 中国电信
    "46003")
        echo "$(date): Applying China Telecom VoLTE settings" >> "$LOG_FILE"
        ;;
    *)
        echo "$(date): Unknown operator ($OPERATOR), skipping VoLTE setup" >> "$LOG_FILE"
        echo "$(date): Script finished" >> "$LOG_FILE"
        exit 0
        ;;
esac

# 通用设置：开启VoLTE/IMS，禁用视频通话
setprop persist.dbg.volte_avail_ovr 1
setprop persist.dbg.ims_volte_enable 1
setprop persist.dbg.vt_avail_ovr 0
setprop persist.radio.volte_enabled 1
setprop persist.dbg.allow_ims_off 0
echo "$(date): VoLTE properties applied (Video Calling Disabled)" >> "$LOG_FILE"

# 重启IMS和RIL
setprop ctl.restart vendor.imsd || echo "$(date): Failed to restart IMS service" >> "$LOG_FILE"
echo "$(date): Restarted IMS service (vendor.imsd)" >> "$LOG_FILE"

setprop ctl.restart ril-daemon || echo "$(date): Failed to restart ril-daemon" >> "$LOG_FILE"
echo "$(date): Restarted ril-daemon" >> "$LOG_FILE"

SECONDS=0
until [ -n "$(dumpsys telephony.registry | grep "mImsRegistered" | grep "true")" ] || [ $SECONDS -gt 60 ]; do
    sleep 5
done
echo "$(date): Waited $SECONDS seconds for IMS registration" >> "$LOG_FILE"

IMS_STATUS=$(dumpsys telephony.registry | grep "mImsRegistered" | grep "true")
if [ -n "$IMS_STATUS" ]; then
    echo "$(date): IMS is registered" >> "$LOG_FILE"
else
    echo "$(date): IMS is NOT registered" >> "$LOG_FILE"
fi

echo "$(date): Script finished" >> "$LOG_FILE"
