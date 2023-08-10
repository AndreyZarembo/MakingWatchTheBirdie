//
//  ToolbarButton.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.07.2023.
//

import SwiftUI

struct ToolbarButton: View {
    
    let uuid = UUID()
    var accessLevel: AccessLevel
    let icon: String
    var iconPlaceTuning: CGPoint = CGPoint()
    let action: () -> Void
    
    var body: some View {
        Button { action() } label: {
            ZStack {
                Image(accessLevel == .kids ?
                      "ToolbarButtonBGKids" :
                      "ToolbarButtonBGParents"
                )
                Image(icon)
                    .offset(
                        x: self.iconPlaceTuning.x,
                        y: self.iconPlaceTuning.y)
            }
        }
        .frame(width: 64, height: 64)
    }
}

struct ToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            
            ToolbarButton(accessLevel: .kids,
                          icon: "SwapCamera") {}
            ToolbarButton(accessLevel: .parent,
                          icon: "SwapCamera") {}
        }
    }
}
