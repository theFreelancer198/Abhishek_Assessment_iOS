//
//  CustomLoader.swift
//  Abhishek_Assessment_iOS
//
//  Created by Abhishek J  on 30/04/24.
//

import UIKit

class LoaderView: UIView {
    private let activityIndicator: UIActivityIndicatorView
    private let label: UILabel
    
    init() {
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.label = UILabel()
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure label properties
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.gray
        
        // Add subviews
        addSubview(activityIndicator)
        addSubview(label)
        
        // Set up constraints to position activity indicator and label
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: self.topAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 8)
        ])
    }
    
    func startLoading(withText text: String?) {
        activityIndicator.startAnimating()
        label.text = text ?? ""
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        label.text = ""
    }
}
