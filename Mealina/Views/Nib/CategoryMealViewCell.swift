//
//  CategoryMealViewCell.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit

class CategoryMealViewCell: UITableViewCell {
    
    static let nibName = "CategoryMealViewCell"
    static let identifier = "category_cell"
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryDescription: UILabel!
    @IBOutlet weak var labelsStack: UIStackView!
    
    var overlapView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        view.layer.cornerRadius = 0
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.categoryImage.layer.cornerRadius = 8
        self.categoryImage.clipsToBounds = true
      
        self.overlapView.frame = imageFrame(view: categoryImage)
     
        self.categoryImage.addSubview(overlapView)
        self.overlapView.addSubview(labelsStack)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    static public func categoryNib() -> UINib {
        return UINib(nibName: CategoryMealViewCell.nibName, bundle: nil)
    }
    
    fileprivate func imageFrame(view: UIImageView) -> CGRect {
        let height = view.frame.height
        let width = view.frame.width
        let xAxis = view.frame.minX
        let yAxis = view.frame.minY - 10
        return CGRect(x: xAxis, y: yAxis, width: width, height: height)
    }
}

