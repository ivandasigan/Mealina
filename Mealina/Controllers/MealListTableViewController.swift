//
//  MealTableViewController.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/17/21.
//

import UIKit

class MealListTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }

    fileprivate func configureTableView() {
        tableView.register(MealViewCell.mealNib(), forCellReuseIdentifier: MealViewCell.identifier)
    }
    
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MealViewCell.identifier, for: indexPath) as? MealViewCell {
            
            return cell
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 40, left: 90, bottom: 0, right: 10)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(Controllers.meal.viewController, animated: true)
    }
    //MARK: - Navigation



}
