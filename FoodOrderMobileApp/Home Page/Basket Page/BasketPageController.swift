//
//  BasketPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 09.11.23.
//

import UIKit

class BasketPageController: UIViewController {
    
    @IBOutlet weak var foodDeliveryAmountLabel: UILabel!
    @IBOutlet weak var foodTotalAmount: UILabel!
    @IBOutlet weak var table: UITableView!
    
    let emailSaved = UserDefaults.standard.string(forKey: "enteredEmail")
    let helper = Database()
    var user = [User]()
    
    var tempFinalMealPrice = 0.0
    
    var tempUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        user = helper.fetchFromDB()
        
        if let index = user.firstIndex(where: {$0.email == emailSaved}) {
            let userBasket = user[index]
            tempUser = userBasket
//            print("testtt")
        }
        
        table.reloadData()
        orderConfig()
//        print(tempUser)
//        print(tempUser.email ?? "bosh")
//        print("Basketdeki tempfinal \(tempFinal)")

    }
    
    
    @IBAction func orderNowButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "PaymentPageController") as! PaymentPageController
        controller.userMealPrice = Int(tempFinalMealPrice)
        navigationController?.show(controller, sender: nil)
    }
    
    
}

extension BasketPageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tempUser.purchase?.mealList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketListCell", for: indexPath) as! BasketListCell
        let userMeal = tempUser.purchase?.mealList
        
        cell.fillCell(name: userMeal?[indexPath.row].mealName,
                      image: userMeal?[indexPath.row].mealImage ?? "",
                      amount: String(userMeal?[indexPath.row].mealAmount ?? 0),
                      price: "\(String(userMeal?[indexPath.row].mealPrice ?? 0)) ₼")
        return cell
    }
}

extension BasketPageController {
    func orderConfig() {
        var finalPrice: Double = 0
        
        if let mealList = tempUser.purchase?.mealList {
            for meal in mealList {
                finalPrice = finalPrice + (Double(meal.mealAmount ?? 0) * (meal.mealPrice ?? 0) )
                tempFinalMealPrice = finalPrice
            }
        }
        
        if finalPrice > 0 {
            foodTotalAmount.text = ("\(String(finalPrice)) ₼")
            foodDeliveryAmountLabel.text = "Free"
        } else {
            foodTotalAmount.text = "0"
            foodDeliveryAmountLabel.text = ""
        }
    }
}
