# 🌈 为你的 Pixel 设备 📱🍀

[![English](https://img.shields.io/badge/lang-English-blue.svg)](README.en.md)
[![中文](https://img.shields.io/badge/语言-中文-red.svg)](README.md)
[![日本語](https://img.shields.io/badge/lang-日本語-green.svg)](README.ja.md)
[![한국어](https://img.shields.io/badge/lang-한국어-orange.svg)](README.ko.md)
[![Français](https://img.shields.io/badge/lang-Français-blue.svg)](README.fr.md)

🚫 **注意：在此页面开启翻译插件可能导致文字错乱！**

---

## ✨ 功能特性
- 开启 **5G VoLTE**
- 自动注册 **IMS**
- 拨打电话功能
- 强制关闭运营商视频通话

---

## 🤒 脱离 Shizuku 服务
- 运行 Shizuku 服务后会在 `/data/local/tmp/shizuku/` 留下残留文件 📄  
  → 可能被某些检测环境风险的软件（如 Luna）识别异常。  
- 本模块基于 **ROOT / KernelSU**，完全不依赖 Shizuku 服务 🤡  
- 使用 KernelSU 模块修改更加方便快捷 👌

---

## 🍀 支持情况
- 中国联通
- 中国电信
- 中国移动

---

## ⚙️ 模块加载流程
1. 等待系统完全启动  
2. 获取并清理当前 SIM 卡的运营商代码  
3. 随机延迟到最大 60 秒，确保 IMS 服务准备就绪  
4. 根据运营商代码执行不同的 VoLTE 配置逻辑  
   - 如果是 **移动 / 联通 / 电信** → 设置系统属性，重启 `vendor.imsd` 和 `ril-daemon` 服务  
   - 否则 → 跳过配置，并记录未知运营商  
5. 检查 IMS 注册状态，并记录是否成功  
6. 将所有操作和重要信息写入日志  

---

## 📄 日志位置
- `/data/adb/modules/wzl02/log.txt`  
- 如果模块功能未生效，请查看日志输出 💞
