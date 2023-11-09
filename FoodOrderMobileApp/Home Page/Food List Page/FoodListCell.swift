//
//  FoodListCell.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 07.11.23.
//

import UIKit

class FoodListCell: UICollectionViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var foodAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 20
    }
    
    @IBAction func addBasketButton(_ sender: Any) {
        print("addbasket")

    }
    
    @IBAction func addAmount(_ sender: Any) {
        print("plus")
    }
    
    @IBAction func subtractAmount(_ sender: Any) {
        print("minus")
    }
    
    
    func fillCell(name: String?, image: String?, price: String?, amount: String?){
        foodNameLabel.text = name
        foodImage.image = UIImage(named: image ?? "empty")
        foodPriceLabel.text = price
        foodAmountLabel.text = amount
    }
    
}
