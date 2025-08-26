# 🌈 Pixel デバイスのために 📱🍀

[![English](https://img.shields.io/badge/lang-English-blue.svg)](README.en.md)
[![中文](https://img.shields.io/badge/语言-中文-red.svg)](README.md)
[![日本語](https://img.shields.io/badge/lang-日本語-green.svg)](README.ja.md)

🚫 **注意: このページで翻訳プラグインを有効にすると、文字化けや不正確な表示が発生する場合があります！**

---

## ✨ 機能
- **5G VoLTE** の有効化  
- **IMS** の自動登録  
- 通話機能の有効化  
- キャリアのビデオ通話を強制的に無効化  

---

## 🤒 Shizuku サービス不要
- Shizuku サービスを実行すると `/data/local/tmp/shizuku/` に残留ファイルが生成されます 📄  
  → Luna などのアプリでリスク検知に引っかかる可能性があります。  
- このモジュールは **ROOT / KernelSU** 権限で動作し、Shizuku に依存しません 🤡  
- KernelSU モジュールを使うことで、より簡単かつ迅速に設定できます 👌  

---

## 🍀 対応キャリア
- 中国聯通 (China Unicom)  
- 中国電信 (China Telecom)  
- 中国移動 (China Mobile)  

---

## ⚙️ モジュールの動作フロー
1. システムが完全に起動するまで待機  
2. 現在の SIM のキャリアコードを取得・クリア  
3. 最大 60 秒のランダム遅延を挿入し、IMS サービスの準備を確実にする  
4. キャリアコードに基づき VoLTE 設定を実行  
   - **中国移動 / 中国聯通 / 中国電信** の場合 → システムプロパティを設定し、`vendor.imsd` と `ril-daemon` サービスを再起動  
   - それ以外 → 設定をスキップし、不明なキャリアとしてログに記録  
5. IMS 登録状態を確認し、成功/失敗をログに記録  
6. すべての処理と重要情報をログファイルに出力  

---

## 📄 ログ保存先
- `/data/adb/modules/wzl02/log.txt`  
- モジュールが正常に動作しない場合はログを確認してください 💞
