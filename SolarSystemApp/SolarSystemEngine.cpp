#include "SolarSystemEngine.hpp"
#include <cmath>
#include <numbers> // C++20 の数学定数を利用

namespace {
// 標準ライブラリの円周率を直接利用
constexpr float kPi = std::numbers::pi_v<float>;

float radiusAtAngle(float a, float e, float angle) {
    return a * (1.0f - e * e) / (1.0f + e * std::cos(angle));
}
} // namespace

SolarSystemEngine::SolarSystemEngine() {
    // --- 岩石惑星・準惑星（正確なリアル比率） ---
    // --- 岩石惑星・準惑星（正確なリアル比率） ---
            // 順番: name, a, e, period, currentAngle, angularVelocity, radius, r, g, b
    // --- 岩石惑星・準惑星（UIに最適化したゴールデンバランス） ---
            // パラメータ順: name, a, e, period, currentAngle, angularVelocity, radius, r, g, b
            planets.push_back({"Mercury", 0.387f, 0.2056f, 0.0f, 0.0f, 0.0f, 4.0f,  0.7f, 0.7f, 0.7f});
            planets.push_back({"Venus",   0.723f, 0.0067f, 0.0f, 0.0f, 0.0f, 6.0f,  0.9f, 0.6f, 0.1f});
            planets.push_back({"Earth",   1.000f, 0.0167f, 0.0f, 0.0f, 0.0f, 6.5f,  0.1f, 0.5f, 1.0f});
            planets.push_back({"Mars",    1.524f, 0.0934f, 0.0f, 0.0f, 0.0f, 5.0f,  1.0f, 0.3f, 0.0f});
            
            // --- ガス惑星（迫力と見やすさを両立） ---
            planets.push_back({"Jupiter", 5.204f, 0.0484f, 0.0f, 0.0f, 0.0f, 22.0f, 0.8f, 0.7f, 0.5f});
            planets.push_back({"Saturn",  9.582f, 0.0541f, 0.0f, 0.0f, 0.0f, 18.0f, 0.9f, 0.8f, 0.6f});
            planets.push_back({"Uranus",  19.201f, 0.0471f, 0.0f, 0.0f, 0.0f, 12.0f, 0.6f, 0.8f, 0.9f});
            planets.push_back({"Neptune", 30.047f, 0.0085f, 0.0f, 0.0f, 0.0f, 11.5f, 0.2f, 0.3f, 0.8f});
            
            // --- 冥王星 ---
            planets.push_back({"Pluto",   39.480f, 0.2488f, 0.0f, 0.0f, 0.0f, 3.0f,  0.8f, 0.7f, 0.6f});
    for (auto& p : planets) {
        p.period = std::sqrt(p.a * p.a * p.a);
        p.angularVelocity = (2.0f * kPi) / p.period;
    }
}

void SolarSystemEngine::update(float simulationSpeed) {
    for (auto& p : planets) {
        p.currentAngle += simulationSpeed * p.angularVelocity;

        if (p.currentAngle > 2.0f * kPi) {
            p.currentAngle -= 2.0f * kPi;
        }
    }
}

std::vector<PlanetData> SolarSystemEngine::getPlanetsData() const {
    std::vector<PlanetData> output;
    output.reserve(planets.size());

    for (const auto& p : planets) {
        const float r = radiusAtAngle(p.a, p.e, p.currentAngle);
        const float x = r * std::cos(p.currentAngle);
        const float y = r * std::sin(p.currentAngle);

        output.push_back({
            p.name, x, y, p.radius, p.r, p.g, p.b, p.a, p.e,
        });
    }

    return output;
}
