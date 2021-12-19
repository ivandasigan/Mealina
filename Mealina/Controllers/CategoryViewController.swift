//
//  ViewController.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit



class CategoryViewController: UIViewController {
    
    //MARK:- OUTLETS
 
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewAndTextField()
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CategoryViewCell.identifier, for: indexPath) as? CategoryViewCell {
           
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(Controllers.listOfMeal.viewController, animated: true)
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
