import SwiftUI

struct SolarSystemCanvas: View {
    let planets: [DisplayPlanet]
    let baseScale: CGFloat
    let magnification: CGFloat
    let tilt: CGFloat

    var body: some View {
        Canvas { context, size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            drawSun(in: &context, at: center)

            let currentScale = Double(baseScale * magnification)
            let currentTilt = Double(tilt)

            for planet in planets {
                drawOrbit(of: planet, in: &context, center: center, scale: currentScale, tilt: currentTilt)
                drawPlanet(planet, in: &context, center: center, scale: currentScale, tilt: currentTilt)
            }
        }
    }

    private func drawSun(in context: inout GraphicsContext, at center: CGPoint) {
        let sunRadius: CGFloat = 8
        var path = Path()
        path.addEllipse(
            in: CGRect(
                x: center.x - sunRadius,
                y: center.y - sunRadius,
                width: sunRadius * 2,
                height: sunRadius * 2
            )
        )

        context.fill(
            path,
            with: .radialGradient(
                Gradient(colors: [.white, .yellow, .orange]),
                center: center,
                startRadius: 0,
                endRadius: sunRadius * 1.5
            )
        )
    }

    private func drawOrbit(
        of planet: DisplayPlanet,
        in context: inout GraphicsContext,
        center: CGPoint,
        scale: Double,
        tilt: Double
    ) {
        var orbitPath = Path()
        let steps = 180
        
        // 事前キャスト済みのプロパティをそのまま利用
        let a = planet.a
        let e = planet.e
        let eSquared = e * e

        for i in 0...steps {
            let theta = Double(i) * 2 * .pi / Double(steps)
            let cosTheta = cos(theta)
            let sinTheta = sin(theta)

            let r = a * (1 - eSquared) / (1 + e * cosTheta)
            let x = r * cosTheta * scale
            let y = r * sinTheta * scale * tilt
            let point = CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))

            if i == 0 {
                orbitPath.move(to: point)
            } else {
                orbitPath.addLine(to: point)
            }
        }

        context.stroke(orbitPath, with: .color(planet.color.opacity(0.3)), lineWidth: 1)
    }

    private func drawPlanet(
        _ planet: DisplayPlanet,
        in context: inout GraphicsContext,
        center: CGPoint,
        scale: Double,
        tilt: Double
    ) {
        // 事前キャスト済みのプロパティをそのまま利用
        let px = center.x + planet.x * CGFloat(scale)
        let py = center.y - planet.y * CGFloat(scale * tilt)
        let radius = planet.radius

        var path = Path()
        path.addEllipse(in: CGRect(x: px - radius, y: py - radius, width: radius * 2, height: radius * 2))

        let highlightCenter = CGPoint(x: px - radius * 0.3, y: py - radius * 0.3)
        let gradient = Gradient(colors: [.white.opacity(0.8), planet.color, .black.opacity(0.9)])

        context.fill(
            path,
            with: .radialGradient(
                gradient,
                center: highlightCenter,
                startRadius: 0,
                endRadius: radius * 1.2
            )
        )
    }
}
