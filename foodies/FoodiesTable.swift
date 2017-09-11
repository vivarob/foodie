//
//  FoodiesTable.swift
//  foodies
//
//  Created by Roberto Pirck Valdés on 8/9/17.
//  Copyright © 2017 PEEP TECHNOLOGIES SL. All rights reserved.
//

import UIKit
import Firebase

class FoodiesTable: UITableViewController {
    
    var foodies = [Foodie]()
    var foodiesIds = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Foodies"
        setUpNavigationBar()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFoodies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 192/255, green: 57/255, blue: 43/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 20)!]
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewFoodie))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        
    }
    
    func setUpTableView() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(FoodieCell.self, forCellReuseIdentifier: "CellId")

    }
    
    func getFoodies(){
//        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        self.foodies.removeAll()
        self.foodiesIds.removeAll()
        self.tableView.reloadData()
        ref.child("Foodies").observe(.childAdded , with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary {
                if !self.foodiesIds.contains((value["id"] as? String)!) {
                    
                    //                if value.value(forKey: "userId") as? String == userID {
                    self.foodiesIds.append((value["id"] as? String)!)
                    self.foodies.append(Foodie(dictionary: value as! [String : Any]))
                    //                }
                }

                self.tableView.reloadData()

            }
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    
    func createNewFoodie(){
        navigationController?.pushViewController(FoodieMap(), animated: true)
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.foodies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! FoodieCell
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.foodieNameLabel.text = self.foodies[indexPath.row].name
        cell.foodieAddressLabel.text = self.foodies[indexPath.row].address
        cell.foodieDateLabel.text = formatter.string(from: self.foodies[indexPath.row].date)
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
