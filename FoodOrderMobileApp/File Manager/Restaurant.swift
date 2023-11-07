//
//  Restaurant.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 07.11.23.
//

import Foundation

struct RestaurantModel: Codable {
    var restaurantName: String?
    var restaurantImage: String?
    var restaurantInfo: String?
    var restaurantWorkingHours: String?
    var restaurantPromotionText: String?
    var restaurantPromotionImage: String?
    var mealList: [MealModel]?
}

struct MealModel: Codable {
    var mealName: String?
    var mealImage: String?
    var mealPrice: Int?
    var mealContent: String?
    var mealAmount: Int?
}
