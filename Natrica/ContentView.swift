import Foundation
import UIKit
import SwiftUI

// 自定义按钮样式结构体，符合 ButtonStyle 协议
// 实现带圆角、渐变背景、放大图标和按下缩小动画效果的按钮样式
struct RoundedIconButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 30)) // 放大图标字体大小
            .offset(x:4) // 图标略微右移
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // 充满可用空间
            .frame(width: 350, height: 50) // 固定按钮尺寸
            .background(
                LinearGradient(
//                    gradient: Gradient(colors: [Color.blue, Color.green]), // 渐变色从蓝到绿
                    gradient: Gradient(colors: [
                           Color(red: 0/255, green: 153/255, blue: 255/255),   // 蓝
                           Color(red: 128/255, green: 0/255, blue: 255/255),   // 紫
                           Color(red: 255/255, green: 0/255, blue: 102/255)    // 粉
                       ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundColor(.white) // 字体颜色白色
            .cornerRadius(20) // 圆角半径20
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0) // 按下时缩小为80%
    }
}

//  Created by Xavier Hunter on 2025/06/30.
//

import SwiftUI
import CoreML
import Vision


// 主视图结构体，负责整个界面逻辑和UI布局
struct ContentView: View {
    // 选中的图片，上传后显示和分类
    @State private var selectedImage: UIImage? = nil
    // 控制是否显示系统图片选择器
    @State private var showImagePicker = false
    // 图片选择来源，默认为相册
    @State private var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    // 分类结果数组，存储识别出的每条结果
    @State private var classificationResult: [ClassifiedLine] = []
    // 负责调用模型进行真菌分类的对象，使用 @StateObject 保证生命周期
    @StateObject private var classifier = FungiClassifier()
    // 控制是否显示全部结果弹窗
    @State private var showAllResults = false
    // 观察单例结果管理类，存储所有预测结果文本
    @ObservedObject private var allResults = AllPredictionResults.shared

//    @AppStorage("selectedLanguage") private var currentLanguage: String = Locale.current.languageCode ?? "en"
    @AppStorage("selectedLanguage") private var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    // 主界面内容封装，委托给 MainContentView 组件渲染
    private var bodyContent: some View {
        MainContentView(
            classificationResult: classificationResult,
            selectedImage: selectedImage,
            imagePickerSource: $imagePickerSource,
            showImagePicker: $showImagePicker,
            showAllResults: $showAllResults
        )
    }

    // 顶部标题视图，使用渐变颜色和阴影装饰
    private func HeaderView() -> some View {
        Text("Natrica")
            .font(.system(size: 32, weight: .bold))
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [
                           Color(red: 0/255, green: 153/255, blue: 255/255),   // 蓝
                           Color(red: 128/255, green: 0/255, blue: 255/255),   // 紫
                           Color(red: 255/255, green: 0/255, blue: 102/255)    // 粉
                       ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .shadow(color: Color.green.opacity(0.4), radius: 4, x: 2, y: 2)
    }

    // 结果区域视图，左侧显示分类结果列表，右侧显示“更多”按钮弹出全部结果
    private func ResultSectionView() -> some View {
        HStack {
            ResultListView(results: classificationResult)

            Spacer()

            // 判断是否有非空的全部结果文本，显示右上角三点按钮
            if !AllPredictionResults.shared.results.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Button(action: {
                    showAllResults = true // 点击弹出全部结果视图
                }) {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                       Color(red: 0/255, green: 153/255, blue: 255/255),   // 蓝
                                       Color(red: 128/255, green: 0/255, blue: 255/255),   // 紫
                                       Color(red: 255/255, green: 0/255, blue: 102/255)    // 粉
                                   ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
                .cornerRadius(10)
                .padding(.trailing)
            }
        }
        .padding(.vertical, 5)
    }

    // 图像预览区域，根据是否上传图片显示对应内容和边框
    private func ImagePreviewView() -> some View {
        Group {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350, height: 540)
                    .clipped()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                           Color(red: 0/255, green: 153/255, blue: 255/255),   // 蓝
                                           Color(red: 128/255, green: 0/255, blue: 255/255),   // 紫
                                           Color(red: 255/255, green: 0/255, blue: 102/255)    // 粉
                                       ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 4
                            )
                    )
            } else {
                // 未上传图片时显示灰色占位和提示文字
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 350, height: 500)
                    .overlay(Text("👉 Upload Image").foregroundColor(.gray))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                           Color(red: 0/255, green: 153/255, blue: 255/255),   // 蓝
                                           Color(red: 128/255, green: 0/255, blue: 255/255),   // 紫
                                           Color(red: 255/255, green: 0/255, blue: 102/255)    // 粉
                                       ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 4
                            )
                    )
            }
        }
    }

    // 上传按钮区域，包含从相册选择图片的按钮，使用自定义圆角按钮样式
    private func UploadButtonsView() -> some View {
        HStack {
            Button(action: {
                imagePickerSource = .photoLibrary
                showImagePicker = true // 触发显示系统图片选择器
            }) {
                Label("", systemImage: "photo")
            }
            .buttonStyle(RoundedIconButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.top, 3)
    }

    // 主视图body，委托给bodyContent，并处理弹窗显示逻辑
    var body: some View {
        bodyContent
            // 弹出系统图片选择器，选择图片后调用分类器进行识别
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: imagePickerSource) { image in
                    if let image = image {
                        selectedImage = image
                        // 异步调用分类器模型，得到分类结果后更新状态
                        classifier.classify(image) { result in
                            DispatchQueue.main.async {
                                classificationResult = result
                            }
                        }
                    }
                }
            }
            // 弹出全部结果视图，支持中等和大尺寸弹窗，带拖拽指示器
            .sheet(isPresented: $showAllResults) {
                AllResultSheetView()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
    }

    // 全部结果弹窗视图，展示分类结果和所有预测结果的文本内容
    private func AllResultSheetView() -> some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 20) {
                        Picker("Language", selection: $currentLanguage) {
                            Text("🇺🇸").font(.system(size: 20)).tag("en")
                            Text("🇨🇳").font(.system(size: 20)).tag("zh")
                            Text("🇯🇵").font(.system(size: 20)).tag("ja")
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.trailing)
                }

                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        // 遍历当前分类结果，显示带图标和颜色的文本
