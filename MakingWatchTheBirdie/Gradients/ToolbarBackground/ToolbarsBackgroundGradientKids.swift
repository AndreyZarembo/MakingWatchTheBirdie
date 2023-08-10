//
//  ToolbarsBackgroundGradient.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 26.07.2023.
//

import SwiftUI

struct ToolbarsBackgroundGradientKids: View {
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.13, green: 0.22, blue: 0.59), location: 0.00),
                Gradient.Stop(color: Color(red: 0.2, green: 0.38, blue: 0.67), location: 0.19),
                Gradient.Stop(color: Color(red: 0.25, green: 0.47, blue: 0.78), location: 0.40),
                Gradient.Stop(color: Color(red: 0.21, green: 0.42, blue: 0.69), location: 0.67),
                Gradient.Stop(color: Color(red: 0.25, green: 0.68, blue: 0.82), location: 1.00),
            ],
            startPoint: UnitPoint(x: 1, y: 0),
            endPoint: UnitPoint(x: 0, y: 1)
        )
        .ignoresSafeArea()
    }
}

struct ToolbarsBackgroundGradientKids_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarsBackgroundGradientKids()
    }
}
