//
//  SideButtonLayout.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.07.2023.
//

import SwiftUI

struct SideButtonLayout: View {
    
    var accessLevel: AccessLevel
    var side: ScreenSide
    var dimmed: Bool = false
    var sideButtons: [SideButton]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                if side == .right { Spacer() }
                VStack {
                    ForEach(sideButtons, id: \.icon) { button in
                        button
                        .setAccessLevel(accessLevel)
                        .setSide(side)
                        .disabled(dimmed)
                    }
                }
                if side == .left { Spacer() }
            }
            .opacity(dimmed ? 0.05 : 1)
            Spacer()
        }
    }
}

extension SideButton {
    
    func setSide(_ side: ScreenSide) -> Self {
        var result = self
        result.side = side
        return result
    }
    
    func setAccessLevel(_ accessLevel: AccessLevel) -> Self {
        var result = self
        result.accessLevel = accessLevel
        return result
    }
}

struct SideButtonLayout_Previews: PreviewProvider {
    static let preview_buttons = [SideButton(
        icon: "Filters",
        iconPlaceTuning: CGPoint(x: -4, y: 0)
    ) {}
    ]
    
    static var previews: some View {
        
        VStack {
            SideButtonLayout(
                accessLevel: .kids,
                side: .left,
                sideButtons: preview_buttons
            )
            .border(Color.gray)
            
            SideButtonLayout(
                accessLevel: .kids,
                side: .right,
                sideButtons: preview_buttons
            )
            .border(Color.gray)
            
            SideButtonLayout(
                accessLevel: .parent,
                side: .left,
                sideButtons: preview_buttons
            )
            .border(Color.gray)
            
            SideButtonLayout(
                accessLevel: .parent,
                side: .right,
                sideButtons: preview_buttons
            )
            .border(Color.gray)
        }
    }
}
