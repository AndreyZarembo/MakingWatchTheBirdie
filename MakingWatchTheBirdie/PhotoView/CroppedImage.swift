//
//  CroppedImage.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 31.08.2023.
//

import Foundation
import UIKit
//import Kingfisher
import SwiftUI


enum ViewMode {
    case view
    case edit
    case crop
}

final class CroppedImageViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate, CropTouchPanelDelegate {
    
    let id: UUID

    let imageURL: URL
    let originalURL: URL

    var angle: Angle {
        didSet {
            self.setupImageView()
        }
    }
    var rotation: RotateLargeAnge {
        didSet {
            self.setupImageView()
        }
    }

    var cropSize: CGSize {
        didSet {
            self.setupImageView()
        }
    }
    var cropCenter: CGPoint {
        didSet {
            self.setupImageView()
        }
    }
    
    let originalImageSize: CGSize
    
    let edit_mode_edge: CGFloat = 96
    let view_mode_edge: CGFloat = 0
    let minCropSize: CGFloat = 128
    
    var scrollView: UIScrollView = UIScrollView(frame: CGRect())
    var containerView: UIView = UIView(frame: CGRect())
    var imageView: UIImageView = UIImageView(frame: CGRect())
    var touchPanel: CropTouchPanel = CropTouchPanel(frame: CGRect())
    
    var cropView: UIView = UIView(frame: CGRect())
    var cropCenterView = UIView(frame: CGRect())
    var imageCenterView = UIView(frame: CGRect())
        
    var previousConstraints: [NSLayoutConstraint] = []
    
    var coordinator: CroppedImageCoordinator? = nil
    
    var debug: Bool = true
    
    var reportZoomChange: Bool = false
    var zoom: CGFloat = 1 {
        didSet {
            self.scrollView.zoomScale = self.zoom
        }
    }
    
    var mode: ViewMode = .crop {
        didSet {
            loadImage()
        }
    }
    
    init(
        id: UUID,
        imageURL: URL,
        originalURL: URL,
        angle: Angle,
        rotation: RotateLargeAnge,
        cropSize: CGSize,
        cropCenter: CGPoint,
        originalImageSize: CGSize
    ) {
        
        self.id = id
        self.imageURL = imageURL
        self.originalURL = originalURL
        self.angle = angle
        self.rotation = rotation
        self.cropSize = cropSize
        self.cropCenter = cropCenter
        self.originalImageSize = originalImageSize
                
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
        
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 10
        scrollView.delegate = self
                
        self.setupDebug()
        
        self.view.addAndPin(self.scrollView)
        self.view.addAndPin(self.touchPanel)
        
        self.touchPanel.delegate = self
        
        scrollView.addAndPin(containerView)
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(self.imageView)
                
        cropView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(cropView)
        
        loadImage()
    }
    
    func loadImage() {
        let url: URL
        if mode == .view {
           url = imageURL
        } else {
            url = originalURL
        }
        
        let data = try! Data(contentsOf: url)
        self.imageView.image = UIImage(data: data)
        self.setupImageView()
        self.refreshOffsetAndZoom()
    }
    
