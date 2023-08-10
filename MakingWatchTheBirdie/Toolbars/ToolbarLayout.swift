//
//  ToolbarLayout.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.07.2023.
//

import SwiftUI

struct ToolbarLayout<Content: View>: View {
    enum ToolbarLocation {
        case top
        case bottom
    }
    var location: ToolbarLayout.ToolbarLocation
    var accessLevel: AccessLevel
    var elements: () -> Content
    
    var body: some View {
        GeometryReader { parentGR in
            VStack {
                if (location == .bottom) { Spacer() }
                elements().padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .frame(minWidth: parentGR.size.width, minHeight: 72)
                    .background(ToolbarsBackgroundGradientKids())
                if (location == .top) { Spacer() }
            }
        }
    }
}

struct ToolbarLayout_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            
            ToolbarLayout(location: .top, accessLevel: .kids) {
                HStack {
                    ToolbarButton(accessLevel: .kids, icon: "SwapCamera", action: {})
                    Spacer()
                    ToolbarButton(accessLevel: .kids, icon: "SwapCamera", action: {})
                }
            }
            
            ToolbarLayout(location: .bottom, accessLevel: .kids) {
                HStack {
                    ToolbarButton(accessLevel: .kids, icon: "SwapCamera", action: {})
                    Spacer()
                    ToolbarButton(accessLevel: .kids, icon: "SwapCamera", action: {})
                }
            }
        }
    }
}
