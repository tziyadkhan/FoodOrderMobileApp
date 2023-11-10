//
//  Meal.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 09.11.23.
//

import Foundation
import RealmSwift

//class MealModel: Object, Codable {
//    @Persisted var mealName: String?
//    @Persisted var mealImage: String?
//    @Persisted var mealPrice: Double?
//    @Persisted var mealContent: String?
//    @Persisted var mealAmount: Int?
//    @Persisted var mealDeliveryFee: String?
//}

class MealModel: Object, Codable{
    @Persisted var mealName: String?
    @Persisted var mealImage: String? // Assuming you want to store the image as Data
    @Persisted var mealPrice: Double?
    @Persisted var mealContent: String?
    @Persisted var mealAmount: Int?
    @Persisted var mealDeliveryTime: String?
}
