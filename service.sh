#!/system/bin/sh
# 等待系统完全启动
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 1
done

LOG_DIR="/data/media/0/Android"
LOG_FILE="$LOG_DIR/log.txt"

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

OPERATOR=$(getprop gsm.operator.numeric | cut -d',' -f1 | tr -d ' ' | tr -d '\r')
echo "$(date): DEBUG: OPERATOR=\"$OPERATOR\"" >> "$LOG_FILE"

sleep 10

# 检测到指定运营商，统一执行 VoLTE 配置
case "$OPERATOR" in
    "46001" | "46000" | "46002" | "46007" | "46003" | "46005" | "46011")  
        su "setprop persist.dbg.ims_volte_enable 1"
        su "setprop persist.dbg.vt_avail_ovr 1"
        su "setprop persist.radio.nr.volte 1"
        su "setprop persist.radio.volte_enabled 1"
        su "setprop persist.radio.imsregistered 1"
        su "setprop persist.dbg.allow_ims_off 0"
        su "setprop persist.vendor.radio.vonr_enabled 1"
        su "setprop persist.vendor.radio.vonr_enabled_0 1"
        su "setprop persist.vendor.radio.vonr_enabled_1 1"
        su "setprop persist.radio.data_ltd_sys_ind 1"
        su "setprop persist.sys.cust.lte_config true"
        su "setprop persist.radio.user.edit.apn 1"
        su "setprop persist.dbg.allow_apn_edit 1"
        su "setprop persist.dbg.wfc_avail_ovr 1"
        su "setprop persist.data.iwlan.enable true"
        su "setprop persist.data.iwlan 1"

        # 重启 IMS 进程
        su -c "pkill -f ims"
        su -c "pkill -f rild"
        su -c "stop ims; start ims"
        su -c "stop rild; start rild"
        ;;
    
    *)
        # 未知运营商，跳过 VoLTE 设置
        ;;
esac