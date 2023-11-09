//
//  FoodListController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 07.11.23.
//

import UIKit

class FoodListController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBackground: UIView!
    
    var foodlist = [MealModel]()
    var backupFoodList = [MealModel]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(foodlist)
        searchBackground.layer.cornerRadius = 20
        backupFoodList = foodlist
        
    }
    
    @IBAction func searchTextField(_ sender: UITextField) {
        if let searchText = sender.text, !searchText.isEmpty {
            searching = true
            foodlist = foodlist.filter { food in
                if let food = food.mealName {
                    return food.lowercased().contains(searchText.lowercased())
                }
                return false
            }
        } else {
            searching = false
            foodlist.removeAll()
            foodlist = backupFoodList
        }
        collection.reloadData()
    }
    
}

extension FoodListController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodlist.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodListCell", for: indexPath) as! FoodListCell
        cell.fillCell(name: foodlist[indexPath.item].mealName,
                      image: foodlist[indexPath.item].mealImage,
                      price: String("$ \(foodlist[indexPath.item].mealPrice ?? 0)"),
                      amount: String(foodlist[indexPath.item].mealAmount ?? 0))
        
        cell.foodAmountCallBack = { amount in
            cell.foodAmountLabel.text = String(amount)}
        
        return cell
    }
    
}
