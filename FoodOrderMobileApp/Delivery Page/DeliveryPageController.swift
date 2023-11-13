//
//  DeliveryPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 12.11.23.
//

import UIKit
import Lottie

class DeliveryPageController: UIViewController {
    @IBOutlet weak var deliveryLottie: LottieAnimationView!
    @IBOutlet weak var progressBarLottie: LottieAnimationView!
    @IBOutlet weak var confettiLottie: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lottiesConfig()
    }
    
    func lottiesConfig() {
        
        deliveryLottie.play()
        deliveryLottie.loopMode = .loop
        deliveryLottie.layer.cornerRadius = 20
        
        
        progressBarLottie.loopMode = .playOnce
        progressBarLottie.play { [weak self] _ in
            self?.confettiLottie.play()
            self?.confettiLottie.loopMode = .loop
        }
    }
    

}
