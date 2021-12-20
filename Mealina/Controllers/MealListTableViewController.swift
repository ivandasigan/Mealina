//
//  MealTableViewController.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit
import PromiseKit

class MealListTableViewController: UITableViewController {
    
    var categoryMealName: String?
    var meals = [Meals]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = categoryMealName ?? "Null"
        
        // Change Back button image
        let edgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        let backImage = UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysOriginal).withAlignmentRectInsets(edgeInsets)
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    var indicatorView: IVLoaderIndicator!
    var mealService = MealService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView = IVLoaderIndicator(superView: self.view)
        indicatorView.addChildIndicatorView()
        
        configureTableView()
        tableView.separatorInset = UIEdgeInsets(top: 40, left: 90, bottom: 0, right: 10)
        
        firstly {
            indicatorView.showLoader()
        }.then(on: DispatchQueue.global(qos: .background), flags: nil) {
            self.mealService.get(ofType: Meal.self, target: .getMealsRequest(byCategoryName: self.categoryMealName ?? "Chicken"))
        }.done { result in
            self.indicatorView.hideLoader()
            self.meals = result.meals
            self.tableView.reloadData()
        }.catch { (error) in
            print(error.localizedDescription)
        }
    }

    fileprivate func configureTableView() {
        tableView.register(MealViewCell.mealNib(), forCellReuseIdentifier: MealViewCell.identifier)
    }
    
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meal = meals[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: MealViewCell.identifier, for: indexPath) as? MealViewCell {
            DispatchQueue.main.async {
                cell.bind(meal: meal)
            }
            return cell
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell.separatorInset = UIEdgeInsets(top: 40, left: 90, bottom: 0, right: 10)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(Controllers.meal.viewController, animated: true)
    }

    @objc func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
}
