//
//  UIVIew+shadow.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import Foundation
import UIKit


extension UIView {
    
    func addShadow() {
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 4.0, height: 0.0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.6
    }
    
}
