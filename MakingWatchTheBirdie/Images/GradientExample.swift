//
//  Gradient.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 25.07.2023.
//

import SwiftUI

struct GradientExample: View {
    var body: some View {
        LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 0.25, green: 0.69, blue: 0.82), location: 0.00),
            Gradient.Stop(color: Color(red: 0.24, green: 0.65, blue: 0.8), location: 0.13),
            Gradient.Stop(color: Color(red: 0.22, green: 0.51, blue: 0.73), location: 0.52),
            Gradient.Stop(color: Color(red: 0.21, green: 0.44, blue: 0.69), location: 0.82),
            Gradient.Stop(color: Color(red: 0.2, green: 0.4, blue: 0.68), location: 1.00),
            ],
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
        .ignoresSafeArea()
    }
}

struct GradientExample_Previews: PreviewProvider {
    static var previews: some View {
        GradientExample()
    }
}
