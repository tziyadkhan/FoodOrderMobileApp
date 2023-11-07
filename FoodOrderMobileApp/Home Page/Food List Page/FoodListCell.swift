//
//  FoodListCell.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 07.11.23.
//

import UIKit

class FoodListCell: UICollectionViewCell {
    @IBOutlet weak var discountBackgroundView: UIView!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shapeConfig()
    }
    
    @IBAction func addBasketButton(_ sender: Any) {

    }
    func fillCell(name: String?, image: String?, price: String?, discount: String){
        foodNameLabel.text = name
        foodImage.image = UIImage(named: image ?? "empty")
        foodPriceLabel.text = price
        discountLabel.text = discount
    }
    
    func shapeConfig() {
        discountBackgroundView.layer.cornerRadius = 10
        background.layer.cornerRadius = 20 
        foodImage.layer.cornerRadius = foodImage.frame.height/2
//        foodImage.layer.borderWidth = 1
        foodImage.layer.masksToBounds = false
        foodImage.clipsToBounds = true
    }
    
}
