//
//  BlueButton.swift
//  Auriga
//
//  Created by DeviOS1 on 27/12/22.
//

import UIKit

class BlueButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.backgroundColor = UIColor.init(hexString: "2E4E8C")
        self.tintColor = UIColor.white
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3.0
        
        self.layer.cornerRadius = self.layer.frame.height / 2
    }

}
