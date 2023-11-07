//
//  HomePageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 04.11.23.
//

import UIKit

class HomePageController: UIViewController {
    
    let helper = UserLoginFileManager()
    var items = [RestaurantModel]()
    let parser = Parser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser.parseJsonFile { parsedItems in
            self.items = parsedItems
        }

    }
    
    @IBAction func logoutButton(_ sender: Any) {
        setRoot()
    }
}

// MARK: Functions
extension HomePageController {
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(false, forKey: "loggedIN") // Setting the flag
            sceneDelegate.loginPage(windowScene: scene)
        }
    }
}
