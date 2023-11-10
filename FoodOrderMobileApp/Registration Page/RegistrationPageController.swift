//
//  RegistrationPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 04.11.23.
//

import UIKit
import RealmSwift

class RegistrationPageController: UIViewController {
    
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupBackground: UIButton!
    
    let helper = Database()
    var user: User?
    let realm = try! Realm()
    
    var onLogin: ((String?, String?) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureShape()
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        regUser()

    }
}

// MARK: Functions
extension RegistrationPageController {
    func regUser() {
        let user = User()
        user.fullName = fullnameTextField.text ?? ""
        user.email = emailTextField.text ?? ""
        user.password = passwordTextField.text ?? ""
        user.phoneNumber = phonenumberTextField.text ?? ""
        user.purchase = Purchase()

        onLogin?(emailTextField.text, passwordTextField.text)
        helper.saveToDB(user: user)
        
        navigationController?.popViewController(animated: true)
        helper.getFilePath()
    }
    
    
    
    func configureShape() {
        fullnameTextField.layer.cornerRadius = 24
        fullnameTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 24
        emailTextField.layer.masksToBounds = true
        phonenumberTextField.layer.cornerRadius = 24
        phonenumberTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 24
        passwordTextField.layer.masksToBounds = true
        signupBackground.layer.cornerRadius = 24
        signupBackground.layer.masksToBounds = true
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
}
