# 🌈 For Your Pixel Device 📱🍀

[![English](https://img.shields.io/badge/lang-English-blue.svg)](README.en.md)
[![中文](https://img.shields.io/badge/语言-中文-red.svg)](README.md)
[![日本語](https://img.shields.io/badge/lang-日本語-green.svg)](README.ja.md)
[![한국어](https://img.shields.io/badge/lang-한국어-orange.svg)](README.ko.md)
[![Français](https://img.shields.io/badge/lang-Français-blue.svg)](README.fr.md)

🚫 **Note: Enabling browser translation plugins on this page may cause text disorder or inaccurate display!**

---

## ✨ Features
- Enable **5G VoLTE**
- Automatic **IMS registration**
- Phone call functionality
- Force disable carrier video calling

---

## 🤒 Free from Shizuku Dependency
- Running Shizuku service leaves residual files in `/data/local/tmp/shizuku/` 📄  
  → This may trigger risk detection in apps such as Luna.  
- This module works with **ROOT / KernelSU** and does **not** depend on Shizuku 🤡  
- Using a KernelSU module makes modifications easier and faster 👌

---

## 🍀 Supported Networks
- China Unicom
- China Telecom
- China Mobile
- china guangdian
---

## ⚙️ Module Workflow
1. Wait for the system to fully boot  
2. Obtain and clear the current SIM operator code  
3. Random delay up to 60 seconds to ensure IMS service is ready  
4. Execute VoLTE configuration logic based on operator code:  
   - If operator is **China Mobile / China Unicom / China Telecom** → Set system properties, restart `vendor.imsd` and `ril-daemon` services  
   - Otherwise → Skip configuration and log unknown operator  
5. Check IMS registration status and log whether registration was successful  
6. Write all actions and key information to the log file  

---

## 📄 Log Location
- `/data/adb/modules/wzl02/log.txt`  
- If the module doesn’t take effect, please check the log output 💞
