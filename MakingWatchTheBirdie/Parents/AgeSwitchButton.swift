//
//  AgeSwitchButton.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.08.2023.
//

import SwiftUI

struct AgeSwitchButton: View {
    
    @Binding var accessLevel: AccessLevel
    
    var body: some View {
        
        ToolbarButton(
            accessLevel: accessLevel,
            icon: accessLevel == .kids ? "ToParentMode": "ToChildMode") {
                accessLevel = accessLevel.next()
            }
    }
}

struct AgeSwitchButton_Previews: PreviewProvider {
    static var previews: some View {
        AgeSwitchButton(accessLevel: .constant(.kids))
    }
}
