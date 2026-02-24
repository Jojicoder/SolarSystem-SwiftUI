import SwiftUI
import Combine

struct ContentView: View {
    // 状態管理
    @State private var engine = SolarSystemEngine()
    @State private var simulationSpeed: Float = 0.005
    
    // ズームとパンの状態
    @State private var scale: CGFloat = 60.0
    @GestureState private var magnifyBy: CGFloat = 1.0
    @State private var panOffset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    
    let timer = Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()
    private let tilt: CGFloat = 0.5

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // 1. 描画ビューの呼び出し
            SolarSystemCanvasView(
                planetsData: Array(engine.getPlanetsData()),
                scale: scale,
                magnifyBy: magnifyBy,
                panOffset: panOffset,
                dragOffset: dragOffset,
                tilt: tilt
            )
            // ジェスチャー処理
            .gesture(
                MagnificationGesture()
                    .updating($magnifyBy) { currentState, gestureState, _ in
                        gestureState = currentState
                    }
                    .onEnded { value in
                        let newScale = scale * value
                        scale = Swift.max(2.0, Swift.min(newScale, 200.0))
                    }
                    .simultaneously(with: DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            panOffset.width += value.translation.width
                            panOffset.height += value.translation.height
                        }
                    )
            )
            
            // 2. コントロールパネルUIの呼び出し
            ControlPanelView(
                scale: $scale,
                panOffset: $panOffset,
                simulationSpeed: $simulationSpeed,
                magnifyBy: magnifyBy
            )
        }
        // タイマー更新処理
        .onReceive(timer) { _ in
            engine.update(simulationSpeed)
        }
    }
}
#Preview {
    ContentView()
}
