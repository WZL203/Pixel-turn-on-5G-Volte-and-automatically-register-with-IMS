# 🌈 为你的 Pixel 设备 📱🍀

[![English](https://img.shields.io/badge/lang-English-blue.svg)](多国自述文件/README.en.md)
[![中文](https://img.shields.io/badge/语言-中文-red.svg)](README.md)
[![日本語](https://img.shields.io/badge/lang-日本語-green.svg)](多国自述文件/README.ja.md)
[![한국어](https://img.shields.io/badge/lang-한국어-orange.svg)](多国自述文件/README.ko.md)
[![Français](https://img.shields.io/badge/lang-Français-blue.svg)](多国自述文件/README.fr.md)

🚫 **注意：在此页面开启翻译插件可能导致文字错乱！**

---

## ✨ 模块功能

- 自动开启 **5G VoLTE / IMS**
- 自动注册 IMS 服务
- 支持拨打电话功能
- 强制关闭运营商视频通话
- 设置默认 SIM 卡为 **5G SA 模式**
- 按运营商加载定制化信号阈值（SSRSRP）

---

## 🍀 支持运营商

- 中国联通（46001）
- 中国移动（46000 / 46002 / 46007）
- 中国电信（46003）
- 中国广电（46015）

---

## ⚙️ 模块加载流程

1. 等待系统完全启动  
2. 获取并清理当前 SIM 卡的运营商代码  
3. 延迟最多 60 秒，确保 IMS 服务准备就绪  
4. 根据运营商代码执行 VoLTE 配置逻辑  
5. 设置网络模式为 5G SA（Standalone）  
6. 挂载对应的 `carrier_config_＜MCCMNC＞.xml` 文件  
7. 检查 IMS 注册状态并记录日志  

---

## 📦 安装方法

1. 下载最新版本的模块 ZIP 文件  
2. 打开 Magisk → 安装模块 → 选择 ZIP 文件  
3. 安装完成后重启设备  
4. 查看日志确认是否生效

---

## 📄 日志位置

- `/data/adb/modules/wzl02/log.txt`  
- 如果模块功能未生效，请查看日志输出 💞  
- 可使用 `adb shell cat` 或文件管理器查看

---

## 🔄 自动更新支持

模块支持 GitHub 自动更新：

- `module.prop` 中已配置 `updateJson` 链接  
- GitHub 仓库需维护 `update.json` 文件，格式如下：

```json
{
  "version": "3",
  "versionCode": 3,
  "zipUrl": "https://github.com/WZL203/Pixel-turn-on-5G-Volte-and-automatically-register-with-IMS/releases/download/3/wzl02.zip",
  "changelog": "合并5G SA模式设置，增加中国广电支持，优化IMS注册逻辑",
  "minMagisk": "23000"
}
