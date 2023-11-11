//
//  Purhcase.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 09.11.23.
//

import Foundation
import RealmSwift

class Purchase: Object {
    @Persisted var totalMealPrice: Double?
    // Relationship with User
//    @Persisted var user: User?
    // List of meals
    @Persisted var mealList = List<MealModel>()
}

