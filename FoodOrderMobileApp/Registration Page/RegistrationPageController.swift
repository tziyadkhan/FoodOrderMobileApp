//
//  RegistrationPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 04.11.23.
//

import UIKit

class RegistrationPageController: UIViewController {

    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupBackground: UIButton!
    
    let helper = UserLoginFileManager()
    var users = [User]()
    var onLogin: ((String?, String?) -> Void)?
    var onUserReg: ((User) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureShape()
        
        helper.readUserData { userItems in
            self.users = userItems
        }
    }
    

    @IBAction func registerButton(_ sender: Any) {
        regUser()
    }
}


// MARK: Functions
extension RegistrationPageController {
    func regUser() {
        onLogin?(emailTextField.text, passwordTextField.text)
        let user = User(fullname: fullnameTextField.text ?? "",
                        email: emailTextField.text ?? "",
                        phonenumber: phonenumberTextField.text ?? "",
                        password: passwordTextField.text ?? "")
        onUserReg?(user)
        users.append(user)
        helper.writeUserData(users: users)
        navigationController?.popViewController(animated: true)
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
}
