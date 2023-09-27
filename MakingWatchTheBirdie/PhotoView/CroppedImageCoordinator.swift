//
//  CroppedImageCoordinator.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 05.09.2023.
//

import Foundation
import SwiftUI

class CroppedImageCoordinator {
    
    var zoom: Binding<CGFloat>?
    var centerShift: Binding<CGPoint>?
    var cropCenter: Binding<CGPoint>?
    var cropSize: Binding<CGSize>?
}
