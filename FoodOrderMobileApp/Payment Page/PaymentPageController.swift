//
//  PaymentPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 11.11.23.
//

import UIKit

class PaymentPageController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var payInvoiceBG: UIView!
    @IBOutlet weak var payButtonItem: UIButton!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var cardExpireTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    var userBalance = 500
    var userMealPrice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
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
            
        } else {
            failure(title: "Failure",
                    message: """
                                  The money in your account is not enough for this payment.
                                  Check your account balance or card details and try again.
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
        
        let homeButton = UIAlertAction(title: "Return Home", style: .default) { (_) in
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomePageController") as! HomePageController
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
}