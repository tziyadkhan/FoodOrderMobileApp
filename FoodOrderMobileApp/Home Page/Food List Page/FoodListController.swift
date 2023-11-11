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
        
        // Update amount when the plus button is tapped
        cell.foodAmountCallBack = { [weak self] amount in
            self?.updateAmount(indexPath: indexPath, newAmount: amount)
            cell.fillCell(name: self?.foodList[indexPath.item].mealName,
                          image: self?.foodList[indexPath.item].mealImage,
                          price: String("$ \(self?.foodList[indexPath.item].mealPrice ?? 0)"),
                          amount: String(self?.foodList[indexPath.item].mealAmount ?? 0))
        }
        
        // Add to Basket
        cell.addToBasketCallBack = { [weak self] in
            self?.addToBasket(indexPath: indexPath)
        }
        
        return cell
    }
    
     func updateAmount(indexPath: IndexPath, newAmount: Int) {
        // Update the amount in your data source (foodList) accordingly
        self.foodList[indexPath.item].mealAmount = newAmount
        
        if let cell = collection.cellForItem(at: indexPath) as? FoodListCell {
            cell.foodAmountLabel.text = String(newAmount)
        }
    }
    
     func addToBasket(indexPath: IndexPath) {
        // Get the currently logged-in user
        guard let currentUser = helper.fetchFromDB().first else {
            print("No user found.")
            return
        }
        
        let selectedMeal = self.foodList[indexPath.item]
        
        if let existingMeal = currentUser.purchase?.mealList.first(where: { $0.mealName == selectedMeal.mealName }) {
            // If the meal is already in the basket, update the count
            do {
                try self.realm.write {
                    existingMeal.mealAmount = selectedMeal.mealAmount
                }
                print("Meal count updated in the basket.")
            } catch {
                print("Error updating meal count: \(error)")
            }
        } else {
            // If the meal is not in the basket, add it with the current amount
            let newMeal = MealModel()
            newMeal.mealName = selectedMeal.mealName
            newMeal.mealImage = selectedMeal.mealImage
            newMeal.mealPrice = selectedMeal.mealPrice
            newMeal.mealContent = selectedMeal.mealContent
            newMeal.mealAmount = selectedMeal.mealAmount
            newMeal.mealDeliveryTime = selectedMeal.mealDeliveryTime
            
            do {
                try self.realm.write {
                    currentUser.purchase?.mealList.append(newMeal)
                }
                print("Meal added to basket.")
            } catch {
                print("Error adding meal to basket: \(error)")
            }
        }
    }
}
