import SwiftUI

struct IntroView: View {
    @State private var navigateToMain = false

    var body: some View {
        NavigationStack {
            
            VStack {
              
                HeaderView()
                Divider()
                Spacer()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                    ForEach(0..<9) { index in
                        Button(action: {
                            print("点击按钮 \(index + 1)")
                            if index == 0 {
                                navigateToMain = true // 仅按钮 1 可触发跳转
                            }
                        }) {
                            ZStack {
                                let imageName = "Butten_\(index + 1)" // 构造图片名，例如 Butten_1 ~ Butten_9
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .aspectRatio(2/3, contentMode: .fit)
                                    .clipped()
                                    .cornerRadius(12) // 背景图圆角
                                
                                // 显示锁图标：仅非按钮 1 才加锁
                                if index != 0 {
                                    Image(systemName: "lock.fill")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(Color(red: 1.0, green: 0.76, blue: 0.0)) // 金黄色锁
                                }

                                // 渐变边框，用于视觉强调
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.orange, Color.blue]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 2
                                    )
                                    .aspectRatio(2/3, contentMode: .fit)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.9)) // 背景色，带有透明度的黑色
            .navigationDestination(isPresented: $navigateToMain) {
                ContentView() // 通过绑定变量触发导航跳转到 ContentView
            }
        }
    }

    private func HeaderView() -> some View {
        Text("Natrica")
            .font(.system(size: 32, weight: .bold))
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.green]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .shadow(color: Color.green.opacity(0.4), radius: 4, x: 2, y: 2)
    }
    
}


#Preview {
    IntroView()
}
