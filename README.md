# SolarSystem-SwiftUI 🪐

**English** / [日本語](#japanese)

An interactive, high-performance 2D Solar System simulator built with **SwiftUI (Canvas)** and a custom **C++ Physics Engine**. This project demonstrates the seamless integration of C++ for complex orbital calculations and SwiftUI for smooth, 60 FPS rendering.

### ✨ Features
* **High-Performance Rendering:** Utilizes SwiftUI `Canvas` API to draw 3,000+ stars and dynamic planetary orbits at 60 FPS without frame drops.
* **C++ Physics Engine:** Orbital mechanics (Kepler's laws, angular velocity) are purely calculated in a custom C++ engine (`SolarSystemEngine`), achieving strict separation of concerns.
* **Optimized Logarithmic UI Scale:** Balances astronomically accurate physical ratios with UI visibility using a custom logarithmic scaling algorithm.
* **Interactive Gestures:** Supports `MagnificationGesture` (Zoom) and `DragGesture` (Pan) for an immersive exploration experience.
* **Clean Architecture:** Strictly follows the MVVM pattern, completely isolating the View logic from the data calculation layer.

### 🛠 Tech Stack
* **UI & Graphics:** Swift, SwiftUI, Canvas API
* **Logic & Physics:** C++20
* **Architecture:** MVVM (Model-View-ViewModel), C++ Interoperability

### 🚀 How to Run
1. Clone this repository: `git clone https://github.com/YourUsername/SolarSystem-SwiftUI.git`
2. Open `SolarSystemApp.xcodeproj` in Xcode.
3. Build and run on an iOS Simulator or a physical device.

---

<a id="japanese"></a>
## 🇯🇵 日本語 (Japanese)

**SwiftUI (Canvas)** と独自の **C++ 物理演算エンジン** を組み合わせて開発した、インタラクティブで高性能な2D太陽系シミュレータです。複雑な軌道計算をC++で処理し、SwiftUIを用いて60FPSの滑らかな描画を実現しています。

### ✨ 主な機能
* **超高速レンダリング:** SwiftUIの `Canvas` APIを活用し、3,000個以上の星空と動的な惑星の軌道を60FPSで処理落ちなく描画します。
* **C++ 物理エンジン:** ケプラーの法則や角速度に基づく軌道計算はすべて自作のC++エンジンで行い、厳密な関心の分離（Separation of Concerns）を実現しました。
* **対数デフォルメUI:** 現実の天文学的な物理比率（リアルスケール）と、スマートフォンの画面上での見やすさを両立させるため、独自の対数スケーリングアルゴリズムを実装しています。
* **直感的な操作:** ピンチ操作（ズーム）とスワイプ操作（パンスクロール）に対応し、シームレスに宇宙空間を探索できます。
* **クリーンアーキテクチャ:** MVVMパターンを厳格に採用し、ビュー（UI）と計算ロジックを完全に分離しています。

### 🛠 技術スタック
* **UI・描画:** Swift, SwiftUI, Canvas API
* **ロジック・物理演算:** C++20
* **アーキテクチャ:** MVVM, C++ Interoperability

