//
//  GalleryItem.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.09.2023.
//

import SwiftUI

struct GalleryItem: View {
    
    var mediaItem: MediaItem
    var cellSize: CGFloat
    var selected: Bool
    var highQuality: Bool
    
    var iconSize: CGFloat {
        if cellSize > 256 {
            return 48
        }
        else if cellSize >= 96 {
            return 32
        }
        else if cellSize >= 64 {
            return 24
        }
        else {
            return 20
        }
    }
    
    var body: some View {
        
        ZStack {
            
            
            AsyncImage(url: mediaItem.url) { $0.image?.resizable().scaledToFill()}
            .frame(width: cellSize, height: cellSize)
            .clipped()
            .overlay {
                
                if highQuality {
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundColor(.yellow)
                                .frame(width: iconSize*0.75, height: iconSize*0.75)
                                .padding(2)
                            Spacer()
                        }
                    }
                }
            }
            
            if selected {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: iconSize, height: iconSize)
            }
        }
    }
}

#Preview("320") {
    GalleryItem(
        mediaItem: MediaItem.from("Sample 22")!,
        cellSize: 320, selected: true, highQuality: true
    )
}

#Preview("250") {
    GalleryItem(
        mediaItem: MediaItem.from("Sample 22")!,
        cellSize: 250, selected: true, highQuality: true
    )
}

#Preview("125") {
    GalleryItem(
        mediaItem: MediaItem.from("Sample 22")!,
        cellSize: 125, selected: true, highQuality: true
    )
}

#Preview("96") {
    GalleryItem(
        mediaItem: MediaItem.from("Sample 22")!,
        cellSize: 96, selected: true, highQuality: true
    )
}

#Preview("64") {
    GalleryItem(
        mediaItem: MediaItem.from("Sample 22")!,
        cellSize: 64, selected: true, highQuality: true
    )
}

#Preview("48") {
    GalleryItem(
        mediaItem: MediaItem.from("Sample 22")!,
        cellSize: 48, selected: true, highQuality: true
    )
}
