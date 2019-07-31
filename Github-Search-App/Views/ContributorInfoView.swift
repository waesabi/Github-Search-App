//
//  ContributorHeaderView.swift
//  Github-Search-App
//
//  Created by sanket kumar on 01/08/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import SDWebImage

class ContributorInfoView: UITableViewCell {
    
    let contributorImage = UIImageView(cornerRadius: 10)
    
    var repoContributor: RepoContributor? {
        didSet {
            if let contributor = repoContributor, let urlString = contributor.avatar_url {
                 contributorImage.sd_setImage(with: URL(string: urlString))
                label.text = "Repo List"
            }
        }
    }
    
    let label = UILabel(text: "Repo List", font: .boldSystemFont(ofSize: 24))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    
    fileprivate func setupViews() {
        label.constrainHeight(constant: 44)
        let stackView = UIStackView(arrangedSubviews: [
            contributorImage,
            label
            ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 8, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
