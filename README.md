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
3. Contact the author to request the CoreML model (see below)  
4. Place it into the `Models/` folder  
5. Build & run on real device (macOS or iOS)

---

## 📦 Model Access

> ❗ The trained CoreML model is **not publicly included** in this repository.

If you would like to access the model for research or educational purposes,  
please contact the author directly:

📧 **Contact:** [nRyan7](https://github.com/nRyan7)

📁 Once received, place the model file (`.mlmodel` or `.mlmodelc`) into:

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

> The toxicity classification is displayed along with intuitive emojis.  
> If the AI model's confidence is **below 50%**, the result will show as **Unknown (❓)**.


| Name                 | Toxicity | Emoji | Japanese        |
|----------------------|----------|-------|-----------------|
| Amanita muscaria     | Toxic    | 🍄     | ベニテングタケ   |
| Rubroboletus sinicus | Edible   | ✅     | シナアカアザタケ |
| Lepiota brunneoincarnata | Deadly | ☠️     | フタドクツルタケ  |
| Unknown Mushroom     | Unknown  | ❓     | 未知種            |

---

## 📄 License

This project is licensed under the MIT License.  
Feel free to use, fork, and contribute!

---

## 🙋‍♀️ Author

Made with 🍄 by **[nRyan7](https://github.com/nRyan7)**  
Feel free to open an issue or suggest a feature!
