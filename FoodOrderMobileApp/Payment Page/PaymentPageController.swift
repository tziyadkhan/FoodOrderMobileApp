//
//  PaymentPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 11.11.23.
//

import UIKit
import RealmSwift

class PaymentPageController: UIViewController {
    
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
        paymentCondition()
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
            (cvvTextField.text?.count == 3) &&
            (cardExpireTextField.text ?? "2024" > "2023") {
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
}

