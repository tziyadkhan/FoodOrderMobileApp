//
//  BasketPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 09.11.23.
//

import UIKit
import RealmSwift

class BasketPageController: UIViewController {
    
    @IBOutlet weak var foodDeliveryAmountLabel: UILabel!
    @IBOutlet weak var foodTotalAmount: UILabel!
    @IBOutlet weak var table: UITableView!
    
    let emailSaved = UserDefaults.standard.string(forKey: "enteredEmail")
    let helper = Database()
    var realm = try! Realm()
    var user = [User]()
    var tempFinalMealPrice = 0.0
    var tempUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        user = helper.fetchFromDB()
        if let index = user.firstIndex(where: {$0.email == emailSaved}) {
            let userBasket = user[index]
            tempUser = userBasket
        }
        table.reloadData()
        orderConfig()
    }
    override func viewWillLayoutSubviews() {
        self.table.reloadData()
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
//        let userMeal = tempUser.purchase?.mealList
        
        if tempUser.purchase?.purchaseStatus == "incomplete" {
            cell.fillCell(name: tempUser.purchase?.mealList[indexPath.row].mealName,
                          image: tempUser.purchase?.mealList[indexPath.row].mealImage ?? "",
                          amount: String(tempUser.purchase?.mealList[indexPath.row].mealAmount ?? 3),
                          price: "\(String(tempUser.purchase?.mealList[indexPath.row].mealPrice ?? 0)) ₼")
        } else if tempUser.purchase?.purchaseStatus == "complete" {
            try! self.realm.write{
                tempUser.purchase?.mealList.removeAll()
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            self.deleteItem(indexPathRow: indexPath.row)
            self.table.reloadData()
        
        }
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension BasketPageController {
    // Swipe edilan zaman silecek
    func deleteItem(indexPathRow: Int) {
        // Updates the User Purchase info
        try! self.realm.write {
            self.tempUser.purchase?.mealList[indexPathRow].mealAmount = 0
            self.tempUser.purchase?.mealList.remove(at: indexPathRow)
        }

    }
        
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
