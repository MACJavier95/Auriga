//
//  LogInViewController.swift
//  Auriga
//
//  Created by DeviOS1 on 26/12/22.
//

import UIKit
import Material
import FirebaseAuth
import FirebaseAnalytics

class LogInViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registryButton: UIButton!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var rememberPasswordButton: UIButton!
    @IBOutlet weak var logInActionButton: UIButton!
    @IBOutlet weak var continueGuestButton: UIButton!
    
    var isLoginComplete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initDetail()
        self.initStrings()
        
        Analytics.logEvent("init", parameters: ["message":"Integración a firebase completa"])
    }
    
    //MARK: - initDetail
    
    func initDetail() {
    
        self.navigationController?.navigationBar.isHidden = true
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.setupKeyboardNotifcationListenerForScrollView(self.scrollView)
        self.hideKeyboardWhenTappedAround()
        
    }
    
    //MARK: - initStrings
    
    func initStrings() {
        let logInBAttributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeLogInBString = NSMutableAttributedString(string: "Inicia sesión", attributes: logInBAttributes)
        self.logInButton.setAttributedTitle(attributeLogInBString, for: .normal)
        
        let registryAttributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeRegistryString = NSMutableAttributedString(string: "Registrate", attributes: registryAttributes)
        self.registryButton.setAttributedTitle(attributeRegistryString, for: .normal)
        
        self.emailTextField.placeholder = "Correo electrónico"
        self.passwordTextField.placeholder = "Contraseña"
        
        let rememberPasswordAttributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeRememberPasswordString = NSMutableAttributedString(string: "Olvidé mi contraseña", attributes: rememberPasswordAttributes)
        self.rememberPasswordButton.setAttributedTitle(attributeRememberPasswordString, for: .normal)
        
        self.logInActionButton.setTitle("Iniciar sesión", for: .normal)
        self.logInActionButton.layer.cornerRadius = self.logInActionButton.layer.frame.height / 2
        self.logInActionButton.backgroundColor = UIColor.init(hexString: "F2F2F2")
        self.logInActionButton.tintColor = UIColor.init(hexString: "0D0F40")
        self.logInActionButton.layer.masksToBounds = false
        self.logInActionButton.layer.shadowColor = UIColor.gray.cgColor
        self.logInActionButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.logInActionButton.layer.shadowOpacity = 0.2
        self.logInActionButton.layer.shadowRadius = 3.0
        
        let continueGuestAttributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeContinueGuestString = NSMutableAttributedString(string: "Continuar como invitado", attributes: continueGuestAttributes)
        self.continueGuestButton.setAttributedTitle(attributeContinueGuestString, for: .normal)
    
    }
    
    //MARK: - Methods
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "¡Aviso!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Aceptar", style: .default, handler: { (action) -> Void in
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loader() {
        let alert = UIAlertController(title: nil, message: "Cargando", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func checkData() {
        if self.emailTextField.text == "" {
            self.emailTextField.shake()
        }else if self.emailTextField.text?.isValidEmail == false {
            self.showAlert(message: "El formato del correo es invalido")
        }else if self.passwordTextField.text == "" {
            self.passwordTextField.shake()
        }else{
            self.loginUser(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "")
        }
    }
    
    func loginUser(email: String, password: String) {
        self.loader()
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let result = result, error == nil {
                self.dismiss(animated: false, completion: nil)
                self.showAlert(message: "El usuario inicio correctamente")
                print("result: \(result)")
            }else{
                self.showAlert(message: "Ocurrio un error al iniciar sesión")
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func logInAction(_ sender: UIButton) {
        self.checkData()
    }
    
    @IBAction func registryAction(_ sender: UIButton) {
        let registryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistryViewController") as! RegistryViewController
        self.navigationController?.show(registryVC, sender: nil)
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
}
