#pragma once

#include <string>
#include <vector>

struct PlanetData {
    std::string name;
    float x;
    float y;
    float radius;
    float r;
    float g;
    float b;
    float a;
    float e;
};

class SolarSystemEngine {
private:
    struct InternalPlanet {
        std::string name;
        float a;
        float e;
        float period;
        float angularVelocity;
        float currentAngle;
        float radius;
        float r;
        float g;
        float b;
    };

    std::vector<InternalPlanet> planets;

public:
    SolarSystemEngine();
    void update(float simulationSpeed);
    std::vector<PlanetData> getPlanetsData() const;
};
