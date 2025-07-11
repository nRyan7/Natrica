//
//  textUI.swift
//  MicroWorld
//
//  Created by Xavier Hunter on 2025/07/02.
//

import SwiftUI

struct textUI: View {
    @State private var showSystemSheet = false
    @State private var showCustomSheet = false
    @State private var showPopover = false

    var body: some View {
        VStack(spacing: 20) {
            Button("系统风格卡片（.presentationDetents）") {
                showSystemSheet = true
            }
            .sheet(isPresented: $showSystemSheet) {
                SampleCardView()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }

            Button("自定义圆角卡片") {
                showCustomSheet = true
            }
            .sheet(isPresented: $showCustomSheet) {
                SampleCardView()
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding()
            }

            Button("Popover 弹窗样式") {
                showPopover = true
            }
            .popover(isPresented: $showPopover) {
                SampleCardView()
                    .frame(width: 300, height: 200)
            }
        }
        .padding()
    }
}

#Preview {
    textUI()
}

struct SampleCardView: View {
    var body: some View {
        VStack {
            Text("这是一张卡片")
                .font(.title2)
                .padding()
            Divider()
            Text("你可以在这里显示内容")
                .padding(.bottom)
        }
        .padding()
    }
}
