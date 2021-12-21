//
//  ActivityLoader.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/21/21.
//

import Foundation
import UIKit
import PromiseKit
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
        
        // Disable interaction when fetching data from the internet
        self.view.isUserInteractionEnabled = false
        return Guarantee()
    }
    public func hideLoader() {
        loadingIndicator.stopAnimating()
        // Enable interaction when done
        self.view.isUserInteractionEnabled = true
        
    }
}
