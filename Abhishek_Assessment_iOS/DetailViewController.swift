//
//  DetailViewController.swift
//  Abhishek_Assessment_iOS
//
//  Created by Abhishek J  on 29/04/24.
//

import UIKit

class DetailViewController: BaseViewController {
    var dataDetails:AJModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        configureUI()
    }
    
    private func configureUI() {
        guard let dataDetails = dataDetails else { return }
        
        self.title = "Item \(dataDetails.id)"
        
        let titleLabel = UILabel()
        titleLabel.text = dataDetails.title.firstUppercased
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 15)
       
        let detailLabel = UILabel()
        detailLabel.text = dataDetails.body
        detailLabel.textAlignment = .left
        detailLabel.font = .systemFont(ofSize: 15)
        detailLabel.numberOfLines = 0
        
        let marginView = UIView()
        marginView.backgroundColor = .clear
        
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel, marginView])
        stackView.axis = .vertical
        stackView.alignment = .center
       // stackView.backgroundColor = .systemGray5
        stackView.spacing = 12
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                         
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 12),
            
            detailLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            detailLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
            
            marginView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}
