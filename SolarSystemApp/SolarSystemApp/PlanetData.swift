import SwiftUI

/// Swift UI が扱う表示用モデル。
struct DisplayPlanet: Identifiable {
    // 毎フレームUUIDを生成せず、名前を一意のIDとして利用
    var id: String { name }
    let name: String
    
    // UI描画で直接使える型 (CGFloat / Double / Color) として保持
    let x: CGFloat
    let y: CGFloat
    let radius: CGFloat
    let color: Color
    
    let a: Double
    let e: Double
}

extension DisplayPlanet {
    init(cppPlanet: PlanetData) {
        self.name = String(cppPlanet.name)
        self.x = CGFloat(cppPlanet.x)
        self.y = CGFloat(cppPlanet.y)
        self.radius = CGFloat(cppPlanet.radius)
        
        // 色の組み立てを初期化時に1回だけ行う
        self.color = Color(
            red: Double(cppPlanet.r),
            green: Double(cppPlanet.g),
            blue: Double(cppPlanet.b)
        )
        
        self.a = Double(cppPlanet.a)
        self.e = Double(cppPlanet.e)
    }
}
