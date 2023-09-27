//
//  MediaRecord.swift
//  photos
//
//  Created by a.zarembo on 02.01.2020.
//  Copyright © 2020 a.zarembo. All rights reserved.
//

import Foundation
import UIKit

struct MediaRecord {
    
    let id: UUID
    
    let date: Date
    let imageURL: URL
    
    let cropAndRotateData: CropAndRotateData
    
    let originalURL: URL
    
    let originalImageSize: CGSize
    
    let imageQuality: Float
    
    static let bestPhotoQuality: Float = 7
    let filterInfo: FilterInfo
    let stickers: [StickerInfo]
    let modificationDate: Date
}

extension MediaRecord {
    
    var previewCacheKey: String {
        return "preview_\(self.id.uuidString)"
    }
    
    var imageCacheKey: String {
        return "\(self.id.uuidString)"
    }
    
    var originalCacheKey: String {
        return "original_\(self.id.uuidString)"
    }
}
