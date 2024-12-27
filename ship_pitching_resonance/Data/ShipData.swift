//
//  ShipData.swift
//  ship_pitching_resonance
//
//  Created by Richard Dzubko on 26.12.2024.
//

import Foundation

struct Parameter: Identifiable {
    let id: String
    private let _value: Double
    
    init(id: String, value: Double) {
        self.id = id
        self._value = value
    }
    
    var value: String {
        _value.formatted(.number)
    }
}

class ShipData {
    // MARK: - properties
    
    var shipLength: Double
    
    var shipWidth: Double
    
    var shipDraft: Double
    
    var metaHeight: Double
    
    var speedInKnots: Double
    
    var speedInMetersPerSecond: Double {
        Utils.knotsToMetersPerSecond(speedInKnots)
    }
    
    var waveLength: Double {
        shipLength
    }
    
    var speedWave: Double {
        1.25 * waveLength.squareRoot()
    }
    
    // Период бортовой качки
    var periodT: Double {
        0.8 * shipWidth / metaHeight.squareRoot()
    }
    
    // Период килевой качки
    var periodP: Double {
        2.5 * shipDraft.squareRoot()
    }
    
    // Период волны
    private(set) var periodWave: Double = 0.0
    
    // Амплитуда бортовой качки
    private(set) var theta: Double = 0.0
    
    // Амплитуда килевой качки
    private(set) var psi: Double = 0.0
    
    // Курсовой угол
    private(set) var courseAngle: Double = 0.0
     
    // Курсовой угол (в радианах)
    var courseAngleInRadians: Double {
        Utils.convertToRadians(courseAngle)
    }
    
    init() {
        shipLength = K.ShipParams.length
        shipWidth = K.ShipParams.width
        shipDraft = K.ShipParams.draft
        metaHeight = K.ShipParams.meta
        speedInKnots = K.ShipParams.speed
    }
    
    //MARK: - methods
    
    func setData(courseAngle: Double, theta: Double, psi: Double) {
        self.courseAngle = courseAngle
        self.theta = theta
        self.psi = psi
        
        self.periodWave = waveLength / (speedWave - speedInMetersPerSecond * cos(courseAngleInRadians))
    }
    
    var bayes: Double {
        K.Probability.pHE * K.Probability.pE + K.Probability.pHNotE * (1 - K.Probability.pE) + (1 - K.Probability.pHE) * K.Probability.pE + K.Probability.pHE * (1 - K.Probability.pE)
    }
    
    var shortliff: Double {
        K.Probability.mdHE1 + K.Probability.mdHE2 * (1 - K.Probability.mdHE1)
    }
}
