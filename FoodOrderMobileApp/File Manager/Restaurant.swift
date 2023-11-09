//
//  Restaurant.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 07.11.23.
//

import Foundation

struct RestaurantModel: Codable {
    var restaurantName: String?
    var restaurantSlogan: String?
    var restaurantImage: String?
    var restaurantInfo: String?
    var restaurantWorkingHours: String?
    var restaurantAdress: String?
    var restaurantRate: String?
    var restaurantDistance: String?
    var restaurantDeliveryTime: String?
    var mealList: [MealModel]?
}

struct MealModel: Codable {
    var mealName: String?
    var mealImage: String?
    var mealPrice: Double?
    var mealDiscount: String?
    var mealContent: String?
    var mealAmount: Int?
    var mealDeliveryFee: String?
}
