//
//  ControlPanelView.swift
//  SolarSystemApp
//
//  Created by Joji Kashimura on 2/23/26.
//

import SwiftUI

struct ControlPanelView: View {
    // 親ビューの状態を読み書きするためのBinding変数
    @Binding var scale: CGFloat
    @Binding var panOffset: CGSize
    @Binding var simulationSpeed: Float
    
    // ジェスチャー中の値は読み取り専用で受け取る
    var magnifyBy: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Scale: \(Int(scale * magnifyBy))")
                            .foregroundColor(.white)
                            .font(.caption)
                        
                        Button(action: {
                            // 視点のリセット処理
                            withAnimation {
                                scale = 40.0
                                panOffset = .zero
                            }
                        }) {
                            Text("Reset View")
                                .font(.caption)
                                .padding(6)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text("Speed: \(String(format: "%.4f", simulationSpeed))")
                        .foregroundColor(.white)
                        .font(.caption)
                    
                    Slider(value: $simulationSpeed, in: 0.0...0.05)
                        .tint(.gray)
                        .frame(width: 200)
                }
                .padding()
                Spacer()
            }
            Spacer()
        }
    }
}
