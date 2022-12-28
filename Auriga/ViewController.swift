//
//  ViewController.swift
//  Auriga
//
//  Created by DeviOS1 on 26/12/22.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var guestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initDetail()
        self.initStrings()
    }
    
    //MARK: - initDetail
    
    func initDetail() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - initStrings
    
    func initStrings() {
        self.bodyLabel.text = "Paga el estacionamiento, gana puntos, evita filas, aprovecha las promociones de temporada, compra desde la app"
        self.logInButton.setTitle("Iniciar sesión o registrate", for: .normal)
        
        let yourAttributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: "Continuar como invitado", attributes: yourAttributes)
        self.guestButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    //MARK: - Action
    
    @IBAction func logInAction(_ sender: UIButton) {
        let logInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        self.navigationController?.show(logInVC, sender: nil)
    }
}

