//
//  ViewController.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit
import Moya
import PromiseKit

//    var loadingIndicator: UIActivityIndicatorView = {
//        let activityIndicator = UIActivityIndicatorView()
//        activityIndicator.style = .medium
//        activityIndicator.translatesAutoresizingMaskIntoConstraints
//        return activityIndicator
//    }()

struct IVLoaderIndicator {
    var loadingIndicator = UIActivityIndicatorView()
    public init(superView view: UIView) {
        self.view = view
    }
    var view: UIView
    public func addChildIndicatorView() {
        
        loadingIndicator.style = .medium
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    public func showLoader() -> Guarantee<Void> {
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true
        return Guarantee()
    }
    public func hideLoader() -> Guarantee<Void> {
        loadingIndicator.stopAnimating()
        return Guarantee()
    }
}

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
    
    let radius : CGFloat = 8
    var indicatorView: IVLoaderIndicator!
    let mealService = MealService()
    private var categories = [Categories]()
    
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
            self.indicatorView.hideLoader()
            self.categories = result.categories
            self.categoryTableView.reloadData()
       
        }.catch { error in
            print(error)
        }
    }

    
    fileprivate func configureTableViewAndTextField() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.separatorStyle = .none
        categoryTableView.register(CategoryViewCell.categoryNib(), forCellReuseIdentifier: CategoryViewCell.identifier)
        
        searchCategoryTextField.delegate = self
    }
    
    //MARK:- OBJ METHODS
    @objc func tappedRandomImage() {
        let alert = UIAlertController(title: "ALERT MESSAGE", message: "Hi you just Tapped me", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    @objc func textfieldDidChange(_ textfield: UITextField) {
        print(textfield.text!)
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: CategoryViewCell.identifier, for: indexPath) as? CategoryViewCell {
            cell.alpha = 0.0
            UIView.animate(withDuration: 0.4) {
                cell.alpha = 1.0
            }
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
        let vc = Controllers.listOfMeal.viewController as! MealListTableViewController
        vc.categoryMealName = categories[indexPath.row].strCategory
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
