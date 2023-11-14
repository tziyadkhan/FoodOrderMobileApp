//
//  RestaurantsCell.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 07.11.23.
//

import UIKit

class RestaurantsCell: UICollectionViewCell {
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    
    var restaurantInfoCallBack: (() -> Void)? //Info button'nu istifade etmek ucun 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shapeConfiguration()
    }
    
    @IBAction func restaurantInfoButton(_ sender: Any) {
        restaurantInfoCallBack?()
    }
    
    func shapeConfiguration() {
        background.layer.cornerRadius = 20
        restaurantImage.layer.cornerRadius = 20
    }
    
    func addItemToCell(name: String?, resImage: String?) {
        restaurantName.text = name
        restaurantImage.image = UIImage(named: resImage ?? "empty")
    }
    
}
