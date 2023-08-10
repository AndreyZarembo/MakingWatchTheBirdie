//
//  ToolbarsBackgroundGradient.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 28.07.2023.
//

import SwiftUI

struct ToolbarsBackgroundGradient: View {
    
    var accessLevel: AccessLevel
    
    var body: some View {
        
        if accessLevel == .kids {
            ToolbarsBackgroundGradientKids()
        }
        else {
            ToolbarsBackgroundGradientParent()
        }
    }
}

struct ToolbarsBackgroundGradient_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarsBackgroundGradient(accessLevel: .kids)
        
        ToolbarsBackgroundGradient(accessLevel: .parent)
    }
}
