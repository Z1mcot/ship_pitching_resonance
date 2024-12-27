//
//  ContentView.swift
//  ship_pitching_resonance
//
//  Created by Richard Dzubko on 26.12.2024.
//

import SwiftUI

struct ResonanceControlView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "ferry")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                Text("Контроль резонансных режимов качки")
                    .font(.title)
            }.padding(.horizontal, 16)
            
            HStack {
                ParametersView(K.ShipParams.params, title: K.ShipParams.title)
                Spacer().frame(width: 16)
                ParametersView(K.Probability.params, title: K.Probability.title)
            }
            
            if viewModel.showResults {
                VStack(alignment: .leading) {
                    Text("Результаты")
                        .font(.title2)
                        .padding(.bottom, 4)
                    Text("Тип качки: \(viewModel.movementType.rawValue)")
                    Text("Расчет по формуле Байеса: \(viewModel.bayes!)")
                    Text("Расчет по формуле Шортлиффа: \( viewModel.shortliff!)")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .border(.white, width: 2)
                .clipShape(.rect(cornerRadius: 5))
            }
            
            VStack(alignment: .leading) {
                TextField("Курсовой угол (0-180)", text: $viewModel.courseAngleText)
                TextField("ψ, градус (2.5 - 4.5)", text: $viewModel.psiAngleText)
                TextField("θ, градус (12 - 20)", text: $viewModel.thetaAngleText)
            }.frame(width: 160)
                .padding(.vertical, 12)
            
            Button(action: viewModel.compute) {
                Label("Рассчитать", systemImage: "arrow.2.circlepath")
                    .padding(.all)
            }.disabled(!viewModel.isValid)
        }
        .padding(.all)
    }
}

#Preview {
    ResonanceControlView()
}


//MARK: - ViewModel
extension ResonanceControlView {
    @Observable
    class ViewModel {
        private struct Limits {
            static let courseAngle = 0.0...180.0
            
            static let theta = 12.0...20.0
            
            static let psi = 2.5...4.5
        }
        
        private(set) var data: ShipData!
        
        private(set) var rules: Rules!
        
        init() {
            let data = ShipData()
            self.data = data
            self.rules = Rules(data: data)
        }
        
        private(set) var movementType: MovementType = .unknown
        
        private(set) var bayes: Double?
        private(set) var shortliff: Double?
        
        var showResults: Bool {
            movementType != .unknown && bayes != nil && shortliff != nil
        }
        
        var isValid: Bool {
            Limits.courseAngle.contains(courseAngle)
            && Limits.theta.contains(thetaAngle)
            && Limits.psi.contains(psiAngle)
        }
        
        func compute() {
            rules.setData(course: courseAngle, psi: psiAngle, theta: thetaAngle)
            
            movementType = rules.GetMovementType()
            bayes = data.bayes
            shortliff = data.shortliff
        }
        
        var courseAngleText: String = "" {
            didSet {
                courseAngle = Double(courseAngleText) ?? -1
            }
        }
        var psiAngleText: String = "" {
            didSet {
                psiAngle = Double(psiAngleText) ?? -1
            }
        }
        var thetaAngleText: String = "" {
            didSet {
                thetaAngle = Double(thetaAngleText) ?? -1
            }
        }
        
        private var courseAngle: Double = -1
        private var psiAngle: Double = -1
        private var thetaAngle: Double = -1
    }
}
