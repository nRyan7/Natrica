import SwiftUI
import Vision
import CoreML

class FungiClassifier: ObservableObject {
    private var model: VNCoreMLModel?

    init() {
        let config = MLModelConfiguration()
//        let imageClassifierWrapper = try? MWM_fungi(configuration: config)//26种类模型
        let imageClassifierWrapper = try? Wmw_fungi_103_4(configuration: config)//100种类模型
        guard let imageClassifier = imageClassifierWrapper else {
            print("模型加载失败：无法创建 Core ML 包装类实例")
            return
        }
        let imageClassifierModel = imageClassifier.model
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
            print("模型加载失败：无法创建 VNCoreMLModel 实例")
            return
        }
        self.model = imageClassifierVisionModel
    }

    func classify(_ image: UIImage, completion: @escaping ([ClassifiedLine]) -> Void) {
        // 如果模型尚未加载，返回错误信息
        guard let model = model else {
            completion([ClassifiedLine(text: "识别失败：模型未加载", toxicity: .unknown)])
            return
        }

        // 将 UIImage 转换为 CGImage，用于处理
        guard let cgImage = image.cgImage else {
            completion([ClassifiedLine(text: "识别失败：图片格式无效", toxicity: .unknown)])
            return
        }

        // 创建 CoreML 请求，执行模型预测
        let request = VNCoreMLRequest(model: model) { request, _ in
            // 从请求结果中提取识别结果
            if let results = request.results as? [VNClassificationObservation], !results.isEmpty {
                let filtered = results.filter { $0.confidence > 0.5 } // 筛选置信度较高结果
                let others = results.filter { $0.confidence <= 0.5 && $0.confidence > 0.01 } // 其他次要结果

                var resultLines = [ClassifiedLine]()

                // 遍历主要结果，将每项构造成带置信度与毒性等级的 ClassifiedLine
                if !filtered.isEmpty {
                    for observation in filtered {
                        let label = observation.identifier // 类别标签
                        let confidence = observation.confidence * 100 // 百分比置信度
                        let labelKey = label
                            .replacingOccurrences(of: "_", with: " ")
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                            .lowercased() // 清洗 label 作为 key
                        let toxicityLevel = ToxicityMapper.toxicity(for: labelKey)

                        // 格式化文本
                        let labelText = String(format: "%@ (%.2f%%)", label, confidence)
                        resultLines.append(ClassifiedLine(text: labelText, toxicity: toxicityLevel))
                    }
                } else {
                    // 如果无任何可信结果
                    resultLines.append(ClassifiedLine(text: "Unrecognizable", toxicity: .unknown))
                }

                // 将主要结果与次要结果组合成格式化字符串，用于展示
                let mainOutput = filtered.map {
                    String(format: "%@ (%.2f%%)", $0.identifier, $0.confidence * 100)
                }.joined(separator: "\n")
                let otherOutput = others.map {
                    String(format: "%@ (%.2f%%)", $0.identifier, $0.confidence * 100)
                }.joined(separator: "\n")

                var allOutput = ""
                if !mainOutput.isEmpty {
                    allOutput += "**Main Result**\n" + mainOutput
                }
                if !otherOutput.isEmpty {
                    if !allOutput.isEmpty { allOutput += "\n\n" }
                    allOutput += "**Others**\n" + otherOutput
                }

                // 在主线程中发布结果并调用完成回调
                DispatchQueue.main.async {
                    AllPredictionResults.shared.results = allOutput
                    completion(resultLines)
                }
            } else {
                // 无结果
                completion([ClassifiedLine(text: "No results.", toxicity: .unknown)])
            }
        }

        // 设置图像裁剪方式为居中裁剪
        request.imageCropAndScaleOption = .centerCrop

        // 创建处理器并异步执行请求
        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: .up)
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            } catch {
                completion([ClassifiedLine(text: "识别失败：\(error.localizedDescription)", toxicity: .unknown)])
            }
        }
    }
}
