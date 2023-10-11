//
//  NavigationRootView.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.10.2023.
//

import SwiftUI

enum NavigationDestinations {
    case gallery
}

struct NavigationRootView: View {
    
    @State var accessLevel: AccessLevel = .kids
    @State var path = NavigationPath()
    
    var body: some View {
        
        ZStack {
            
            NavigationStack(path: $path) {
                NavigationExampleStartView(
                    accessLevel: $accessLevel,
                    path: $path
                )
                .background {
                    Image("Sample 1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                }
                .navigationDestination(for: NavigationDestinations.self)  { dest in
                    
                    Group {
                        switch dest {
                        case .gallery:
                            NavigationGalleryExample(accessLevel: $accessLevel)
                        }
                    }
                    .navigationBarHidden(true)
                }
                .navigationDestination(for: MediaItem.self) { item in
                    NavigationExamplePhotoView(
                        mediaItem: item,
                        accessLevel: $accessLevel
                    )
                    .navigationBarHidden(true)
                }
            }
            
            if accessLevel == .ageCheck {
                AgeCheckLayer(accessLevel: $accessLevel)
            }
        }

    }
}

#Preview {
    NavigationRootView()
}
