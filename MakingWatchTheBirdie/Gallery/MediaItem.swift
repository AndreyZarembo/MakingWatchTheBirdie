//
//  MediaItem.swift
//  MakingWatchTheBirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 11.09.2023.
//

import Foundation

struct MediaItem: Identifiable {
    let id: UUID
    let url: URL
    let photoQuality: Float
}

extension MediaItem: Hashable {
    
}
