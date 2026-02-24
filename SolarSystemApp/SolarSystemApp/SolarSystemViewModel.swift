import SwiftUI
import Combine

final class SolarSystemViewModel: ObservableObject {
    @Published private(set) var planets: [DisplayPlanet] = []
    @Published private(set) var scale: CGFloat = 40

    @GestureState var magnifyBy: CGFloat = 1

    let tilt: CGFloat = 0.5
    let timer = Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()

    private var engine = SolarSystemEngine()
    private var simulationSpeed: Float = 0.05

    private let minScale: CGFloat = 10
    private let maxScale: CGFloat = 300

    init() {
        planets = fetchPlanetsFromEngine()
    }

    func tick() {
        engine.update(simulationSpeed)
        planets = fetchPlanetsFromEngine()
    }

    var magnificationGesture: some Gesture {
        MagnificationGesture()
            .updating($magnifyBy) { value, state, _ in
                state = value
            }
            .onEnded { [weak self] value in
                guard let self else { return }
                let updated = self.scale * value
                self.scale = min(max(updated, self.minScale), self.maxScale)
            }
    }

    private func fetchPlanetsFromEngine() -> [DisplayPlanet] {
        // C++の配列を map で一括変換 (forループの排除)
        return engine.getPlanetsData().map { DisplayPlanet(cppPlanet: $0) }
    }
}
