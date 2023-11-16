//
//  PaymentPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 11.11.23.
//

import UIKit
import RealmSwift

class PaymentPageController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var payInvoiceBG: UIView!
    @IBOutlet weak var payButtonItem: UIButton!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var cardExpireTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    var userBalance = 500
    var userMealPrice = 0
    let helper = Database()
    let emailSaved = UserDefaults.standard.string(forKey: "enteredEmail")
    var user = [User]()
    var tempUser = User()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeConfig()
        touchGesture()
        cardNumberTextField.delegate = self
        cardExpireTextField.delegate = self
        cvvTextField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = helper.fetchFromDB()
        if let index = user.firstIndex(where: {$0.email == emailSaved}) {
            let userCalled = user[index]
            tempUser = userCalled
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func payButton(_ sender: Any) {
        confirmationAlert(title: "Do you confirm?", message: """
                          From which card : \(cardNumberTextField.text ?? "")
                          Service name: MusCatFood
                          Amount: \(userMealPrice) AZN
                          """)
    }
    
}
extension PaymentPageController {
    
    // MARK: Functions
    func paymentCondition() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .long
        let dateTimeString = dateFormatter.string(from: date)
        
        if (userBalance > userMealPrice) &&
            (cardNumberTextField.text?.count) == 16 &&
            (usernameTextField.text?.count) != nil &&
            (cvvTextField.text?.count) == 3 &&
            (cardExpireTextField.text ?? "2024" >= "2023" && cardExpireTextField.text ?? "2024" <= "2035") {
            var balance = userBalance - userMealPrice
            successAlert(title: "Successful Payment!", message: """
                        Amount: \(userMealPrice) AZN.
                        Invoice ID: INV20231111001.
                        Payment date: \(dateTimeString)
                        Balance: \(balance) AZN.
                        """)
            try! self.realm.write{
                self.tempUser.purchase?.purchaseStatus = "complete"
            }
            
        } else {
            failure(title: "Failure",
                    message: """
                                  The money in your account is not enough for this payment or your card details are wrong.
                                  Please check and try again.
                                  Balance: \(userBalance) AZN.
                                  """)
        }
    }
    
    func shapeConfig() {
        payInvoiceBG.layer.cornerRadius = 20
        payButtonItem.layer.cornerRadius = 20
        payButtonItem.tintColor = .systemPink
        payInvoiceBG.layer.masksToBounds = true
        payButtonItem.layer.masksToBounds = true
    }
    
    func successAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let homeButton = UIAlertAction(title: "Okay", style: .default) { (_) in
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryPageController") as! DeliveryPageController
            try! self.realm.write{
                self.tempUser.purchase?.mealList.removeAll()
            }
            self.navigationController?.show(controller, sender: nil)
        }
        alertController.addAction(homeButton)
        self.present(alertController, animated: true)
    }
    
    func failure(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Got it", style: .cancel)
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
    
    func touchGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Allows touch event to pass through to the view hierarchy
        view.addGestureRecognizer(tapGesture)
    }
    
    func confirmationAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "Confirm", style: .default) { (_) in
            self.paymentCondition()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(confirmButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength: Int
        
        if textField.text?.count == cardNumberTextField.text?.count {
            maxLength = 16
        } else if textField.text?.count == cardExpireTextField.text?.count {
            maxLength = 4
        } else if textField.text?.count == cvvTextField.text?.count {
            maxLength = 3
        } else {
            return true
        }
        
        if let currentString = textField.text as NSString? {
            let newString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        return true
    }
    
}

