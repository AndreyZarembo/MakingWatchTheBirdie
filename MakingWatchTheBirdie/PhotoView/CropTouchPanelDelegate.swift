//
//  CropTouchPanelDelegate.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 05.09.2023.
//

import Foundation
import SwiftUI

protocol CropTouchPanelDelegate: AnyObject {

    
    var angle: Angle { get }
    var rotation: RotateLargeAnge { get}

    var cropSize: CGSize { get }
    var cropCenter: CGPoint { get }
    var originalImageSize: CGSize { get }
    
    var zoom: CGFloat { get }
    
    var mode: ViewMode { get }
    
    func screenPoint(of cropPoint: Handle) -> CGPoint
    func didMove(with context: TouchContext, endPosition: CGPoint)
}
