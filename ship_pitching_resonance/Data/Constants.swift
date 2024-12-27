//
//  Constants.swift
//  ship_pitching_resonance
//
//  Created by Richard Dzubko on 27.12.2024.
//

struct K {
    struct Probability {
        static let title = "Исходные вероятности"
        
        static let pE = 0.72
        static let pHE = 0.88
        static let pHNotE = 0.02
        static let mdHE1 = 0.88
        static let mdHE2 = 0.96
        
        static let params: [Parameter] = [
                Parameter(id: "P(E)", value: pE),
                Parameter(id: "P(H/E)", value: pHE),
                Parameter(id: "P(H/NOT E)", value: pHNotE),
                Parameter(id: "МД(H/E1)", value: mdHE1),
                Parameter(id: "МД(H/E2)", value: mdHE2),
            ]
    }
    
    struct ShipParams {
        static let title = "Параметры корабля"
        
        static let length = 60.0
        static let width = 9.5
        static let draft = 3.8
        static let meta = 0.6
        static let speed = 13.0
        
        static let params: [Parameter] = [
                Parameter(id: "Длина (м)", value: length),
                Parameter(id: "Ширина (м)", value: width),
                Parameter(id: "Осадка (м)", value: draft),
                Parameter(id: "Метацентрическая высота h (м)", value: meta),
                Parameter(id: "Cкорость корабля (узлов)", value: speed),
            ]
    }
}
