//
//  User.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 04.11.23.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString // Using UUID as the primary key
    @Persisted var fullName: String?
    @Persisted var email: String?
    @Persisted var password: String?
    @Persisted var phoneNumber: String?
    
    // Relationship with Purchase
    @Persisted var purchase: Purchase?
}
