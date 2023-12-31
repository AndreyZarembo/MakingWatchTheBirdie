//
//  ContentView.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 24.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @Binding var accessLevel: AccessLevel

    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(accessLevel: .constant(.kids))
    }
}
