//
//  BaseViewController.swift
//  Abhishek_Assessment_iOS
//
//  Created by Abhishek J  on 29/04/24.
//

import UIKit

class BaseViewController: UIViewController {
   
    private var loaderView: LoaderView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupLoaderView()
    }
    
    func configureNavigationBar() {
        guard let navController = navigationController else { return }
        navController.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor.blue
        ]
        navController.navigationBar.tintColor = UIColor.blue
        navController.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        navController.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.left")
        navigationItem.backButtonTitle = ""
    }
    
    func showAlert(title: String, message: String, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        } else {
            actions.forEach { alertController.addAction($0) }
        }
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func setupLoaderView() {
        let loader = LoaderView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loaderView = loader
    }

    func showLoader(withText text: String) {
        loaderView?.startLoading(withText: text)
    }

    func hideLoader() {
        loaderView?.stopLoading()
    }

}

// MARK: Extensions

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}

