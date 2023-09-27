//
//  CroppedImage+CropDrag.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 05.09.2023.
//

import Foundation
import UIKit
import SwiftUI

enum Handle {
    case center
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case none
}

extension CroppedImageViewController {
    
    func didMove(with context: TouchContext, endPosition: CGPoint) {
        
        let handle = context.handle
        let startPosition = context.startLocation
    
        let len = sqrt(pow(originalImageSize.width, 2) +
                       pow(originalImageSize.height, 2))
        
        let cropScale = CGAffineTransform(scaleX: len, y: len)
        let cropTransform = cropScale.rotated(by: angle.radians)
        let cropCenterShift = CGAffineTransform(translationX: len / 2, y: len / 2 )
        let pointsTransform = cropTransform.concatenating(cropCenterShift).inverted()
        let sizeTransform = cropScale.inverted()
        
        let cropS = self.containerView.convert(startPosition, from: self.touchPanel.coordinateSpace).applying(pointsTransform)
        let cropE = self.containerView.convert(endPosition, from: self.touchPanel.coordinateSpace).applying(pointsTransform)
        
        let cropW = self.containerView.convert(startPosition, from: self.touchPanel.coordinateSpace).x - self.containerView.convert(endPosition, from: self.touchPanel.coordinateSpace).x
        let cropH = self.containerView.convert(startPosition, from: self.touchPanel.coordinateSpace).y - self.containerView.convert(endPosition, from: self.touchPanel.coordinateSpace).y
        
        var deltaSize: CGSize = CGSize()
        var deltaShift: CGPoint = CGPoint()
        if handle == .center {
            deltaShift = CGPoint(x: cropE.x - cropS.x, y: cropE.y - cropS.y)
        }
        else if handle == .topLeft {
            deltaShift = CGPoint(x: (cropE.x - cropS.x)/2, y: (cropE.y - cropS.y)/2)
            deltaSize = CGSize(width: cropW, height: cropH).applying(sizeTransform)
        }
        else if handle == .topRight {
            deltaShift = CGPoint(x: (cropE.x - cropS.x)/2, y: (cropE.y - cropS.y)/2)
            deltaSize = CGSize(width: -cropW, height: cropH).applying(sizeTransform)
        }
        else if handle == .bottomRight {
            deltaShift = CGPoint(x: (cropE.x - cropS.x)/2, y: (cropE.y - cropS.y)/2)
            deltaSize = CGSize(width: -cropW, height: -cropH).applying(sizeTransform)
        }
        else if handle == .bottomLeft {
            deltaShift = CGPoint(x: (cropE.x - cropS.x)/2, y: (cropE.y - cropS.y)/2)
            deltaSize = CGSize(width: cropW, height: -cropH).applying(sizeTransform)
        }
        
        let minCropSize = self.minCropSize / len
        
        cropSize = CGSize(
            width: max(
                minCropSize,
                context.startCropSize.width + deltaSize.width
                ),
            height: max(
                minCropSize,
                context.startCropSize.height + deltaSize.height
                )
            )
        print("minCropSize", minCropSize)
        cropCenter = CGPoint(x: context.startCropCenter.x + deltaShift.x,
                             y: context.startCropCenter.y + deltaShift.y)
        
        
        
        self.coordinator?.cropSize?.wrappedValue = cropSize
        self.coordinator?.cropCenter?.wrappedValue = cropCenter
    }

