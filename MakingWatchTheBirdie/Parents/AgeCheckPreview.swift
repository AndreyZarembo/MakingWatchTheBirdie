//
//  AgeCheckPreview.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 23.08.2023.
//

import SwiftUI

struct AgeCheckPreview: View {
    
    @State var accessLevel: AccessLevel = .kids
    
    var body: some View {
        
        ZStack {
            
            GeometryReader { parentGR in
                
                VStack(spacing: 0) {
                    
                    Toolbars(
                        location: .top,
                        accessLevel: accessLevel,
                        pattern: .photos,
                        parentGR: parentGR
                    ) {
                        HStack {
                            Spacer()
                            AgeSwitchButton(accessLevel: $accessLevel)
                            Spacer()
                        }
                    }

                }
            }
            
            if accessLevel == .ageCheck {
                AgeCheckLayer(accessLevel: $accessLevel)
            }
        }
    }
}

struct AgeCheckPreview_Previews: PreviewProvider {
    static var previews: some View {
        AgeCheckPreview()
    }
}
