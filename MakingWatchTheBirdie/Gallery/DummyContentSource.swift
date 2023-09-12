//
//  DummyContentSource.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.09.2023.
//

import Foundation

class DummyContentSource: ContentSource {
    
    static var imagesCount: Int = 72
    var loadedImages: [MediaItem] = []
    
    func loadMore(after mediaItem: MediaItem?, batchSize: Int) async throws -> [MediaItem] {
    
        guard loadedImages.count < DummyContentSource.imagesCount else {
            return []
        }
        
        try await Task.sleep(nanoseconds: UInt64(3 * Double(NSEC_PER_SEC)))

        let indexOfStartItem = loadedImages.firstIndex { $0.id == mediaItem?.id }
        
        let rangeStart = indexOfStartItem == nil ? 0 : (indexOfStartItem! + 1)
        let imagesRange: Range<Int> = rangeStart..<(rangeStart + batchSize)
        
        print("indexOfStartItem", indexOfStartItem, batchSize, rangeStart + batchSize)

        let newImages: [MediaItem] = imagesRange.map { imageId in
            let imageIdStr = String(format: "Sample %d", imageId+1)
            print("imageIdStr \(imageIdStr)")
            return MediaItem.from(imageIdStr)
        }.compactMap{ $0 }
        
        print("newImages", newImages.count)
        loadedImages += newImages
        return newImages
    }
}

extension MediaItem {
    
    static func from(_ imageName: String) -> MediaItem? {
        
        guard let url = URL.of(imageName) else {
            return nil
        }
        return MediaItem(
            id: UUID(),
            url: url,
            photoQuality: Float.random(in: 0...1)
        )
    }
}
