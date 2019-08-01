//
//  RepoViewCell.swift
//  Github-Search-App
//
//  Created by sanket kumar on 30/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import SDWebImage


class RepoViewCell: UITableViewCell {
    
    var repoViewModel: RepoViewModel? {
        didSet {
            guard let viewModel = repoViewModel else { return }
            repoName.text = viewModel.name
            repoFullName.text = viewModel.fullName
            watchersLabel.text = viewModel.watchers
            repoImage.sd_setImage(with: viewModel.avatarUrl)
        }
    }

    
    let repoImage = UIImageView(cornerRadius: 8)
    let repoName = UILabel(text: "Name", font: .boldSystemFont(ofSize: 18), numberOfLines: 2)
    let repoFullName = UILabel(text: "Full Name", font: .systemFont(ofSize: 14), numberOfLines: 2)
    let watchersLabel = UILabel(text: "Watchers", font: .systemFont(ofSize: 14))
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUIViews()
    }
    
    
    fileprivate func setupUIViews() {
        
        watchersLabel.textColor = .lightGray
    
        let labelStackView = UIStackView(arrangedSubviews: [
            repoName,
            repoFullName,
            watchersLabel
            ])
        labelStackView.axis = .vertical
        labelStackView.spacing = 6
        
        self.addSubview(repoImage)
        repoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 16, left: 16, bottom: 16, right: 0), size: .init(width: 130, height: 0))
        
        self.addSubview(labelStackView)
        labelStackView.anchor(top: topAnchor, leading: repoImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
