//
//  RepoContributorViewCell.swift
//  Github-Search-App
//
//  Created by sanket kumar on 31/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class RepoContributorViewCell: UICollectionViewCell {
    
    let headingLabel = UILabel(text: "Contributors", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    
    let contributorController = RepoContributorCollectionView(scrollDirection: .horizontal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [
            headingLabel,
            contributorController.view
            ])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        self.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 8, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
