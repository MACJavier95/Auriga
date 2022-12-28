//
//  Extension.swift
//  Auriga
//
//  Created by DeviOS1 on 26/12/22.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    struct ModularColor {
        static let pinkPrincipal = UIColor(hexString: "715D95")//UIColor(red: 207/255, green: 171/255, blue: 204/255, alpha: 1.0)
        static let purplePrincipal = UIColor(red: 159/255, green: 153/255, blue: 202/255, alpha: 1.0)
        static let bluePrincipal = UIColor(red: 59/255, green: 122/255, blue: 185/255, alpha: 1.0)
        static let yellowPrincipal = UIColor(red: 230/255, green: 221/255, blue: 129/255, alpha: 1.0)
        static let pinkButton = UIColor(red: 0.60, green: 0.46, blue: 0.61, alpha: 1.00)
        static let greenAcua  = UIColor(red: 0.57, green: 0.74, blue: 0.74, alpha: 1.00)
        static let cornYellow = UIColor(red: 0.87, green: 0.85, blue: 0.38, alpha: 1.00)
        static let dirtyBlue  = UIColor(red: 0.60, green: 0.73, blue: 0.82, alpha: 1.00)
        
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension String {
    public var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{3,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+").evaluate(with: self)
    }
    
    public var isValidPassword: Bool {
        let passRegEx = "(?=[^a-z]*[a-z])[^0-9]*[0-9].{5,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: self)
    }
}

