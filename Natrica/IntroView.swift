import SwiftUI

struct IntroView: View {
    @State private var navigateToMain = false
    private let imageCount = 3
    @State private var selectedIndex = 3

    var body: some View {
        let gradient = LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0/255, green: 153/255, blue: 255/255),   // 蓝
                Color(red: 128/255, green: 0/255, blue: 255/255),   // 紫
                Color(red: 255/255, green: 0/255, blue: 102/255)    // 粉
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
        NavigationStack {
            
            VStack {
              
                HeaderView()
                Divider()
                Spacer()
                VStack(spacing: 20) {
                    TabView(selection: $selectedIndex) {
                        ForEach(0..<imageCount*3, id: \.self) { index in
                            let actualIndex = index % imageCount
                            let imageName = "Butten_\(actualIndex + 1)"
                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(2/3, contentMode: .fit)
                                    .cornerRadius(16)
                                    .shadow(radius: 8)
                                    .overlay(
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 16).stroke(gradient, lineWidth: 4)
                                            if actualIndex != 0 {
                                                Image(systemName: "lock.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 90, height: 90)
                                                    .foregroundColor(Color.yellow)
                                                    .shadow(radius: 4)
                                            }
                                            VStack {
                                                Spacer()
                                                Text(textForIndex(actualIndex))
                                                    .font(.system(size: 32))
                                                    .foregroundColor(.white)
                                                    .kerning(2)//字间距
                                                    .padding(.bottom, 20)
                                            }
                                        }
                                    )
                                    .padding(.horizontal)
                                    .tag(index)
                                    .onTapGesture {
                                        if actualIndex == 0 {
                                            navigateToMain = true
                                        }
                                    }
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 450)
                    .onAppear {
                        selectedIndex = imageCount
                    }
                    .onChange(of: selectedIndex) {
                        if selectedIndex == 0 {
                            selectedIndex = imageCount
                        } else if selectedIndex == imageCount * 2 - 1 {
                            selectedIndex = imageCount - 1
                        }
                    }
                }
            
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
    
}


#Preview {
    IntroView()
}
    private func textForIndex(_ index: Int) -> String {
        switch index {
        case 0: return "幻伞"
        case 1: return "月海之眸"
        case 2: return "伊卡水镜"
        default: return ""
        }
    }
