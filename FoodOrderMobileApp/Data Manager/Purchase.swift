//
//  Purhcase.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 09.11.23.
//

import Foundation
import RealmSwift

class Purchase: Object {
    @Persisted var totalPrice: Int
    @Persisted var foodList: MealModel?
    
    override init() {
        super.init()
    }
    
    init(totalPrice: Int, foodList: MealModel) {
        self.totalPrice = totalPrice
        self.foodList = foodList
    }
}
