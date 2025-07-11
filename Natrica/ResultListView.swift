import SwiftUI

// 结果列表视图，用于展示所有分类后的文本行
struct ResultListView: View {
    let results: [ClassifiedLine] // 传入的已分类结果数组

    var body: some View {
        VStack(alignment: .leading, spacing: 4) { // 垂直堆叠所有结果项，左对齐，项间距为 4
            ForEach(results) { item in // 遍历每个结果项
                Text(item.toxicity.icon + " " + item.text) // 拼接毒性图标 + 文本内容
                    .font(.headline) // 设置字体为标题样式
                    .foregroundColor(item.toxicity.color) // 根据毒性设置颜色（如红色、绿色等）
            }
        }
        .padding(.leading) // 左侧内边距
    }
}
