🚫在此页面开启翻译插件会有文字混乱不准情况
# 🌈为你的Pixel设备📱🍀

# 开启5G Volte✨

# 自动注册IMS✨

# 拨打电话功能✨

### 脱离依赖Shizuku服务的Pixel ims软件🤒

### 因为运行shizuku服务后 
### 会在/data/local/tmp/shizuku/留下残留文件📄，
### 导致luna隐藏软件检测到环境风险异常。

### 可拥有ROOT权限 完全不必依赖Shizuku服务的🤡

### 所以使用Kernelsu模块修改更为方便快捷👌

### 支持三网注册IMS🍀 中国联通 中国电信 中国移动

模块加载流程
1. 等待系统完全启动
2. 获取并清理当前 SIM卡的运营商代码。
3. 延迟 10 秒,确保 IMS 服务准备就绪。
4. 根据运营商代码执行不同的 VoLTE 配置逻辑: 如果运营商是中国移动、中国联通或中国电信之一,则设置一系列系统属性来启用 VoLTE,并重启 vendor.imsd 和 ril-daemon 服务,以应用配置。
5. 如果运营商代码不在预定义的列表中,则跳过 VoLTE 配置,并记录未知运营商。
6. 检查 IMS 注册状态,并记录是否成功注册。
7. 将所有操作和重要信息记录到日志文件/data/adb/ modules/pixel-volte-kernelsu/log.txt中。方便查看脚本执行情况和排查问题。

8. ### 日志📄在/data/adb/modules/wzl02/log.txt中
9. 如模块功能未生效请查看日志输出💞
