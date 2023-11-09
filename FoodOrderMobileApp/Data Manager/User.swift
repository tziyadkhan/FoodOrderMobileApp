//
//  User.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 04.11.23.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted var fullname: String
    @Persisted var email: String
    @Persisted var phonenumber: String
    @Persisted var password: String
    @Persisted var purchaseList: Purchase?
    
    override init() {
        super.init()
    }
    
    init(fullname: String, email: String, phonenumber: String, password: String, purchaseList: Purchase) {
        self.fullname = fullname
        self.email = email
        self.phonenumber = phonenumber
        self.password = password
        self.purchaseList = purchaseList
    }
    
}
