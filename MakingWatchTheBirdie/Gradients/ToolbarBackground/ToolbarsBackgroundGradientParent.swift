//
//  ToolbarsBackgroundGradientParent.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.07.2023.
//

import SwiftUI

struct ToolbarsBackgroundGradientParent: View {
    var body: some View {
        LinearGradient(
          stops: [
            Gradient.Stop(color: Color(red: 0.16, green: 0.58, blue: 0.17), location: 0.00),
            Gradient.Stop(color: Color(red: 0.35, green: 0.74, blue: 0.25), location: 0.27),
            Gradient.Stop(color: Color(red: 0.34, green: 0.6, blue: 0.31), location: 0.51),
            Gradient.Stop(color: Color(red: 0.31, green: 0.71, blue: 0.33), location: 0.79),
            Gradient.Stop(color: Color(red: 0.24, green: 0.48, blue: 0.41), location: 1.00),
          ],
          startPoint: UnitPoint(x: 1, y: 0),
          endPoint: UnitPoint(x: 0, y: 1)
        )
        .ignoresSafeArea()
    }
}

struct ToolbarsBackgroundGradientParent_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarsBackgroundGradientParent()
    }
}
