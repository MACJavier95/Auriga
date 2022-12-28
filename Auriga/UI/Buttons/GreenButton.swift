//
//  GreenButton.swift
//  Auriga
//
//  Created by DeviOS1 on 26/12/22.
//

import UIKit

class GreenButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.backgroundColor = UIColor.init(hexString: "84D9D0")
        self.tintColor = UIColor.white
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3.0
        
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
}
