import UIKit
import SwiftUI

// SwiftUI 封装的 UIKit 图片选择器组件
struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary // 图片来源，默认为照片库
    var completionHandler: (UIImage?) -> Void // 图片选取完成后的回调闭包

    // 创建并返回 UIImagePickerController 实例
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType // 设置来源（相机或照片库）
        picker.delegate = context.coordinator // 设置代理为 SwiftUI 上下文中的协调器
        return picker
    }

    // SwiftUI 状态更新时调用，通常不需要处理
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // 无需更新
    }

    // 创建协调器对象，用于处理 UIKit 的代理回调
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // UIKit 的代理对象，处理用户交互事件
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker // 对应的 SwiftUI ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        // 用户取消选取图片时调用
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.completionHandler(nil) // 回调空值
            picker.dismiss(animated: true) // 关闭选择器界面
        }

        // 用户选取图片后调用
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as? UIImage // 获取原始图片
            parent.completionHandler(image) // 将图片传回给调用方
            picker.dismiss(animated: true) // 关闭选择器界面
        }
    }
}
