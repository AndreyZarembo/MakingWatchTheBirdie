//
//  Gallery.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.09.2023.
//

import SwiftUI

struct Gallery: View {
    
    @ObservedObject var content: Content = Content(contentSource: DummyContentSource())
    @State var viewMode: GridViewMode = .mediumPhotos
    @State var selectedImages: [UUID] = []
    
    
    var body: some View {
        VStack {
            GalleryGrid(
                content: content,
                viewMode: viewMode, 
                selectedImages: $selectedImages
            )
            
            HStack() {
                Button {
                    withAnimation {
                        viewMode = .smallPhotos
                    }
                } label: {
                    Text("Small")
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        viewMode = .mediumPhotos
                    }
                } label: {
                    Text("Medium")
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        viewMode = .largePhotos
                    }
                } label: {
                    Text("Large")
                }
            }
            .padding(12)
            .background(.gray)
        }
    }
}

#Preview {
    Gallery()
}
