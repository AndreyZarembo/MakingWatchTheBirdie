//
//  NavigationExampleStartView.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.10.2023.
//

import SwiftUI

struct NavigationExampleStartView: View {
    
    @Binding var accessLevel: AccessLevel
    @Binding var path: NavigationPath
    
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
                            AgeSwitchButton(accessLevel: $accessLevel)
                            Spacer()
                            ToolbarButton(
                                accessLevel: accessLevel,
                                icon: "Gallery Button"
                            ){
                                path.append(NavigationDestinations.gallery)
                            }
                        }
                    }
                }
            }
            
            CaptureButtonLayer() {
                
            }
        }
        
    }
}

#Preview {
    @State var accessLevel: AccessLevel = .kids
    @State var path = NavigationPath()
    return NavigationExampleStartView(
        accessLevel: $accessLevel,
        path: $path
    )
}
