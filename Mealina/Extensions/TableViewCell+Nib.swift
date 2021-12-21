//
//  TableViewCell+Nib.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/21/21.
//

import Foundation
import UIKit


extension UITableViewCell {
    static public func loadCustomNib(nibName: String) -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
