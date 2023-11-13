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
    @Persisted var mealList = List<MealModel>()
    @Persisted var purchaseStatus: String?
}

