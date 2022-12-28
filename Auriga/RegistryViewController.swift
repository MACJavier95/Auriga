//
//  RegistryViewController.swift
//  Auriga
//
//  Created by DeviOS1 on 27/12/22.
//

import UIKit
import Material
import FirebaseAuth
import FirebaseDatabase
import FirebaseAnalytics
import FirebaseFirestore

class RegistryViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var confirmPasswordTextField: TextField!
    @IBOutlet weak var registryButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    var bd = Firestore.firestore()
    
    var isRegistry = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initDetail()
        self.initStrings()
    }
    
    //MARK: - initDetail
    
    func initDetail() {
        
        self.navigationItem.title = "Registrarme"
        // NavigationBarButtons
        
        let backImage = UIImage(systemName: "arrow.left")

        let backButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        backButton.setImage(backImage, for: UIControl.State.normal)
        backButton.addTarget(self, action: #selector(TapBackButton), for: UIControl.Event.touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.tintColor = UIColor.init(hexString: "2E4E8C")
        let backButtonItem = UIBarButtonItem(customView: backButton)
        
        self.navigationItem.setLeftBarButtonItems([backButtonItem], animated: false)
        
        self.navigationController?.navigationBar.isHidden = false
        
        Analytics.logEvent("init", parameters: ["message":"Integración a firebase completa"])
        
        self.setupKeyboardNotifcationListenerForScrollView(self.scrollView)
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: - initStrings
    
    func initStrings() {
        self.titleLabel.text = "Ingresa los siguientes datos"
        self.nameTextField.placeholder = "Nombre(s)"
        self.lastNameTextField.placeholder = "Apellido(s)"
        self.emailTextField.placeholder = "Correo electrónico"
        self.passwordTextField.placeholder = "Contraseña"
        self.confirmPasswordTextField.placeholder = "Confirmar contraseña"
        self.registryButton.setTitle("Registrame", for: .normal)
        self.facebookButton.setTitle("Iniciar con Facebook", for: .normal)
    }
    
    //MARK: - Action NavigationBarItem
    
    @objc func TapBackButton(sender: UIButton){
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    
    func checkData() {
        if self.nameTextField.text == "" {
            self.nameTextField.shake()
        }else if self.lastNameTextField.text == "" {
            self.lastNameTextField.shake()
        }else if self.emailTextField.text == "" {
            self.emailTextField.shake()
        }else if self.emailTextField.text?.isValidEmail == false{
            self.showAlert(message: "El formato del correo es invalido")
        }else if self.passwordTextField.text == "" {
            self.passwordTextField.shake()
        }else if self.passwordTextField.text?.count ?? 0 < 6 {
            self.showAlert(message: "La contraseña debe tener al menos 6 caracteres")
        }else if self.passwordTextField.text?.isValidPassword == false {
            self.showAlert(message: "La contraseña debe contener al menos una mayúscula y un número")
        }else if self.confirmPasswordTextField.text == "" {
            self.confirmPasswordTextField.shake()
        }else if self.passwordTextField.text != self.confirmPasswordTextField.text {
            self.showAlert(message: "Las contraseñas son distintas")
        }else{
            self.createUser(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "¡Aviso!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Aceptar", style: .default, handler: { (action) -> Void in
            if self.isRegistry == true {
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.popViewController(animated: true)
            }
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
    
    func createUser(email: String, password: String) {
        self.loader()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            self.dismiss(animated: false, completion: nil)
            if let result = result, error == nil {
                self.isRegistry = true
                self.showAlert(message: "Se registro correctamente el usuario")
                print("result: \(result)")
                self.bd.collection("users").document(self.emailTextField.text ?? "").setData(["userName": self.nameTextField.text ?? "","lastName": self.lastNameTextField.text ?? ""])
            }else{
                self.showAlert(message: "Ocurrio un error al registar al usuario")
                print("error: \(String(describing: error))")
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func registryAction(_ sender: UIButton) {
        self.checkData()
    }
}
