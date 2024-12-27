//
//  Rules.swift
//  ship_pitching_resonance
//
//  Created by Richard Dzubko on 26.12.2024.
//

fileprivate struct _Constants {
    static let rollingAmplitudeThreshold = 15.0 // degrees
    static let pitchingAmplitudeThreshold = 3.0 // degrees
    static let mainMovementMinPeriod = 0.8
    static let mainMovementMaxPeriod = 1.2
    static let parametricMovementMinPeriod = 2.0
    static let parametricMovementMaxPeriod = 2.1
}

class Rules {
    
    //MARK: fields and properties
    
    private var data: ShipData
    
    private var isPrimaryRollingResonance: Bool {
        isResonance(
            amplitude: data.theta,
            amplitudeThreshold: _Constants.rollingAmplitudeThreshold,
            periodRatio: data.periodWave / data.periodT,
            minPeriod: _Constants.mainMovementMinPeriod,
            maxPeriod: _Constants.mainMovementMaxPeriod
        )
    }
    
    private var isParametricRollingResonance: Bool {
        isResonance(
            amplitude: data.theta,
            amplitudeThreshold: _Constants.rollingAmplitudeThreshold,
            periodRatio: data.periodWave / data.periodT,
            minPeriod: _Constants.parametricMovementMinPeriod,
            maxPeriod: _Constants.parametricMovementMaxPeriod
        )
    }
    
    private var isPrimaryPitchingResonance: Bool {
        isResonance(
            amplitude: data.psi,
            amplitudeThreshold: _Constants.pitchingAmplitudeThreshold,
            periodRatio: data.periodWave / data.periodP,
            minPeriod: _Constants.mainMovementMinPeriod,
            maxPeriod: _Constants.mainMovementMaxPeriod
        )
    }
    
    init(data: ShipData) {
        self.data = data
    }
    
    //MARK: - methods
    
    func setData(course: Double, psi: Double, theta: Double) {
        data.setData(courseAngle: course, theta: theta, psi: psi)
    }
    
    func GetMovementType() -> MovementType {
        
        
        if isPrimaryRollingResonance {
            return .primaryRoll
        }
        if isParametricRollingResonance {
            return .parametricRoll
        }
        if isPrimaryPitchingResonance {
            return .primaryPitch
        }
        
        return .none
    }
    
    private func isResonance(amplitude: Double, amplitudeThreshold: Double, periodRatio: Double, minPeriod: Double, maxPeriod: Double) -> Bool {
        amplitude > amplitudeThreshold && periodRatio > minPeriod && periodRatio < maxPeriod
    }
}