//                    ForEach(classificationResult) { item in
//                        Text(item.toxicity.icon + " " +
//                             ToxicityMapper.localizedName(for: item.text, lang: AppLanguage(rawValue: currentLanguage) ?? .en)
//                        )
//                            .font(.body)
//                            .foregroundColor(item.toxicity.color)
//                    }

                        ForEach(classificationResult) { item in
                            let labelOnly = item.text.components(separatedBy: " (").first ?? item.text
                            let normalized = ToxicityMapper.normalize(labelOnly)
                            let _ = {
                                if ToxicityMapper.nameMap[normalized] == nil {
                                    print("❌ nameMap 中未匹配：\(item.text) → \(normalized)")
                                } else {
                                    print("✅ 匹配成功：\(normalized)")
                                }
                            }()

                            Text(item.toxicity.icon + " " +
                                 ToxicityMapper.localizedName(for: normalized, lang: AppLanguage(rawValue: currentLanguage) ?? .en)
                            )
                            .font(.body)
                            .foregroundColor(item.toxicity.color)
                        }

                        Divider()
                            .padding(.vertical, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            // 将所有结果文本按行拆分，逐行渲染
                            let lines: [String] = allResults.results.components(separatedBy: .newlines)
                            ForEach(lines, id: \.self) { line in
                                if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    EmptyView() // 空行不显示
                                } else if line.hasPrefix("**") {
                                    // 以**开头的行作为标题，使用headline字体并增加上间距
                                    Text(line)
                                        .font(.headline)
                                        .padding(.top, 6)
                                } else {
                                    // 其他行根据标签获取毒性信息，显示对应图标和颜色
                                    let label = line
                                        .components(separatedBy: " (").first ?? ""
                                    let toxicity = ToxicityMapper.toxicity(for: label)
                                    let translated = ToxicityMapper.localizedName(for: label, lang: AppLanguage(rawValue: currentLanguage) ?? .en)
                                    let score = line.replacingOccurrences(of: label, with: "")
                                    Text(toxicity.icon + " " + translated + score)
                                        .foregroundColor(toxicity.color)
                                        .font(.system(size: 14))
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}


// 预览结构体，展示引导页 IntroView
#Preview {
    IntroView()
}


// 主内容视图结构体，封装顶部标题、结果列表、图片预览和上传按钮
private struct MainContentView: View {
    // 分类结果数组，显示识别结果列表
    let classificationResult: [ClassifiedLine]
    // 选中的图片，用于图片预览
    let selectedImage: UIImage?
    // 图片选择器来源绑定，用于控制选择来源（相册/相机）
    @Binding var imagePickerSource: UIImagePickerController.SourceType
    // 是否显示图片选择器弹窗绑定
    @Binding var showImagePicker: Bool
    // 是否显示全部结果弹窗绑定
    @Binding var showAllResults: Bool

    var body: some View {
        VStack {
            // 顶部标题，渐变色+阴影装饰
            Text("Natrica")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                               Color(red: 0/255, green: 153/255, blue: 255/255),   // 蓝
                               Color(red: 128/255, green: 0/255, blue: 255/255),   // 紫
                               Color(red: 255/255, green: 0/255, blue: 102/255)    // 粉
                           ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(color: Color.green.opacity(0.4), radius: 4, x: 2, y: 2)

            Divider()

            // 结果列表和更多按钮区域
            HStack {
                ResultListView(results: classificationResult)
                Spacer()
                if !AllPredictionResults.shared.results.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button(action: {
                        showAllResults = true // 显示全部结果弹窗
                    }) {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                           Color(red: 0/255, green: 153/255, blue: 255/255),   // 蓝
                                           Color(red: 128/255, green: 0/255, blue: 255/255),   // 紫
                                           Color(red: 255/255, green: 0/255, blue: 102/255)    // 粉
                                       ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    }
                    .cornerRadius(10)
                    .padding(.trailing)
                }
            }
            .padding(.vertical, 5)

            // 图片预览区域，显示上传的图片或占位提示
            Group {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 350, height: 540)
                        .clipped()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                               Color(red: 0/255, green: 153/255, blue: 255/255),   // 蓝
                                               Color(red: 128/255, green: 0/255, blue: 255/255),   // 紫
                                               Color(red: 255/255, green: 0/255, blue: 102/255)    // 粉
                                           ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 4
                                )
                        )
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 350, height: 500)
                        .overlay(Text("👉 Upload Image").foregroundColor(.gray))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                               Color(red: 0/255, green: 153/255, blue: 255/255),   // 蓝
                                               Color(red: 128/255, green: 0/255, blue: 255/255),   // 紫
                                               Color(red: 255/255, green: 0/255, blue: 102/255)    // 粉
                                           ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 4
                                )
                        )
                }
            }

            // 上传按钮区域，点击弹出图片选择器
            HStack {
                Button(action: {
                    imagePickerSource = .photoLibrary
                    showImagePicker = true
                }) {
                    Label("", systemImage: "photo")
                }
                .buttonStyle(RoundedIconButtonStyle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(.top, 3)
        }
        .background(Color.black.opacity(0.9)) // 背景色半透明黑色
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
