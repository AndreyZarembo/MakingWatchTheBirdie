//
//  cropTestMediaRecord.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 31.08.2023.
//

import Foundation
import UIKit
import SwiftUI

extension MediaRecord {
    
    static func cropTestMedia() -> MediaRecord {
        
        let imageSize = CGSize(width: 1089, height: 721)
        let origURL = URL.of("CropTestOriginal")!
        let cropURL = URL.of("CropTestCropped")!
        let date = Date()
        
        return MediaRecord(
            id: UUID(),
            date: date,
            imageURL: cropURL,
            cropAndRotateData: CropAndRotateData(
                cropCenter: CGPoint(x: 0.1, y: 0.0),
                cropSize: CGSize(width: 0.4, height: 0.3),
                angle: Angle(degrees: 30).radians,
                largeAngle: .a0
            ),
            originalURL: origURL,
            originalImageSize: imageSize,
            imageQuality: 1.0,
            filterInfo: FilterInfo(filterId: "none", parameters: [:]),
            stickers: [],
            modificationDate: date
        )
    }
}
