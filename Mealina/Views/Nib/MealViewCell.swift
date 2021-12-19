//
//  MealViewCell.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit

class MealViewCell: UITableViewCell {
    
    static let identifier = "meals_cell"
    static let nibName = "MealViewCell"
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mealImage.setImageCornerRadius(8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static public func mealNib() -> UINib {
        return UINib(nibName: MealViewCell.nibName, bundle: nil)
    }
    
}
