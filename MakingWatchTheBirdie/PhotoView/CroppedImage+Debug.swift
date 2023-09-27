//
//  CroppedImage+Debug.swift
//  watchthebirdie
//
//  Created by Andrey Zarembo-Godzyatskiy on 05.09.2023.
//

import Foundation
import UIKit

extension CroppedImageViewController {
    
    func setupDebug() {
                
        if debug {
            
            scrollView.showsVerticalScrollIndicator = true
            scrollView.showsHorizontalScrollIndicator = true
            
            view.layer.borderColor = UIColor.yellow.cgColor
            view.layer.borderWidth = 2
            
            scrollView.layer.backgroundColor = UIColor.cyan.withAlphaComponent(0.10).cgColor
            scrollView.layer.borderColor = UIColor.cyan.cgColor
            scrollView.layer.borderWidth = 4
            
            containerView.layer.backgroundColor = UIColor.orange.withAlphaComponent(0.10).cgColor
            containerView.layer.borderColor = UIColor.orange.cgColor
            containerView.layer.borderWidth = 3
            
            imageView.layer.backgroundColor = UIColor.purple.withAlphaComponent(0.10).cgColor
            imageView.layer.borderColor = UIColor.purple.cgColor
            imageView.layer.borderWidth = 3
            
            cropView.layer.backgroundColor = UIColor.purple.withAlphaComponent(0.10).cgColor
            cropView.layer.borderColor = UIColor.red.cgColor
            cropView.layer.borderWidth = 3
            
            let centerPointLayer = CAShapeLayer()
            centerPointLayer.fillColor = UIColor.red.cgColor
            centerPointLayer.path = CGPath.init(ellipseIn: CGRect(origin: CGPoint(x: -2, y: -2), size: CGSize(width: 4, height: 4)), transform: nil)
            cropCenterView.layer.addSublayer(centerPointLayer)
            cropCenterView.translatesAutoresizingMaskIntoConstraints = false
            cropView.addSubview(cropCenterView)
            
            let centerPointLayer2 = CAShapeLayer()
            centerPointLayer2.fillColor = UIColor.purple.cgColor
            centerPointLayer2.path = CGPath.init(ellipseIn: CGRect(origin: CGPoint(x: -2, y: -2), size: CGSize(width: 4, height: 4)), transform: nil)
            imageCenterView.layer.addSublayer(centerPointLayer2)
            imageCenterView.translatesAutoresizingMaskIntoConstraints = false
            imageView.addSubview(imageCenterView)
        }
        else {

            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
            
            containerView.clipsToBounds = true
        }
    }
    
}
