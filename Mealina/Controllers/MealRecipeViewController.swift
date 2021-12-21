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
    
    @IBOutlet weak var dummyStackView: UIStackView!
    
    //MARK: - INITIALIZATIONS
    var mealService = MealService()
    var recipies: Recipes!
    var idMeal: String?
    var indicatorView: IVLoaderIndicator!
    var ingredients = [String]()
    var measures = [String]()
    var numberOfItems = 0
    var footerIngredientVC = FooterIngredientsViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        title = "Recipe"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        indicatorView = IVLoaderIndicator(superView: self.view)
        indicatorView.addChildIndicatorView()
        
        dummyStackView.removeFromSuperview()
        
        firstly {
            self.indicatorView.showLoader()
        }.then(on: DispatchQueue.global(qos: .background), flags: nil) {
            self.mealService.get(ofType: Recipe.self, target: .getRecipeRequest(byidMeal: self.idMeal ?? "52874"))
        }.done { result in
            self.indicatorView.hideLoader()
            self.recipies = result.meals[0]
            
            //Update views
            self.mealName.text = self.recipies.strMeal
            let tags = self.recipies.strTags?.replacingOccurrences(of: ",", with: " | ")
            self.others.text = "\(self.recipies.strArea) | \(self.recipies.strCategory) | \(tags ?? "")"
            self.mealImage.sd_setImage(with: URL(string: self.recipies.strMealThumb))
            self.mealImage.sd_imageTransition = .fade(duration: 1)
            self.instruction.text = self.recipies.strInstructions
            //self.instruction.text = self.toNumberListInstruction(self.recipies.strInstructions)
            self.appendIngredientsAndMeasures()
            self.displayIngredients()
            self.countItems.text = "\(self.numberOfItems) \(self.numberOfItems != 0 ? "Items":"Item")"
            
        }.catch { error in
            self.indicatorView.hideLoader()
            
            self.showErrorAlert(message: error.localizedDescription)
        }
      
    }
    
    fileprivate func toNumberListInstruction(_ strInstruction: String) -> String {
        let separtedString = strInstruction.components(separatedBy: "\r\n")
        let strMap = separtedString.enumerated().map { (index, str) in
            return "\(index + 1). \(str)"
        }.joined(separator: "\n")
        return strMap
    }
    
    private func displayIngredients() {
        if ingredients.count == measures.count {
            for n in 0..<ingredients.count {
                print(ingredients[n] + measures[n])
                if(ingredients[n] != "" && ingredients[n] != " ") {
                    if(measures[n] != "" && measures[n] != " ") {
                        numberOfItems+=1
                        addChildrenStackViews(ingredientStr: ingredients[n], measure: measures[n])
                    }
                }
            }
        }
    }
    
    fileprivate func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        let tryAnother = UIAlertAction(title: "Try Another", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(tryAnother)
        
        present(alert, animated: true, completion: nil)
    }
   
    private func addChildrenStackViews(ingredientStr: String, measure: String) {
        let ingredient = ingredientStr.replacingOccurrences(of: " ", with: "%20")
        let ingredientImage = UIImageView()
        ingredientImage.sd_setImage(with: URL(string: "https://www.themealdb.com/images/ingredients/\(ingredient)-Small.png"))
        ingredientImage.sd_imageTransition = .fade(duration: 1)
        
        let ingredientName = UILabel()
        ingredientName.text = ingredientStr
        ingredientName.font = .systemFont(ofSize: 16)
        ingredientName.textColor = .darkGray
        ingredientImage.layer.cornerRadius = 8
        ingredientImage.clipsToBounds = true
        
        let ingredientContent = UILabel()
        ingredientContent.text = measure
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
    
    fileprivate func appendIngredientsAndMeasures() {
        ingredients.append(recipies.strIngredient1)
        ingredients.append(recipies.strIngredient2)
        ingredients.append(recipies.strIngredient3)
        ingredients.append(recipies.strIngredient4)
        ingredients.append(recipies.strIngredient5)
        ingredients.append(recipies.strIngredient6)
        ingredients.append(recipies.strIngredient7)
        ingredients.append(recipies.strIngredient8)
        ingredients.append(recipies.strIngredient9)
        ingredients.append(recipies.strIngredient10)
        ingredients.append(recipies.strIngredient11)
        ingredients.append(recipies.strIngredient12)
        ingredients.append(recipies.strIngredient13)
        ingredients.append(recipies.strIngredient14)
        ingredients.append(recipies.strIngredient15)
        ingredients.append(recipies.strIngredient16)
        ingredients.append(recipies.strIngredient17)
        ingredients.append(recipies.strIngredient18)
        ingredients.append(recipies.strIngredient19)
        ingredients.append(recipies.strIngredient20)
           
        measures.append(recipies.strMeasure1)
        measures.append(recipies.strMeasure2)
        measures.append(recipies.strMeasure3)
        measures.append(recipies.strMeasure4)
        measures.append(recipies.strMeasure5)
        measures.append(recipies.strMeasure6)
        measures.append(recipies.strMeasure7)
        measures.append(recipies.strMeasure8)
        measures.append(recipies.strMeasure9)
        measures.append(recipies.strMeasure10)
        measures.append(recipies.strMeasure11)
        measures.append(recipies.strMeasure12)
        measures.append(recipies.strMeasure13)
        measures.append(recipies.strMeasure14)
        measures.append(recipies.strMeasure15)
        measures.append(recipies.strMeasure16)
        measures.append(recipies.strMeasure17)
        measures.append(recipies.strMeasure18)
        measures.append(recipies.strMeasure19)
        measures.append(recipies.strMeasure20)
    }
}

