//
//  NavigationGalleryExample.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.10.2023.
//

import SwiftUI

struct NavigationGalleryExample: View {
    
    static var content: Content = Content(contentSource: PhotoSource())
    
    @Binding var accessLevel: AccessLevel
    @ObservedObject var content: Content = NavigationGalleryExample.content
    @State var viewMode: GridViewMode = .mediumPhotos
    @State var selectedImages: [UUID] = []
    @State var selectionMode: Bool = false
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
                            icon: "Camera"
                        ){
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                        AgeSwitchButton(accessLevel: $accessLevel)
                    }
                }
                
                GalleryGrid(
                    content: content,
                    viewMode: viewMode,
                    selectedImages: $selectedImages,
                    selectionMode: $selectionMode
                )
            }
        }
    }
}

#Preview {
    @State var accessLevel: AccessLevel = .kids
    return NavigationGalleryExample(accessLevel: $accessLevel)
}