    func screenPoint(of cropPoint: Handle) -> CGPoint {
        
        let len = sqrt(pow(originalImageSize.width, 2) + 
                       pow(originalImageSize.height, 2))
        
        let cropScale = CGAffineTransform(scaleX: len, y: len)
        let cropTransform = cropScale.rotated(by: angle.radians)
        let cropCenterShift = CGAffineTransform(translationX: len / 2, y: len / 2 )
        
        let tSize = cropSize.applying(cropScale)
        let tCrop = cropCenter.applying(cropTransform).applying(cropCenterShift)
        
        let result: CGPoint
        switch cropPoint {
        case .center:
            result = self.containerView.convert(tCrop, to: self.touchPanel.coordinateSpace)
        case .topLeft:
            result = self.containerView.convert(
                tCrop.applying(CGAffineTransform(translationX: -tSize.width/2, y: -tSize.height/2)),
                to: self.touchPanel.coordinateSpace)
        case .topRight:
            result = self.containerView.convert(
                tCrop.applying(CGAffineTransform(translationX: tSize.width/2, y: -tSize.height/2)),
                to: self.touchPanel.coordinateSpace)
        case .bottomLeft:
            result = self.containerView.convert(
                tCrop.applying(CGAffineTransform(translationX: -tSize.width/2, y: tSize.height/2)),
                to: self.touchPanel.coordinateSpace)
        case .bottomRight:
            result = self.containerView.convert(
                tCrop.applying(CGAffineTransform(translationX: tSize.width/2, y: tSize.height/2)),
                to: self.touchPanel.coordinateSpace)
        case .none:
            result = CGPoint()
        }
        print("Location of \(cropPoint) at \(result)")
        return result
    }
}

struct TouchContext {
    var startLocation: CGPoint
    var handle: Handle
    var startCropSize: CGSize
    var startCropCenter: CGPoint
}

final class CropTouchPanel: UIView {
    
    static var handleSize: CGFloat = 48
    
    weak var delegate: CropTouchPanelDelegate?
    var cropHandlesDrag: UIPanGestureRecognizer!
    
    var touchContext: TouchContext?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cropHandlesDrag = UIPanGestureRecognizer(target: self, action: #selector(onPanGesture))
        
//        self.layer.backgroundColor = UIColor.red.withAlphaComponent(0.25).cgColor
        self.addGestureRecognizer(cropHandlesDrag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handlePoints() -> [Handle: CGPoint] {
        
        guard let _delegate = self.delegate else {
            return [:]
        }
        
        let centerPt = _delegate.screenPoint(of: .center)
        let topLeft = _delegate.screenPoint(of: .topLeft)
        let topRight = _delegate.screenPoint(of: .topRight)
        let bottomLeft = _delegate.screenPoint(of: .bottomLeft)
        let bottomRight = _delegate.screenPoint(of: .bottomRight)
        
        return [
            .topLeft: topLeft,
            .topRight: topRight,
            .bottomLeft: bottomLeft,
            .bottomRight: bottomRight,
            .center: centerPt
        ]
        
    }
    
    public func handleFromPoint(point: CGPoint) -> Handle {
        
        let points = handlePoints()
        
        for handle in [
            Handle.topLeft,
            Handle.topRight,
            Handle.bottomLeft,
            Handle.bottomRight,
            Handle.center
        ] {
            
//            print("@\(handle)", points[handle], point)
            
            if points[handle]!.distance(to: point) <= CropTouchPanel.handleSize {
//                print("Detected \(handle)")
                return handle
            }
        }
        
        return .none
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if delegate?.mode != .crop {
            return nil
        }
        
        let handle = handleFromPoint(point: point)
        print("Detect at \(point) - \(handle)")
        if handle == .none {
            return nil
        }
        
        return self
    }
    
    @objc func onPanGesture(_ gesture: UIPanGestureRecognizer) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        let point = gesture.location(in: self)
        print("Touch at \(point)")
        if gesture.state == .began {
            
            let handle = handleFromPoint(point: point)
            if handle == .none {
                gesture.state = .cancelled
                
                return
            }
            
            self.touchContext = TouchContext(
                startLocation: delegate.screenPoint(of: handle),  //point,
                handle: handle,
                startCropSize: delegate.cropSize,
                startCropCenter: delegate.cropCenter
            )
            
        }
        else if gesture.state == .changed, let context = touchContext {
            
            self.delegate?.didMove(with: context, endPosition: point)
        }

    }
    
}

struct CropTouchPanel_Preview: PreviewProvider {
    static var previews: some View {
        CroppedImageDebug()
    }
}
