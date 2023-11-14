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
    let emailSaved = UserDefaults.standard.string(forKey: "enteredEmail")
    var user = [User]()
    var tempUser = User()
    var onLogin: ((String?, String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureShape()
        touchGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = helper.fetchFromDB()
        if let index = user.firstIndex(where: {$0.email == emailSaved}) { //her userin individual akkauntu ile girmesi ucundu
            let userFetch = user[index]
            tempUser = userFetch
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        regUser()
    }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
}


// MARK: Functions
extension RegistrationPageController {
    
    func regUser() {
        if let regEmail = emailTextField.text,
           let regFullname = fullnameTextField.text,
           let regPhoneNumber = phonenumberTextField.text,
           let regPassword = passwordTextField.text,
           !regEmail.isEmpty,
           !regFullname.isEmpty,
           !regPhoneNumber.isEmpty,
           !regPassword.isEmpty {
            
            if regEmail != tempUser.email {
                let user = User()
                user.fullName = regFullname
                user.email = regEmail
                user.password = regPassword
                user.phoneNumber = regPhoneNumber
                user.purchase = Purchase()
                
                onLogin?(emailTextField.text, passwordTextField.text)
                helper.saveToDB(user: user)
                navigationController?.popViewController(animated: true)
            } else {
                showAlert(title: "Failed", message: "The user already exist!")
            }
            
        } else {
            showAlert(title: "Failed", message: "Please enter the correct details for registration")
        }
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
    // Telefonumu simulyator kimi istifade eden zaman, ekran qiragina vurulanda klaviatura itir
    func touchGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                tapGesture.cancelsTouchesInView = false // Allows touch event to pass through to the view hierarchy
                view.addGestureRecognizer(tapGesture)
    }
}
