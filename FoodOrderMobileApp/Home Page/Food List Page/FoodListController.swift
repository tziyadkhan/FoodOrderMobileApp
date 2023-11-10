//
//  FoodListController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 07.11.23.
//

import UIKit
import RealmSwift


class FoodListController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBackground: UIView!
    
    var realm = try! Realm()
    var foodList = [MealModel]()
    var foodListTemp = [MealModel]()
    var backupFoodList = [MealModel]()
    var searching = false
    var user = [User]()
    let helper = Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print(foodList)
        searchBackground.layer.cornerRadius = 20
        backupFoodList = foodList
        user = helper.fetchFromDB()
        
    }
    
    @IBAction func searchTextField(_ sender: UITextField) {
        if let searchText = sender.text, !searchText.isEmpty {
            searching = true
            foodList = foodList.filter { food in
                if let food = food.mealName {
                    return food.lowercased().contains(searchText.lowercased())
                }
                return false
            }
        } else {
            searching = false
            foodList.removeAll()
            foodList = backupFoodList
        }
        collection.reloadData()
    }
    
}

extension FoodListController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodListCell", for: indexPath) as! FoodListCell
        cell.fillCell(name: foodList[indexPath.item].mealName,
                      image: foodList[indexPath.item].mealImage,
                      price: String("$ \(foodList[indexPath.item].mealPrice ?? 0)"),
                      amount: String(foodList[indexPath.item].mealAmount ?? 0))
        var tempAmount: Int?
        
        cell.foodAmountCallBack = {(amount) -> Void in
            cell.foodAmountLabel.text = String(amount)
            tempAmount = amount
        }
        
        cell.addToBasketCallBack = {

        }
        return cell
    }
}


//            do {
//                    try self.realm.write {
//                        if let currentUser = self.user.first {
//                            currentUser.purchaseList?.foodList.append(objectsIn: tempPurchase.foodList)
//                            self.helper.saveToDB(user: currentUser)
//                        }
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }



//guard indexPath.item < self.foodList.count else {
//    print("Index out of range")
//    return
//}
//
//self.foodList[indexPath.item].mealAmount = tempAmount
//let tempPurchase = Purchase()
//
//tempPurchase.foodList.append(objectsIn: self.foodList.filter ({$0.mealAmount ?? 0 > 0}))
//
////            if let currentUser = self.user.first {
////                    self.helper.updatePurchaseList(for: currentUser, with: tempPurchase)
////                }
//
////            print(self.user)
//print(tempPurchase)
//self.helper.getFilePath()
//
//

