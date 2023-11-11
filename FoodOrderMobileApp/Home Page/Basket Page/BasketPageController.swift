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
    
    let helper = Database()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = helper.fetchFromDB().first ?? User()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.reloadData()
        orderConfig()
    }
    

    @IBAction func orderNowButton(_ sender: Any) {
    }
    

}

extension BasketPageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.purchase?.mealList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketListCell", for: indexPath) as! BasketListCell
        let userMeal = user.purchase?.mealList
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
        
        if let mealList = user.purchase?.mealList {
            for meal in mealList {
                finalPrice = finalPrice + (Double(meal.mealAmount ?? 0) * (meal.mealPrice ?? 0) )
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
