//
//  Gallery.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.09.2023.
//

import SwiftUI

struct LoadMoreYPositionKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {}
}

enum GridViewMode {
    case smallPhotos
    case mediumPhotos
    case largePhotos
}

struct GalleryGrid: View {
    
    @ObservedObject var content: Content
    @State var prevYOffset: CGFloat = 0
    var viewMode: GridViewMode = .mediumPhotos
    @Binding var selectedImages: [UUID]
    
    static let sizes: [GridViewMode: (minWidth: CGFloat, maxWidth: CGFloat, spacing: CGFloat, batchSize: Int)] = [
        .smallPhotos: (minWidth: 72, maxWidth: 82, spacing: 2, batchSize: 48),
        .mediumPhotos: (minWidth: 102, maxWidth: 140, spacing: 2, batchSize: 24),
        .largePhotos: (minWidth: 300, maxWidth: 420, spacing: 2, batchSize: 10),
    ]
    
    var body: some View {
        GeometryReader { parentGR in
            ScrollView {
                
                let sizes = GalleryGrid.sizes[viewMode]!
                
                LazyVGrid(
                    columns: [
                        GridItem(.adaptive(
                            minimum: sizes.minWidth,
                            maximum: sizes.maxWidth
                        ), spacing: sizes.spacing),
                    ], spacing: sizes.spacing) {
                        
                    ForEach(content.images, id: \.id) { image in
                        ZStack {
                            GeometryReader { gr in
                                GalleryItem(
                                        mediaItem: image,
                                        cellSize: gr.size.width,
                                        selected: selectedImages.contains(image.id),
                                        highQuality: image.photoQuality > 0.75
                                    )
                            }
                        }
                        .aspectRatio(1, contentMode: .fill)
                        .overlay {
                            
                            Button {
                                
                                if let index = selectedImages.firstIndex(of: image.id) {
                                    selectedImages.remove(at: index)
                                }
                                else {
                                    selectedImages.append(image.id)
                                }
                            } label: {
                                Color.clear
                                .contentShape(Rectangle())
                                .clipShape(Rectangle())
                            }
                        }
                    }
                }
                if content.state == .loading {
                    Text("Loading...")
                }
                else if content.state == .hasMore {
                    Button("Load") {
                        Task(priority: .userInitiated) {
                            await content.loadMore(sizes.batchSize)
                        }
                    }
                    .border(.red, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .overlay {
                        GeometryReader { gr in
                            Color.clear.preference(
                                key: LoadMoreYPositionKey.self,
                                value: parentGR.size.height + parentGR.safeAreaInsets.top + parentGR.safeAreaInsets.bottom - gr.frame(in: CoordinateSpace.global).minY
                            )
                        }
                    }
                    .onPreferenceChange(LoadMoreYPositionKey.self) { value in
                        if value > 0 && content.state == .hasMore {
                            print("Autoload")
                            Task(priority: .userInitiated) {
                                await content.loadMore(sizes.batchSize)
                            }
                        }
                        prevYOffset = value
                    }
                }
            }
        }
    }
}
