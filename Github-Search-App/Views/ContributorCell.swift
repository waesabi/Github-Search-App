//
//  ContributorCell.swift
//  Github-Search-App
//
//  Created by sanket kumar on 31/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import SDWebImage

class ContributorCell: UICollectionViewCell {
    
    let contributomImage = UIImageView(cornerRadius: 12)
    
    var contributorViewModel: ContributorViewModel? {
        didSet {
            if let viewModel = contributorViewModel {
                contributomImage.sd_setImage(with: viewModel.avatarUrl)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contributomImage.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        self.addSubview(contributomImage)
        contributomImage.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
