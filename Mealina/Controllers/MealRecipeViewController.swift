//
//  MealViewController.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit
import PromiseKit
import SDWebImage
class MealRecipeViewController: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var mealImage: UIImageView! {
        didSet {
            mealImage.setImageCornerRadius(8)
        }
    }
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var others: UILabel!
    @IBOutlet weak var instruction: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var countItems: UILabel!
  
    @IBOutlet weak var instructionContainerView: UIView!
    
    var mealService = MealService()
    var recipies = [Recipes]()
    var idMeal: String?
    var indicatorView: IVLoaderIndicator!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        title = "Recipe"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        indicatorView = IVLoaderIndicator(superView: self.view)
        indicatorView.addChildIndicatorView()
        
        for _ in 0..<10  {
            addChildrenStackViews()
        }
        
        firstly {
            mealService.get(ofType: Recipe.self, target: .getRecipeRequest(byidMeal: "52874"))
        }.done { result in
            self.recipies = result.meals
            let recipe = self.recipies[0]
            self.mealName.text = recipe.strMeal
            let tags = recipe.strTags?.replacingOccurrences(of: ",", with: " | ")
            self.others.text = "\(recipe.strArea) | \(recipe.strCategory) | \(tags!)"
            self.mealImage.sd_setImage(with: URL(string: recipe.strMealThumb))
            self.mealImage.sd_imageTransition = .fade(duration: 1)
            self.instruction.text = self.toNumberListInstruction(recipe.strInstructions)
        }.catch { error in
            print(error.localizedDescription)
        }
        
      
        
    }
    
    fileprivate func toNumberListInstruction(_ strInstruction: String) -> String {
        let separtedString = strInstruction.components(separatedBy: "\r\n")
        let strMap = separtedString.enumerated().map { (index, str) in
            return "\(index + 1).  \(str)"
        }.joined(separator: "\n")
        return strMap
    }
    
    private func addChildrenStackViews() {
       
        let ingredientImage = UIImageView(image: UIImage(named: "meal")!)
        let ingredientName = UILabel()
        ingredientName.text = "Tiktokerist"
        ingredientName.font = .systemFont(ofSize: 16)
        ingredientName.textColor = .darkGray
        ingredientImage.layer.cornerRadius = 8
        ingredientImage.clipsToBounds = true
        
        let ingredientContent = UILabel()
        ingredientContent.text = "20grams"
        ingredientContent.font = .systemFont(ofSize: 16)
        ingredientContent.textColor = .darkGray
        
        NSLayoutConstraint.activate([
            ingredientImage.widthAnchor.constraint(equalToConstant: 40),
            ingredientImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let innerStackView = UIStackView(arrangedSubviews: [ingredientImage, ingredientName])
        let itemStackView = UIStackView(arrangedSubviews: [innerStackView, ingredientContent])
        
        itemStackView.axis = .horizontal
        innerStackView.axis = .horizontal
        innerStackView.spacing = 20
        itemStackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemStackView)
        
    }

}


let str = "Preheat the oven to 150C/300F/Gas 2.\r\nToss the beef and flour together in a bowl with some salt and black pepper.\r\nHeat a large casserole until hot, add half of the rapeseed oil and enough of the beef to just cover the bottom of the casserole.\r\nFry until browned on each side, then remove and set aside. Repeat with the remaining oil and beef.\r\nReturn the beef to the pan, add the wine and cook until the volume of liquid has reduced by half, then add the stock, onion, carrots, thyme and mustard, and season well with salt and pepper.\r\nCover with a lid and place in the oven for two hours.\r\nRemove from the oven, check the seasoning and set aside to cool. Remove the thyme.\r\nWhen the beef is cool and you're ready to assemble the pie, preheat the oven to 200C/400F/Gas 6.\r\nTransfer the beef to a pie dish, brush the rim with the beaten egg yolks and lay the pastry over the top. Brush the top of the pastry with more beaten egg.\r\nTrim the pastry so there is just enough excess to crimp the edges, then place in the oven and bake for 30 minutes, or until the pastry is golden-brown and cooked through.\r\nFor the green beans, bring a saucepan of salted water to the boil, add the beans and cook for 4-5 minutes, or until just tender.\r\nDrain and toss with the butter, then season with black pepper.\r\nTo serve, place a large spoonful of pie onto each plate with some green beans alongside."
