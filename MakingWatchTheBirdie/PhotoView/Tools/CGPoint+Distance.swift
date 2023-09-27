//
//  CGPoint+Distance.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 05.09.2023.
//

import Foundation

extension CGPoint {
    
    func distance(to secondPoint: CGPoint) -> CGFloat {
        return sqrt( pow(secondPoint.x - self.x,2) + pow(secondPoint.y - self.y,2) )
    }
    
}
