//
//  Purhcase.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 09.11.23.
//

import Foundation
import RealmSwift

//class Purchase: Object {
//    @Persisted var totalPrice: Int?
//    @Persisted var foodList: List<MealModel>
//    
//    override init() {
//        super.init()
//    }
//    
//    init(totalPrice: Int?, foodList: List<MealModel>) {
//        self.totalPrice = totalPrice
//        self.foodList = foodList
//    }
//}

class Purchase: Object {
    @Persisted var totalMealPrice: Double?
    // Relationship with User
    @Persisted var user: User?
    
    // List of meals
    @Persisted var mealList = List<MealModel>()
}
