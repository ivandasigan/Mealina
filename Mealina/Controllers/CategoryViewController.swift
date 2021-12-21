//
//  ViewController.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit
import Moya
import PromiseKit
import SDWebImage


class CategoryViewController: UIViewController {
    
    //MARK: - OUTLETS
 
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var searchCategoryTextField: UITextField! {
        didSet {
            searchCategoryTextField.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
            searchCategoryTextField.clearButtonMode = .whileEditing
        }
    }
    @IBOutlet weak var randomImage: UIImageView! {
        didSet {
            randomImage.setImageCornerRadius(radius)
            randomImage.contentMode = .scaleAspectFill
            
            // Add Tap Gesture
            randomImage.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedRandomImage))
            randomImage.addGestureRecognizer(tapGesture)
        }
    }
    @IBOutlet weak var searchContainerView: UIView! {
        didSet {
            searchContainerView.setCornerRadius(radius)
        }
    }
    
    //MARK: - INIIALIZATIONS
    private let radius : CGFloat = 8
    private let mealService = MealService()
    private var indicatorView: IVLoaderIndicator!
    private var filteredCategories = [Categories]()
    private var categories = [Categories]()
    private var randomMeal: Recipe?
    private var searchFilter = "" {
        didSet {
            filter()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .darkGray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableViewAndTextField()
        indicatorView = IVLoaderIndicator(superView: self.view)
        indicatorView.addChildIndicatorView()
        
        firstly {
            self.indicatorView.showLoader()
        }.then(on: DispatchQueue.global(qos: .background), flags: nil) {
            self.mealService.get(ofType: Category.self, target: .getCategoryRequest)
        }.done { result in
          
            self.categories = result.categories
            self.filteredCategories = result.categories
            self.categoryTableView.reloadData()
       
        }.catch { error in
            print(error)
        }
        
        firstly {
            self.mealService.get(ofType: Recipe.self, target: .getRandomMealRequest)
        }.done { result in
            self.indicatorView.hideLoader()
            self.randomImage.sd_setImage(with: URL(string: result.meals[0].strMealThumb))
            self.randomImage.sd_imageTransition = .fade(duration: 1)
            self.randomMeal = result
        }.catch { error in
            print(error)
        }
    }

    
    fileprivate func configureTableViewAndTextField() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.separatorStyle = .none
        categoryTableView.register(CategoryViewCell.loadCustomNib(nibName: CategoryViewCell.nibName), forCellReuseIdentifier: CategoryViewCell.identifier)
        
        searchCategoryTextField.delegate = self
    }
    
    fileprivate func filter() {
        if searchFilter.count != 0 {
            filteredCategories = categories.filter({ category in
                return category.strCategory.localizedLowercase.contains(searchFilter.localizedLowercase)
            })
        } else {
            filteredCategories = categories
        }
    }
    
    //MARK: - OBJC METHODS
    @objc func tappedRandomImage() {
        let vc = Controllers.meal.viewController as! MealRecipeViewController
        vc.idMeal = randomMeal?.meals[0].idMeal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func textfieldDidChange(_ textfield: UITextField) {
        guard let searchText = textfield.text else { return }
        self.searchFilter = searchText
        categoryTableView.reloadData()
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = filteredCategories[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: CategoryViewCell.identifier, for: indexPath) as? CategoryViewCell {
            cell.bind(category: category)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = filteredCategories[indexPath.row]
        let vc = Controllers.listOfMeal.viewController as! MealListTableViewController
        vc.categoryMealName = category.strCategory
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoryViewController: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}

