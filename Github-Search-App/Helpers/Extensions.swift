//
//  Extensions.swift
//  Github-Search-App
//
//  Created by sanket kumar on 30/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit


extension UIImageView {
    
    convenience init(cornerRadius: CGFloat) {
        self.init(image : nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UILabel {
    
    convenience init(text : String , font : UIFont, numberOfLines : Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}


