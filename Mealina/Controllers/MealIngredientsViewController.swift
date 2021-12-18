//
//  MealViewController.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit

class MealIngredientsViewController: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var others: UILabel!
    @IBOutlet weak var instruction: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var instructionText: UILabel! {
        didSet {
      
        }
    }
    @IBOutlet weak var instructionContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        mealImage.layer.cornerRadius = 8
        mealImage.clipsToBounds = true
    }
    



}
