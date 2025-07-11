import Foundation
import Combine // 引入 Combine 框架，用于响应式数据绑定

// 定义一个可观察对象，用于在整个应用中共享预测结果数据
class AllPredictionResults: ObservableObject {
    static let shared = AllPredictionResults() // 单例模式，方便全局访问

    @Published var results: String = "" // 使用 @Published 标记，当值改变时会通知所有监听此对象的视图自动刷新
}
