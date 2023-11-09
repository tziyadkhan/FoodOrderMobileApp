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
    
    var basket = [MealModel]()

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func orderNowButton(_ sender: Any) {
    }
    

}

extension BasketPageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        basket.count
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketListCell", for: indexPath) as! BasketListCell
//        cell.fillCell(name: basket[indexPath.row].mealName,
//                      image: basket[indexPath.row].mealImage ?? "",
//                      amount: String(basket[indexPath.row].mealAmount ?? 0),
//                      price: String(basket[indexPath.row].mealPrice ?? 0))
        return cell
    }
}
