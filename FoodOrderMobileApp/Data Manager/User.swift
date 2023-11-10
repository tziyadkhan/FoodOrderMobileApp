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

//class User: Object {
//    @Persisted var fullname: String?
//    @Persisted var email: String?
//    @Persisted var phonenumber: String?
//    @Persisted var password: String?
//    @Persisted var purchaseList: Purchase?
//    
//    override init() {
//        super.init()
//    }
//    
//    init(fullname: String?, email: String?, phonenumber: String?, password: String?, purchaseList: Purchase) {
//        self.fullname = fullname
//        self.email = email
//        self.phonenumber = phonenumber
//        self.password = password
//        self.purchaseList = purchaseList
//    }
//    
//    override class func primaryKey() -> String? {
//        return "email"
//    }
//}
