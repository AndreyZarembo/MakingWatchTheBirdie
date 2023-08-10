//
//  BottomToolbarBorderGradientParents.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.07.2023.
//

import SwiftUI

struct BottomToolbarBorderGradientParents: View {
    
    struct GradientStyle: View {
        var body: some View {
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.1, green: 0.63, blue: 0.02), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.56, green: 0.76, blue: 0.14), location: 0.50),
                            Gradient.Stop(color: Color(red: 0.1, green: 0.62, blue: 0.02), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0, y: 0.5),
                        endPoint: UnitPoint(x: 1, y: 0.5)
                    )
                )
        }
    }
    
    var body: some View {
        ZStack {
            GradientStyle()
                .opacity(0.85)
        }
    }
}

struct BottomToolbarBorderGradientParents_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbarBorderGradientParents()
    }
}
