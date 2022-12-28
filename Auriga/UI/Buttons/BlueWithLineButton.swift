//
//  BlueWithLineButton.swift
//  Auriga
//
//  Created by DeviOS1 on 26/12/22.
//

import UIKit

class BlueWithLineButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.backgroundColor = UIColor.white
        self.tintColor = UIColor.init(hexString: "2E4E8C")
        self.layer.masksToBounds = false
        
    }
}
