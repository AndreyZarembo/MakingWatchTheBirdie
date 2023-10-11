//
//  NavigationExamplePhotoView.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.10.2023.
//

import SwiftUI

struct NavigationExamplePhotoView: View {
    
    @State var mediaItem: MediaItem
    @Binding var accessLevel: AccessLevel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        GeometryReader { parentGR in
            
            VStack(spacing: 0) {
                
                Toolbars(
                    location: .top,
                    accessLevel: accessLevel,
                    pattern: .photos,
                    parentGR: parentGR
                ) {
                    
                    HStack {
                        ToolbarButton(
                            accessLevel: accessLevel,
                            icon: "Gallery Button"
                        ){
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                        AgeSwitchButton(accessLevel: $accessLevel)
                    }
                }
                
                ZStack {
                    AsyncImage(url: mediaItem.url) { $0.image?.resizable().scaledToFill()}
                        .ignoresSafeArea()
                }
                .padding(EdgeInsets())
                .frame(width: parentGR.size.width)
            }
        }
    }
}

#Preview {
    @State var accessLevel: AccessLevel = .kids
    return NavigationExamplePhotoView(
        mediaItem: MediaItem.from("Sample 22")!,
        accessLevel: $accessLevel
    )
}
