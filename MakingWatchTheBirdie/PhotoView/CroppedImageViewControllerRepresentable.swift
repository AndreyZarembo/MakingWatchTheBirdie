//
//  CroppedImageViewControllerRepresentable.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 05.09.2023.
//

import Foundation
import SwiftUI

struct CroppedImageViewControllerRepresentable: UIViewControllerRepresentable {
    
    let id: UUID

    let imageURL: URL
    let originalURL: URL

    var angle: Angle
    var rotation: RotateLargeAnge
    @Binding var cropSize: CGSize
    @Binding var cropCenter: CGPoint
    
    let originalImageSize: CGSize
    
    var mode: ViewMode = .view
    
    @Binding var zoom: CGFloat
    @Binding var centerShift: CGPoint
    
    func makeUIViewController(context: Context) -> CroppedImageViewController {
        let uiViewController = CroppedImageViewController(
            id: id,
            imageURL: imageURL,
            originalURL: originalURL,
            angle: angle,
            rotation: rotation,
            cropSize: cropSize,
            cropCenter: cropCenter,
            originalImageSize: originalImageSize
        )
        uiViewController.coordinator = context.coordinator
        uiViewController.coordinator?.zoom = $zoom
        uiViewController.coordinator?.centerShift = $centerShift
        uiViewController.coordinator?.cropSize = $cropSize
        uiViewController.coordinator?.cropCenter = $cropCenter
        return uiViewController
    }
    
    func updateUIViewController(_ uiViewController: CroppedImageViewController, context: Context) {
        uiViewController.reportZoomChange = false
        uiViewController.zoom = self.zoom
        uiViewController.reportZoomChange = true
        
        if uiViewController.angle != angle {
            uiViewController.angle = angle
        }
        
        if uiViewController.mode != mode {
            uiViewController.mode = mode
        }
        if uiViewController.cropSize != cropSize {
            uiViewController.cropSize = cropSize
        }
        if uiViewController.cropCenter != cropCenter {
            uiViewController.cropCenter = cropCenter
        }
    }
    
    func makeCoordinator() -> CroppedImageCoordinator {
        return CroppedImageCoordinator()
    }
}
