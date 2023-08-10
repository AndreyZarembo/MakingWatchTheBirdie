//
//  ToolbarButtons.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.07.2023.
//

import SwiftUI

struct ToolbarButtons: View {
    
    var buttons: [ToolbarButton]
    
    init(_ buttons: [ToolbarButton]) {
        self.buttons = buttons
    }
    
    var body: some View {
        HStack {
            switch self.buttons.count {
            case 0:
                Spacer()
                .frame(height: 64)
            case 1:
                Spacer()
                self.buttons.first!
                Spacer()
            default:
                ForEach(Array(zip(buttons.indices, buttons).map({ (index: $0.0, button: $0.1) }) ), id: \.button.uuid) {
                    if $0.index != 0 {
                        Spacer()
                    }
                    $0.button
                }
            }
        }
    }
}

struct ToolbarButtons_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            
            ToolbarButtons([
            ])
            .previewDisplayName("No Buttons")
            
            ToolbarButtons([
                ToolbarButton(accessLevel: .kids, icon: "Swap Camera", action: { })
            ])
            .previewDisplayName("One Button")
            
            ToolbarButtons([
                ToolbarButton(accessLevel: .kids, icon: "Swap Camera", action: { }),
                ToolbarButton(accessLevel: .kids, icon: "Swap Camera", action: { }),
            ])
            .previewDisplayName("Two Buttons")
            
            ToolbarButtons([
                ToolbarButton(accessLevel: .kids, icon: "Swap Camera", action: { }),
                ToolbarButton(accessLevel: .kids, icon: "Swap Camera", action: { }),
                ToolbarButton(accessLevel: .kids, icon: "Swap Camera", action: { }),
            ])
            .previewDisplayName("Three Buttons")
        }
    }
}
