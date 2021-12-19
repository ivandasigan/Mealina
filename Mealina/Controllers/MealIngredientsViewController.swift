//
//  MealViewController.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit

class MealIngredientsViewController: UIViewController {

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        for _ in 0..<10  {
            addChildrenStackViews()
        }
    }
    

    private func addChildrenStackViews() {
       
        var ingredientImage = UIImageView(image: UIImage(named: "meal")!)
        var ingredientName = UILabel()
        ingredientName.text = "Tiktokerist"
        ingredientName.font = .systemFont(ofSize: 16)
        ingredientName.textColor = .darkGray
        ingredientImage.layer.cornerRadius = 8
        ingredientImage.clipsToBounds = true
        var ingredientContent = UILabel()
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
