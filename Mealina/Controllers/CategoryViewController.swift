//
//  ViewController.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var searchCategoryTextField: UITextField!
    @IBOutlet weak var randomImage: UIImageView! {
        didSet {
            randomImage.layer.cornerRadius = radius
            randomImage.clipsToBounds = true
            randomImage.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var searchContainerView: UIView! {
        didSet {
            searchContainerView.layer.cornerRadius = radius
      
        }
    }
    
    let radius : CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewAndTextField()
    }

    fileprivate func configureTableViewAndTextField() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.separatorStyle = .none
        categoryTableView.register(CategoryMealViewCell.categoryNib(), forCellReuseIdentifier: CategoryMealViewCell.identifier)
        
        searchCategoryTextField.delegate = self
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CategoryMealViewCell.identifier, for: indexPath) as? CategoryMealViewCell {
           
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
