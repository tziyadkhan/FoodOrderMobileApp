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
    
//    let helper = UserLoginFileManager()
    var user: User?
    let realm = try! Realm()
    
    var onLogin: ((String?, String?) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureShape()

    }
    

    @IBAction func registerButton(_ sender: Any) {
        regUser()
        Database.saveToDB(user: self.user!, Database: self.realm)  //tema
        print(self.realm.configuration.fileURL!)
    }
}


// MARK: Functions
extension RegistrationPageController {
    func regUser() {
        onLogin?(emailTextField.text, passwordTextField.text)
        self.user = User(fullname: fullnameTextField.text!,
                        email: emailTextField.text!,
                        phonenumber: phonenumberTextField.text!,
                        password: passwordTextField.text!,
                        purchaseList: Purchase())

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
