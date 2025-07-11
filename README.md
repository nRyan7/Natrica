# 🌿 Natrica

> A locally-powered AI encyclopedia for identifying and exploring the world of **plants**, **fungi**, and **animals** — all from your pocket.

---

## 🧠 What is Natrica?

**Natrica** is an iOS app that transforms your device into an offline AI-powered classification tool.  
With just a photo, it can instantly identify mushrooms, plants, or animals — without any internet connection.

Built using Swift and CoreML, it's designed for **field researchers**, **nature lovers**, **students**, and anyone curious about the living world.

---

## 🚀 Features

- 🔍 **Offline AI Classification** using optimized CoreML models  
- 🍄 **Fungi**, 🌿 **Plants**, and 🐾 **Animals** recognition  
- 🌐 Multilingual UI: English, 日本語, 简体中文  
- 🎨 Sleek, futuristic, intuitive UI  
- 🧾 Supports detailed result listings with toxicity/emojis  
- 📱 No server, no tracking, 100% on-device & private  

---

## 📲 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/nRyan7/Natrica.git
   ```
2. Open `Natrica.xcodeproj` in Xcode  
3. Download the CoreML model (see below)  
4. Place it into the `Models/` folder  
5. Build & run on real device (macOS or iOS)

---

## 📦 Model Download

> ❗ Due to GitHub file size limits, the CoreML model is **not included** in this repository.

📥 Download it from:

👉 [🔗 Google Drive Model Link](https://drive.google.com/...) *(replace this with your actual link)*

📁 Place the downloaded `.mlmodelc` or `.mlmodel` into:

```
Natrica/Models/
```

---

## 📸 Screenshots

| Home | Classification | Result List |
|------|----------------|-------------|
| ![Home](screenshots/home.png) | ![Classify](screenshots/classify.png) | ![Result](screenshots/result.png) |

---

## 🛠️ Tech Stack

- [x] Swift 5.9  
- [x] CoreML  
- [x] SwiftUI  
- [x] Multilingual Support (`.lproj` + `Localizable.strings`)  
- [x] Custom image picker  
- [x] Toxicity classification mapping  

---

## 🧪 Example Output

| Name                 | Toxicity | Emoji | Japanese        |
|----------------------|----------|-------|-----------------|
| Amanita muscaria     | Toxic    | ☠️     | ベニテングタケ   |
| Rubroboletus sinicus | Edible   | ✅     | シナアカアザタケ |
| Ganoderma lucidum    | Edible   | ✅     | レイシ            |

---

## 📄 License

This project is licensed under the MIT License.  
Feel free to use, fork, and contribute!

---

## 🙋‍♀️ Author

Made with 🍄 by **[nRyan7](https://github.com/nRyan7)**  
Feel free to [open an issue](https://github.com/nRyan7/Natrica/issues) or suggest a feature!
=======
# Natrica

🧠 A locally powered AI encyclopedia for plant and animal classification.

## Features
- 🔍 Offline classification using CoreML models
- 🪴 Supports fungi, plants, animals
- 🌏 Multilingual: English, 日本語, 简体中文
- 🎨 Beautiful futuristic UI
- 💾 All data processed locally (no network needed)

## How to Use
1. Clone this repo
2. Download the model file (see below)
3. Build with Xcode and run on device

## Model Download
Due to GitHub file size limits, the model is **not included** here.  
Please download it from: [🔗 Google Drive](https://drive.google.com/...)

Place the model in:

