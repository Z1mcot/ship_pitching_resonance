//
//  Utils.swift
//  ship_pitching_resonance
//
//  Created by Richard Dzubko on 26.12.2024.
//

struct Utils {
    static func convertToRadians(_ angle: Double) -> Double {
        Double.pi * angle / 180.0
    }
    
    static func knotsToMetersPerSecond(_ knots: Double) -> Double {
        return knots * 0.5144
    }
}
