import Foundation

// 定义一个结构体 ClassifiedLine，用于表示一行已分类的文本
// 遵循 Identifiable 协议以便于在 SwiftUI 中列表使用
// 遵循 Hashable 协议以支持集合操作、去重等
struct ClassifiedLine: Identifiable, Hashable {
    let id = UUID() // 唯一标识符，每次创建都会生成一个新的 UUID
    let text: String // 原始文本内容
    let toxicity: ToxicityLevel // 文本对应的毒性等级（由分类器分析得出）
}
