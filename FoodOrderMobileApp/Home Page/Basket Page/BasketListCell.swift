//
//  BasketListCell.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 09.11.23.
//

import UIKit

class BasketListCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodAmountLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(name: String?, image: String?, amount: String?, price: String?) {
        foodNameLabel.text = name
        foodImageView.image = UIImage(named: image ?? "")
        foodAmountLabel.text = amount
        foodPriceLabel.text = price
    }

}
