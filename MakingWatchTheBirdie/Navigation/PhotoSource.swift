//
//  PhotoSource.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.10.2023.
//

import Foundation

class PhotoSource: ContentSource {
    
    static var imagesCount: Int = 72
    var loadedImages: [MediaItem] = []
    
    func loadMore(after mediaItem: MediaItem?, batchSize: Int) async throws -> [MediaItem] {
    
        guard loadedImages.count < DummyContentSource.imagesCount else {
            return []
        }
        
        let indexOfStartItem = loadedImages.firstIndex { $0.id == mediaItem?.id }
        
        let rangeStart = indexOfStartItem == nil ? 0 : (indexOfStartItem! + 1)
        let imagesRange: Range<Int> = rangeStart..<(rangeStart + batchSize)
        
        let newImages: [MediaItem] = imagesRange.map { imageId in
            let imageIdStr = String(format: "Sample %d", imageId+1)
            return MediaItem.from(imageIdStr)
        }.compactMap{ $0 }
        
        loadedImages += newImages
        return newImages
    }
}
