//
//  LoginPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 04.11.23.
//

import UIKit

class LoginPageController: UIViewController {

    @IBOutlet weak var loginButtonView: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var user = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureShape()

    }
    
    @IBAction func loginButton(_ sender: Any) {
    }
    
    @IBAction func registerButton(_ sender: Any) {
        loginCallBack()
    }
}


// MARK: Functions
extension LoginPageController {
    func loginCallBack() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegistrationPageController") as! RegistrationPageController
        controller.onLogin = { email, password in
            self.emailTextField.text = email
            self.passwordTextField.text = password
        }
        navigationController?.show(controller, sender: nil)
    }
    
    func configureShape() {
        emailTextField.layer.cornerRadius = 24
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 24
        passwordTextField.layer.masksToBounds = true
        loginButtonView.layer.cornerRadius = 24
        loginButtonView.layer.masksToBounds = true
    }
}
