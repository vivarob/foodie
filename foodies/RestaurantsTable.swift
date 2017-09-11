//
//  ViewController.swift
//  foodies
//
//  Created by Roberto Pirck Valdés on 8/9/17.
//  Copyright © 2017 PEEP TECHNOLOGIES SL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Restaurants"
        self.view.backgroundColor = .white

        seUpNavigationController()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func seUpNavigationController() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 192/255, green: 57/255, blue: 43/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 20)!]
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToRestaurantMap))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
    }
    
    func goToRestaurantMap(){
        navigationController?.pushViewController(RestaurantMap(), animated: true)
    }

}

