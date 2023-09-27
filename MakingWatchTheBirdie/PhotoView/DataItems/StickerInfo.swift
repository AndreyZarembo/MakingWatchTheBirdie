//
//  StickerInfo.swift
//  iOSWatchTheBirdie
//
//  Created by 18457250 on 29.05.2020.
//  Copyright © 2020 a.zarembo. All rights reserved.
//

import Foundation
import UIKit

struct StickerInfo: Codable, Equatable {
    
    static var stickerSize: CGFloat = 128
    
    var uuid: UUID
    var identifier: String
    var location: CGPoint // Относительно центра оригинальной фотки
    var scale: CGFloat
    var angle: CGFloat
    
    var mirror: Bool
    
    init(identifier: String, location: CGPoint, scale: CGFloat, angle: CGFloat = 0, mirror: Bool = false) {
        self.uuid = UUID()
        self.identifier = identifier
        self.location = location
        self.scale = scale
        self.angle = angle
        self.mirror = mirror
    }
    
    private init(uuid: UUID, identifier: String, location: CGPoint, scale: CGFloat, angle: CGFloat = 0, mirror: Bool = false) {
        self.uuid = uuid
        self.identifier = identifier
        self.location = location
        self.scale = scale
        self.angle = angle
        self.mirror = mirror
    }
}
