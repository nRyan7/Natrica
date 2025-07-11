# 🌿 Natrica

> A locally-powered AI encyclopedia for identifying and exploring the world of **plants**, **fungi**, and **animals** — all from your pocket.

---

## 🧠 What is Natrica?

**Natrica** is an iOS app that transforms your device into an offline AI-powered classification tool.  
With just a photo, it can instantly identify mushrooms, plants, or animals — without any internet connection.

Built using Swift and CoreML, it's designed for **field researchers**, **nature lovers**, **students**, and anyone curious about the living world.

---

## 🚀 Features

- 🔍 **Offline AI Classification** with optimized CoreML models  
- 🍄 **Fungi**, 🌿 **Plants**, 🐾 **Animals** recognition  
- 🌐 Multilingual UI: English, 日本語, 简体中文  
- 🎨 Sleek, dreamy & futuristic UI  
- 🧾 Toxicity display with emojis  
- 🔐 100% on-device: No server, no tracking, fully private  

---

## 📲 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/nRyan7/Natrica.git
   ```
2. Open `Natrica.xcodeproj` in Xcode  
3. Contact the author to request the CoreML model (see below)  
4. Place it into the `Models/` folder  
5. Build & run on a **real device** (not simulator)

---

## 📦 Model Access

> ❗ The trained CoreML model is **not included** in this repository due to file size limits.

Currently supports **103 species of fungi**, more species in training.

If you would like access for **research or educational use**, please contact:

📧 **ranrinhk@gmail.com**

Once received, place the `.mlmodel` or `.mlmodelc` file into:

```
Natrica/Models/
```

> ⚠️ If model confidence is below **50%**, result will be shown as:  
>  
> ❓ **Unknown**

---

## 📸 Screenshots

| Home | Classification | Result List |
|------|----------------|-------------|
| ![Home](screenshots/home.png) | ![Classify](screenshots/classify.png) | ![Result](screenshots/result.png) |

---

## 🛠️ Tech Stack

- ✅ Swift 5.9  
- ✅ CoreML  
- ✅ SwiftUI  
- ✅ Multilingual Support (`.lproj` + `Localizable.strings`)  
- ✅ Toxicity-to-Emoji mapping  
- ✅ Custom image picker and result list  

---

## 🧪 Example Output

> Toxicity results are shown using intuitive icons.  
> Unknown results appear when prediction confidence < 50%.

| Name                      | Toxicity | Emoji | Japanese            |
|---------------------------|----------|-------|---------------------|
| Amanita muscaria          | Toxic    | 🍄     | ベニテングタケ       |
| Rubroboletus sinicus      | Edible   | ✅     | シナアカアザタケ     |
| Lepiota brunneoincarnata  | Deadly   | ☠️     | フタドクツルタケ      |
| Unknown Mushroom          | Unknown  | ❓     | 未知種               |

---

## 📄 License

This project is released under a **non-commercial license**:

✅ Allowed:
- Research and educational use
- Personal learning or experimentation

🚫 Not allowed:
- Commercial use of any kind
- Redistribution in paid or proprietary projects
- Use in any revenue-generating application

Please contact the author for collaboration or commercial licensing.

---

## 🙋 Author

Made with 🍄 by **[nRyan7](https://github.com/nRyan7)**  
📧 **ranrinhk@gmail.com**

Feel free to open an issue or suggest a feature!
