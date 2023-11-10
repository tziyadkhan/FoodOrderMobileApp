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
    
    var foodAmountCallBack: ((_ amount: Int) -> Void)?
    var addToBasketCallBack: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 20
    }
    
    @IBAction func addBasketButton(_ sender: Any) {
        print("addbasket")
        addToBasketCallBack?()

    }
    
    @IBAction func addAmount(_ sender: Any) {
        print("plus")
        let amount = self.foodAmountLabel.text ?? "0"
        var count: Int = Int(amount) ?? 0
        count += 1
        foodAmountCallBack?(count)
    }
    
    @IBAction func subtractAmount(_ sender: Any) {
        print("minus")
        let amount = self.foodAmountLabel.text ?? "0"
        var count: Int = Int(amount) ?? 0
        if count == 0 {
            
        } else {
            count -= 1
        }
        foodAmountCallBack?(count)
    }
    
    
    func fillCell(name: String?, image: String?, price: String?, amount: String?){
        foodNameLabel.text = name
        foodImage.image = UIImage(named: image ?? "empty")
        foodPriceLabel.text = price
        foodAmountLabel.text = amount
    }
    
}
