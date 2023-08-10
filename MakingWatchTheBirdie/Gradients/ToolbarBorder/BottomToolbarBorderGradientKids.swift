//
//  BottomToolbarBorderGradientKids.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.07.2023.
//

import SwiftUI

struct BottomToolbarBorderGradientKids: View {
    
    struct GradientStyle: View {
        var body: some View {
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.13, green: 0.37, blue: 0.61), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.18, green: 0.44, blue: 0.65), location: 0.50),
                            Gradient.Stop(color: Color(red: 0.15, green: 0.4, blue: 0.63), location: 0.84),
                            Gradient.Stop(color: Color(red: 0.13, green: 0.37, blue: 0.61), location: 1.00),
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

struct BottomToolbarBorderGradientKids_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbarBorderGradientKids()
    }
}
