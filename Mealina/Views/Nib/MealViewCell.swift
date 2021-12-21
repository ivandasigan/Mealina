//
//  MealViewCell.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit
import SDWebImage

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
    
    public func bind(meal: Meals) {
        self.mealImage.sd_setImage(with: URL(string: meal.strMealThumb))
        self.mealImage.sd_imageTransition = .fade(duration: 1)
        self.mealName.text = meal.strMeal
    }
    private func downloadPhotos(imgUrlThumb: String) -> UIImage {
      
            guard let imageUrlThumb = URL(string: imgUrlThumb) else {
                return UIImage()
            }
            guard let data = try? Data(contentsOf: imageUrlThumb) else {
                return UIImage()
            }
                                    
            guard let photo = UIImage(data: data) else {
                return UIImage()
            }
            return photo
        
    }

    
}
