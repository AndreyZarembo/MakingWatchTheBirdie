//
//  UIView+PinSubview.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 30.08.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func addAndPin(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        self.leadingAnchor.constraint(equalTo: subview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: subview.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: subview.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
    }
    
}
