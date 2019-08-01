//
//  RepoDetailViewCell.swift
//  Github-Search-App
//
//  Created by sanket kumar on 31/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import SDWebImage

protocol RepoDetailViewCellDelegate {
    func didTapRepoLink(urlString: String)
}

class RepoDetailViewCell: UICollectionViewCell {
    
    var delegate: RepoDetailViewCellDelegate?
    
    var gitRepo: GitHubRepo? {
        didSet {
            if let repo = gitRepo {
                repoName.text = repo.name
                projectLink.text = repo.html_url
                if let url = repo.owner?.avatar_url {
                    repoImage.sd_setImage(with: URL(string: url))
                }
                repoDescription.text = repo.description
                
                projectLinkButton.setTitle(repo.html_url, for: .normal)
            }
        }
    }
    
    
    let repoImage = UIImageView(cornerRadius: 10)
    let repoNameLabel = UILabel(text: "Name: ", font: .boldSystemFont(ofSize: 16))
    let repoName = UILabel(text: "Movie App", font: .systemFont(ofSize: 16), numberOfLines: 2)
    let projectLinkLabel = UILabel(text: "Project Link: ", font: .boldSystemFont(ofSize: 16), numberOfLines: 2)
    
    let projectLinkButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(#colorLiteral(red: 0.2196078431, green: 0.5921568627, blue: 0.9411764706, alpha: 1), for: .normal)
        // button.backgroundColor = .green
        button.titleLabel?.textAlignment = NSTextAlignment.left
        return button
    }()
    
    let projectLink = UILabel(text: "url", font: .systemFont(ofSize: 16), numberOfLines: 0)
    let descriptionLabel = UILabel(text: "Description: ", font: .boldSystemFont(ofSize: 16), numberOfLines: 2)
    let repoDescription = UILabel(text: "Repo Description", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
        setupStackViews()

    }
    
    
    fileprivate func setupImageView() {
        self.addSubview(repoImage)
        repoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16), size: .init(width: 0, height: 250))
        
    }
    
    
    fileprivate func setupStackViews() {
        repoNameLabel.constrainWidth(constant: 100)
        projectLinkLabel.constrainWidth(constant: 100)
        descriptionLabel.constrainWidth(constant: 100)
    
        
        let stackView = UIStackView(arrangedSubviews: [
            getStackView(leftView: repoNameLabel, rightView: repoName),
            getStackView(leftView: projectLinkLabel, rightView: projectLinkButton),
            getStackView(leftView: descriptionLabel, rightView: repoDescription)
            ])
        stackView.axis = .vertical
        stackView.spacing = 8
        self.addSubview(stackView)
        stackView.anchor(top: repoImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 16, bottom: 0, right: 15))
        
        projectLinkButton.addTarget(self, action: #selector(handleLinkClicked), for: .touchUpInside)
    }
    
    @objc fileprivate func handleLinkClicked() {
        print("Button Clicked")
        if let repo = gitRepo, let urlString = repo.html_url {
            delegate?.didTapRepoLink(urlString: urlString)
        }
    }
    
    fileprivate func getStackView(leftView: UILabel, rightView: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            leftView,
            rightView
            ])
        stackView.axis = .horizontal
        stackView.spacing = 4
        // stackView.alignment = .leading
        return stackView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