    func setupImageView() {
        
        NSLayoutConstraint.deactivate(previousConstraints)
        previousConstraints = []
        
        let imageSize = originalImageSize
        
        let angle: Angle
        
        if mode == .view {
            angle = Angle()
        }
        else {
            angle = Angle(radians: rotation.fullAngle(self.angle.radians))
        }
        
        let len = sqrt(pow(imageSize.width, 2) + pow(imageSize.height, 2))
        
        let cropZoom = CGAffineTransform(scaleX: 1 /*self.zoom*/, y:  1 /*self.zoom*/)
        let cropScale = CGAffineTransform(scaleX: len, y: len).concatenating(cropZoom)
        let cropTransform = cropScale.rotated(by: angle.radians)
        let cropCenterShift: CGAffineTransform
        if mode == .edit {
            cropCenterShift = CGAffineTransform.identity
        }
        else {
            cropCenterShift = CGAffineTransform(translationX: len / 2, y: len / 2 )
        }
        
        
        let tSize = cropSize.applying(cropScale)
        let tCrop = cropCenter.applying(cropTransform).applying(cropCenterShift)
        
        let containerWidth: CGFloat
        let containerHeight: CGFloat
        if mode == .crop {
            containerWidth = len
            containerHeight = len
        }
        else {
            containerWidth = tSize.width
            containerHeight = tSize.height
        }
        
        let cw = containerView.widthAnchor.constraint(equalToConstant: containerWidth)
        let ch = containerView.heightAnchor.constraint(equalToConstant: containerHeight)
        
        previousConstraints.append(cw)
        previousConstraints.append(ch)
        
        cw.isActive = true
        ch.isActive = true
        
        let imageViewShiftX: CGFloat
        let imageViewShiftY: CGFloat
        
        if mode == .crop || mode == .view {
            imageViewShiftX = 0
            imageViewShiftY = 0
        }
        else {
            imageViewShiftX = -tCrop.x
            imageViewShiftY = -tCrop.y
            print("tCrop \(tCrop)")
        }
        
        let icx = imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: imageViewShiftX)
        let icy = imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: imageViewShiftY)
        
        previousConstraints.append(icx)
        previousConstraints.append(icy)
        
        icx.isActive = true
        icy.isActive = true

        imageView.transform = CGAffineTransform(rotationAngle: angle.radians)

        imageCenterView.center = CGPoint(
            x: imageView.image?.size.width ?? 0 / 2,
            y: imageView.image?.size.height ?? 0 / 2)
                
        cropView.bounds = CGRect(
            x: 0,
            y: 0,
            width: tSize.width,
            height: tSize.height)
        
        let cropViewCenterShiftX: CGFloat
        let cropViewCenterShiftY: CGFloat
        
        if mode == .crop {
            cropViewCenterShiftX = tCrop.x
            cropViewCenterShiftY = tCrop.y
        }
        else {
            cropViewCenterShiftX = containerWidth/2
            cropViewCenterShiftY = containerHeight/2
        }
        
        cropView.center = CGPoint(
            x:  cropViewCenterShiftX,
            y:  cropViewCenterShiftY
        )
        
        cropCenterView.center = CGPoint(
            x: tSize.width/2,
            y: tSize.height/2)
    }
    
    func refreshOffsetAndZoom() {
        
        let imageSize = originalImageSize
        let len = sqrt(pow(imageSize.width, 2) + pow(imageSize.height, 2))
        
        self.view.layoutIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(5)), execute: {
            
            if self.mode == .crop {
                self.zoom = self.view.frame.width / len
            }
            else {

                self.zoom = self.view.frame.width / (len * self.cropSize.width)
            }
            self.updateOffsets()
            self.view.alpha = 1
        })
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containerView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateOffsets()
        if self.reportZoomChange {
            self.coordinator?.zoom?.wrappedValue = scrollView.zoomScale
        }
        updateCenterOffset()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCenterOffset()
    }

    func updateCenterOffset() {
        let containerCenter: CGPoint = self.view.convert(containerView.center, from: scrollView.coordinateSpace)
        let viewCenter: CGPoint = self.view.center
        let shift: CGPoint = CGPoint(x: containerCenter.x - viewCenter.x,
                                     y: containerCenter.y - viewCenter.y
        )
        Task {
            self.coordinator?.centerShift?.wrappedValue = shift
//            self.coordinator?.centerShift?.update()
        }
//        print("\(scrollView.contentOffset)")
    }
    
    func updateOffsets() {
        
        let edge: CGFloat = view_mode_edge
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, edge)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, edge)
        scrollView.contentInset = UIEdgeInsets(
            top: offsetY,
            left: offsetX,
            bottom: offsetY,
            right: offsetX
        )
        updateCenterOffset()
    }
}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        CroppedImageDebug()
    }
}
