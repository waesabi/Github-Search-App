//
//  HorizontalCollectionView.swift
//  Github-Search-App
//
//  Created by sanket kumar on 31/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    init(scrollDirection: UICollectionView.ScrollDirection) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        super.init(collectionViewLayout: layout)
        self.collectionView.decelerationRate = .fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
