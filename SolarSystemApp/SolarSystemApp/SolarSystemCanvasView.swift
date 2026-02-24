import SwiftUI

struct Star {
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let opacity: Double
}

struct SolarSystemCanvasView: View {
    var planetsData: [PlanetData]
    var scale: CGFloat
    var magnifyBy: CGFloat
    var panOffset: CGSize
    var dragOffset: CGSize
    var tilt: CGFloat
    
    // --- 変更：星の数を3000個に増やし、密度を上げる ---
    @State private var stars: [Star] = (0..<3000).map { _ in
        Star(
            x: CGFloat.random(in: -2000...2000),
            y: CGFloat.random(in: -2000...2000),
            size: CGFloat.random(in: 0.5...2.5),
            opacity: Double.random(in: 0.1...0.9)
        )
    }
    
    var body: some View {
        Canvas { context, size in
            let totalPanX = panOffset.width + dragOffset.width
            let totalPanY = panOffset.height + dragOffset.height
            
            // 惑星や太陽の中心点（スワイプに追従）
            let center = CGPoint(
                x: size.width / 2.0 + totalPanX,
                y: size.height / 2.0 + totalPanY
            )
            
            // --- 変更：背景に完全に固定された星空の描画 ---
            for star in stars {
                // スライド量（totalPan）を足さないことで、画面に完全に固定します
                let starX = size.width / 2.0 + star.x
                let starY = size.height / 2.0 + star.y
                
                var starPath = Path()
                starPath.addEllipse(in: CGRect(x: starX, y: starY, width: star.size, height: star.size))
                
                context.fill(starPath, with: .color(Color(red: 0.9, green: 0.95, blue: 1.0).opacity(star.opacity)))
            }
            
            // --- Sun Drawing ---
            let sunRadius: CGFloat = 5.0
            var sunPath = Path()
            sunPath.addEllipse(in: CGRect(x: center.x - sunRadius, y: center.y - sunRadius, width: sunRadius * 2, height: sunRadius * 2))
            
            let sunGradient = Gradient(colors: [.white, .yellow, .orange])
            context.fill(sunPath, with: .radialGradient(
                sunGradient,
                center: center,
                startRadius: 0,
                endRadius: sunRadius * 1.5
            ))
            
            let currentScale = Double(scale * magnifyBy)
            let currentTilt = Double(tilt)
            
            for planet in planetsData {
                let baseColor = Color(
                    red: Double(planet.r),
                    green: Double(planet.g),
                    blue: Double(planet.b)
                )
                
                // --- Orbit Drawing ---
                var orbitPath = Path()
                let steps = 180
                
                let a = Double(planet.a)
                let e = Double(planet.e)
                let eSquared = e * e
                
                for i in 0...steps {
                    let theta = Double(i) * 2.0 * .pi / Double(steps)
                    let cosTheta = cos(theta)
                    let sinTheta = sin(theta)
                    
                    let numerator = a * (1.0 - eSquared)
                    let denominator = 1.0 + (e * cosTheta)
                    let r = numerator / denominator
                    
                    let x = r * cosTheta * currentScale
                    let y = r * sinTheta * currentScale * currentTilt
                    
                    let point = CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))
                    
                    if i == 0 {
                        orbitPath.move(to: point)
                    } else {
                        orbitPath.addLine(to: point)
                    }
                }
                context.stroke(orbitPath, with: .color(baseColor.opacity(0.3)), lineWidth: 1)
                
                // --- Planet Drawing ---
                let pxDouble = Double(planet.x) * currentScale
                let pyDouble = Double(planet.y) * currentScale * currentTilt
                
                let px = center.x + CGFloat(pxDouble)
                let py = center.y - CGFloat(pyDouble)
                let radius = CGFloat(planet.radius)
                
                var path = Path()
                path.addEllipse(in: CGRect(x: px - radius, y: py - radius, width: radius * 2, height: radius * 2))
                
                let highlightCenter = CGPoint(x: px - radius * 0.3, y: py - radius * 0.3)
                let planetGradient = Gradient(colors: [.white.opacity(0.8), baseColor, .black.opacity(0.9)])
                
                context.fill(path, with: .radialGradient(
                    planetGradient,
                    center: highlightCenter,
                    startRadius: 0,
                    endRadius: radius * 1.2
                ))
                
                // --- Planet Label (Name) Drawing ---
                let planetName = String(planet.name)
                let text = Text(planetName)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.8))
                
                let resolvedText = context.resolve(text)
                let textPosition = CGPoint(x: px + radius + 10.0, y: py + radius + 2.0)
                context.draw(resolvedText, at: textPosition, anchor: .leading)
            }
        }
    }
}
