# 🌈 Pixel 기기를 위해 📱🍀

[![English](https://img.shields.io/badge/lang-English-blue.svg)](README.en.md)
[![中文](https://img.shields.io/badge/语言-中文-red.svg)](README.md)
[![日本語](https://img.shields.io/badge/lang-日本語-green.svg)](README.ja.md)
[![한국어](https://img.shields.io/badge/lang-한국어-orange.svg)](README.ko.md)
[![Français](https://img.shields.io/badge/lang-Français-blue.svg)](README.fr.md)

🚫 **주의: 이 페이지에서 번역 플러그인을 켜면 텍스트가 깨지거나 잘못 표시될 수 있습니다!**

---

## ✨ 기능
- **5G VoLTE** 활성화  
- **IMS** 자동 등록  
- 통화 기능 지원  
- 통신사 영상통화 강제 비활성화  

---

## 🤒 Shizuku 서비스 불필요
- Shizuku 서비스를 실행하면 `/data/local/tmp/shizuku/` 에 잔여 파일이 생성됩니다 📄  
  → Luna 같은 앱에서 보안 위험으로 감지될 수 있습니다.  
- 이 모듈은 **ROOT / KernelSU** 권한으로 동작하며 Shizuku 에 의존하지 않습니다 🤡  
- KernelSU 모듈을 사용하는 것이 더 간단하고 빠릅니다 👌  

---

## 🍀 지원 통신사
- China Unicom (중국 유니콤)  
- China Telecom (중국 텔레콤)  
- China Mobile (중국 모바일)  

---

## ⚙️ 모듈 동작 흐름
1. 시스템이 완전히 부팅될 때까지 대기  
2. 현재 SIM 의 통신사 코드를 가져와 초기화  
3. IMS 서비스 준비를 보장하기 위해 최대 60초 랜덤 지연  
4. 통신사 코드에 따라 VoLTE 설정 실행  
   - **중국 모바일 / 유니콤 / 텔레콤** → 시스템 속성 설정 후 `vendor.imsd`, `ril-daemon` 서비스 재시작  
   - 그 외 → 설정 건너뛰고 로그에 기록  
5. IMS 등록 상태 확인 및 성공 여부 기록  
6. 모든 동작과 주요 정보를 로그 파일에 기록  

---

## 📄 로그 위치
- `/data/adb/modules/wzl02/log.txt`  
- 모듈이 동작하지 않을 경우 로그를 확인하세요 💞
