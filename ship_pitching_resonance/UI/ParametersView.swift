//
//  ParametersView.swift
//  ship_pitching_resonance
//
//  Created by Richard Dzubko on 26.12.2024.
//

import SwiftUI

struct ParametersView: View {
    let title: String
    let parameters: [Parameter]
    
    init(_ parameters: [Parameter], title: String = "") {
        self.parameters = parameters
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .padding(.top, 4)
                .padding(.bottom, 2)
            ForEach(parameters) {
                parameter in
                Text("\(parameter.id) = \(parameter.value)")
            }
        }.padding(.horizontal, 12)
            .padding(.vertical, 12)
            .border(.white, width: 2)
            .clipShape(.rect(cornerRadius: 5))
    }
}
