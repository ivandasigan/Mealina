//
//  UIView+CornerRadius.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/19/21.
//

import Foundation
import UIKit


extension UIView {
    
    func setImageCornerRadius(_ radiusValue: CGFloat) {
        self.layer.cornerRadius = radiusValue
        self.clipsToBounds = true
    }
    func setCornerRadius(_ radiusValue: CGFloat) {
        self.layer.cornerRadius = radiusValue
    }
}
