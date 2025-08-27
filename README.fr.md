# 🌈 Pour votre appareil Pixel 📱🍀

[![English](https://img.shields.io/badge/lang-English-blue.svg)](README.en.md)
[![中文](https://img.shields.io/badge/语言-中文-red.svg)](README.md)
[![日本語](https://img.shields.io/badge/lang-日本語-green.svg)](README.ja.md)
[![한국어](https://img.shields.io/badge/lang-한국어-orange.svg)](README.ko.md)
[![Français](https://img.shields.io/badge/lang-Français-blue.svg)](README.fr.md)

🚫 **Attention : L’utilisation de plugins de traduction sur cette page peut provoquer des erreurs ou une mauvaise mise en page !**

---

## ✨ Fonctionnalités
- Activer **5G VoLTE**  
- Enregistrement automatique **IMS**  
- Fonction d’appel vocal  
- Désactivation forcée des appels vidéo opérateur  

---

## 🤒 Sans dépendance à Shizuku
- L’exécution du service Shizuku laisse des fichiers résiduels dans `/data/local/tmp/shizuku/` 📄  
  → Cela peut être détecté comme un risque par certaines applications (ex : Luna).  
- Ce module fonctionne avec les droits **ROOT / KernelSU** et ne dépend pas de Shizuku 🤡  
- Utiliser un module KernelSU rend la configuration plus simple et plus rapide 👌  

---

## 🍀 Opérateurs pris en charge
- China Unicom  
- China Telecom  
- China Mobile  

---

## ⚙️ Processus de fonctionnement du module
1. Attendre le démarrage complet du système  
2. Obtenir et effacer le code opérateur SIM actuel  
3. Délai aléatoire jusqu’à 60 secondes pour s’assurer que le service IMS est prêt  
4. Exécuter la logique VoLTE selon le code opérateur :  
   - Si opérateur est **China Mobile / China Unicom / China Telecom** → Définir les propriétés système et redémarrer les services `vendor.imsd` et `ril-daemon`  
   - Sinon → Ignorer la configuration et enregistrer l’opérateur inconnu  
5. Vérifier l’état d’enregistrement IMS et consigner le résultat  
6. Enregistrer toutes les actions et informations clés dans un fichier journal  

---

## 📄 Emplacement du journal
- `/data/adb/modules/wzl02/log.txt`  
- Si le module ne fonctionne pas, consultez le journal 💞
