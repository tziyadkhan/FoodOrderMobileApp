//
//  RestaurantInfoController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 07.11.23.
//

import UIKit

class RestaurantInfoController: UIViewController {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantRate: UILabel!
    @IBOutlet weak var restaurantDistance: UILabel!
    @IBOutlet weak var restaurantSlogan: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var restaurantDeliveryTime: UILabel!
    @IBOutlet weak var restaurantWorkingHours: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var restaurantInfo: UITextView!
    
    var restaurant: RestaurantModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
    }
    
    func fillData() {
        restaurantName.text = restaurant?.restaurantName
        restaurantImage.image = UIImage(named: restaurant?.restaurantImage ?? "empty")
        self.restaurantImage.layer.cornerRadius = 20
        restaurantRate.text = restaurant?.restaurantRate
        restaurantDistance.text = restaurant?.restaurantDistance
        restaurantSlogan.text = restaurant?.restaurantSlogan
        restaurantAddress.text = "Address: \(restaurant?.restaurantAdress ?? "")"
        restaurantDeliveryTime.text = "Delivery Time: \(restaurant?.restaurantDeliveryTime ?? "")"
        restaurantWorkingHours.text = "Working hours: \(restaurant?.restaurantWorkingHours ?? "")"
        restaurantInfo.text = restaurant?.restaurantInfo
        restaurantInfo.layer.cornerRadius = 20
        aboutLabel.text = "About \(restaurant?.restaurantName ?? "")"        
    }

}


