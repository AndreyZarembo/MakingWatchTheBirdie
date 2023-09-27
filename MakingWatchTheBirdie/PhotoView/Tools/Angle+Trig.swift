//
//  Angle+Trig.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 05.09.2023.
//

import Foundation
import SwiftUI

extension Angle {
    
    var sin: CGFloat {
        return CoreGraphics.sin(CGFloat(self.radians))
    }
    
    var cos: CGFloat {
        return CoreGraphics.cos(CGFloat(self.radians))
    }
}
