//
//  SideButton.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.07.2023.
//

import SwiftUI

struct SideButton: View {
    
    var accessLevel: AccessLevel = .kids
    var side: ScreenSide = .left
    let icon: String
    var iconPlaceTuning: CGPoint = CGPoint()
    let action: () -> Void
    
    var body: some View {
        Button { action() } label: {
            ZStack {
                if accessLevel == .kids {
                    Image(side == .left ?
                          "SideButtonBGLeftKids" :
                          "SideButtonBGRightKids"
                    )
                }
                else {
                    Image(side == .left ?
                          "SideButtonBGLeftParent" :
                          "SideButtonBGRightParent"
                    )
                }
                Image(icon)
                    .offset(
                        x: self.iconPlaceTuning.x,
                        y: self.iconPlaceTuning.y)
            }
        }
        .frame(width: 64, height: 64)
    }
}

struct SideButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                SideButton(
                    accessLevel: .kids,
                    side: .left,
                    icon: "Filters",
                    iconPlaceTuning: CGPoint(x: -4, y: 0)
                ) {}
                Spacer()
            }
            HStack {
                Spacer()
                SideButton(
                    accessLevel: .kids,
                    side: .right,
                    icon: "Filters",
                    iconPlaceTuning: CGPoint(x: 0, y: 0)
                ) {}
            }
            HStack {
                SideButton(
                    accessLevel: .parent,
                    side: .left,
                    icon: "Filters",
                    iconPlaceTuning: CGPoint(x: -4, y: 0)
                ) {}
                Spacer()
            }
            HStack {
                Spacer()
                SideButton(
                    accessLevel: .parent,
                    side: .right,
                    icon: "Filters",
                    iconPlaceTuning: CGPoint(x: 0, y: 0)
                ) {}
            }
        }
    }
}
