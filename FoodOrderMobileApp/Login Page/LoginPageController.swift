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
    var userLogin = User()
    let helper = UserLoginFileManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureShape()

    }
    
    @IBAction func loginButton(_ sender: Any) {
//        checkLogin()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        registrationPage()

    }
}


// MARK: Functions
extension LoginPageController {
    func registrationPage() {
        print("test")
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegistrationPageController") as! RegistrationPageController
        controller.onLogin = { email, password in
            self.emailTextField.text = email
            self.passwordTextField.text = password
        }
        
        controller.onUserReg = { user in
            self.userLogin = user
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
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
//    
//    func setRoot() {
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let sceneDelegate = scene.delegate as? SceneDelegate {
//            UserDefaults.standard.setValue(true, forKey: "loggedIN") // Setting the flag
//            sceneDelegate.homePage(windowScene: scene)
//        }
//    }
    
    func checkLogin() {
        if let loginEmail = emailTextField.text,
           let loginPassword = passwordTextField.text,
           !loginEmail.isEmpty,
           !loginPassword.isEmpty {
            helper.readUserData { users in
                if users.contains(where: {$0.email == loginEmail && $0.password == loginPassword}) {
//                    UserDefaults.standard.setValue(loginEmail, forKey: "email")
//                    setRoot()
                    let controller = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                    navigationController?.show(controller, sender: nil)
                } else {
                    showAlert(title: "Xəta", message: "Email və ya şifrə düzgün qeyd edilməyib")
                }
            }
        } else {
            showAlert(title: "Xəta", message: "Email və ya şifrə daxil edilməyib")
        }
    }
}
