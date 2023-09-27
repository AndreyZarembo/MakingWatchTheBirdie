//
//  CropAndRotateData.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 16.08.2023.
//

import Foundation


enum RotateLargeAnge: Int, Codable {
    case a0 = 0
    case a90 = 90
    case a180 = 180
    case a270 = 270
    
    var nextCCW: RotateLargeAnge {
        switch self {
        case .a0:
            return .a270
        case .a90:
            return .a0
        case .a180:
            return .a90
        case .a270:
            return .a180
        }
    }
    
    var nextCW: RotateLargeAnge {
        switch self {
        case .a0:
            return .a90
        case .a90:
            return .a180
        case .a180:
            return .a270
        case .a270:
            return .a0
        }
    }
    
    func fullAngle(_ angle: CGFloat) -> CGFloat {
        var result = angle
        
        switch self {
        case .a0:
            result += 0
        case .a90:
            result += CGFloat.pi/2
        case .a180:
            result += CGFloat.pi
        case .a270:
            result -= CGFloat.pi/2
        }
        
        return result
    }
}

struct CropAndRotateData: Codable {
    
    let angle: CGFloat
    let largeAngle: RotateLargeAnge
    let cropCenter: CGPoint
    let cropSize: CGSize

    var fullAngle: CGFloat {
        
        return self.largeAngle.fullAngle(self.angle)
    }
    
    init(cropCenter: CGPoint = CGPoint(), cropSize: CGSize = CGSize(), angle: CGFloat = 0, largeAngle: RotateLargeAnge = .a0) {
        self.angle = angle
        self.largeAngle = largeAngle
        self.cropCenter = cropCenter
        self.cropSize = cropSize
    }
    
    func resized(_ newSize: CGSize) -> CropAndRotateData {
        return CropAndRotateData(cropCenter: self.cropCenter, cropSize: newSize, angle: self.angle, largeAngle: self.largeAngle)
    }
    
    func translated(_ newCenter: CGPoint) -> CropAndRotateData {
        return CropAndRotateData(cropCenter: newCenter, cropSize: self.cropSize, angle: self.angle, largeAngle: self.largeAngle)
    }
    
    func rotated(_ newAngle: CGFloat) -> CropAndRotateData {
        return CropAndRotateData(cropCenter: self.cropCenter, cropSize: self.cropSize, angle: newAngle, largeAngle: self.largeAngle)
    }
    
    func rotated(_ newLargeAngle: RotateLargeAnge) -> CropAndRotateData {
        return CropAndRotateData(cropCenter: self.cropCenter, cropSize: self.cropSize, angle: self.angle, largeAngle: newLargeAngle)
    }
    
    func rotated90cw() -> CropAndRotateData {
        return self.rotated(self.largeAngle.nextCW)
    }
    
    func rotated90ccw() -> CropAndRotateData {
        return self.rotated(self.largeAngle.nextCCW)
    }
    
    var originalToCropTransform: CGAffineTransform {
        
        let rotate = CGAffineTransform(rotationAngle: self.fullAngle)
        let translate = rotate.translatedBy(x: -self.cropCenter.x, y: -self.cropCenter.y)
        return translate
    }
    
    func resetCropAndRotate(originalSize: CGSize) -> CropAndRotateData {
        return CropAndRotateData(cropSize: originalSize)
    }
}
