//
//  ToolbarBorderGradient.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.07.2023.
//

import SwiftUI

struct ToolbarBorderGradient: View {
    
    var location: ToolbarLocation
    var accessLevel: AccessLevel
    var width: CGFloat
    
    var body: some View {
        
        Group {
            switch (location, accessLevel) {
            case (.top, .kids):
                TopToolbarBorderGradientKids()
            case (.bottom, .kids):
                BottomToolbarBorderGradientKids()
            case (.top, .parent):
                TopToolbarBorderGradientParens()
            case (.bottom, .parent):
                BottomToolbarBorderGradientParents()
            case (.top, .ageCheck):
                TopToolbarBorderGradientParens()
            case (.bottom, .ageCheck):
                BottomToolbarBorderGradientParents()
            }
        }
        .frame(width: width+32, height: 4)
        .blur(radius: 2)
        .clipShape(Rectangle().path(in: CGRect(x: 0, y: location == .top ? -2 : 2, width: width+32, height: 4)))
    }
}

struct ToolbarBorderGradient_Previews: PreviewProvider {
    static var previews: some View {
        
        GeometryReader { gr in
        VStack {
                Spacer()
                ToolbarBorderGradient(location: .top, accessLevel: .kids, width: gr.size.width)
                ToolbarBorderGradient(location: .bottom, accessLevel: .kids, width: gr.size.width)
                ToolbarBorderGradient(location: .top, accessLevel: .parent, width: gr.size.width)
                ToolbarBorderGradient(location: .bottom, accessLevel: .parent, width: gr.size.width)
                Spacer()
            }
        }
        
        
    }
}
