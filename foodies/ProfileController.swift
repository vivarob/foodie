//
//  ProfileController.swift
//  KindleApp
//
//  Created by peepteam on 7/9/17.
//  Copyright © 2017 PEEP TECHNOLOGIES SL. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource ,UITableViewDelegate, UITableViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var sports = [UIImage]()
    var storedOffsets = [Int: CGFloat]()
    var apellidos = ["Pirck","Valdés","Ramirez","Gonzalez","Velver","Mateo","Rodriguez","Pacho"]
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?
    

    var profileImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "roberto"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Auth.auth().currentUser?.displayName
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.3)
        for index in 1...6 {
            sports.append(UIImage(named: String(index))!)
        }
        


        setUpNavigationButtons()
        setUpView()
        setUpCollectionView()
        setUpTableView()

    }
    
    func setUpNavigationButtons() {
        let backButton = UIButton.init(type: .custom)
        backButton.setImage(#imageLiteral(resourceName: "backArrow"), for: UIControlState.normal)
        backButton.frame = CGRect.init(x: 0, y: 0, width: 12, height: 20)
        backButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        let leftButtonItem = UIBarButtonItem.init(customView: backButton)
        navigationItem.leftBarButtonItem = leftButtonItem
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
    }
    
    func logOut(){
        try! Auth.auth().signOut()
        present(HomeView(), animated: false, completion: nil)
    }
    
    func setUpCollectionView(){
        print("Setting collectionview...")
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView?.register(SportCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = .clear
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(collectionView!)
        collectionView?.centerXAnchor.constraint(equalTo: self.profileImage.centerXAnchor).isActive = true
        collectionView?.widthAnchor.constraint(equalToConstant: 300).isActive = true
        collectionView?.heightAnchor.constraint(equalToConstant: 120).isActive = true
        collectionView?.topAnchor.constraint(equalTo: self.profileImage.bottomAnchor, constant: 16).isActive = true
        collectionView?.layer.cornerRadius = 60
        collectionView?.clipsToBounds = true
    }
    
    func setUpTableView(){
        print("Setting tableview...")
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CollectionInTableCell.self, forCellReuseIdentifier: "CellId")
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.backgroundColor = .lightGray
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: self.profileImage.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        tableView.topAnchor.constraint(equalTo: self.profileImage.bottomAnchor, constant: 132).isActive = true
        tableView.layer.cornerRadius = 20
    }
    
    
    
    func dismissVC(){
        navigationController?.popViewController(animated: true)
    }
    
    func setUpView(){
        print("Setting profile image...")
        view.addSubview(profileImage)
        profileImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! SportCell
            cell.sportImage.image = sports[indexPath.row]
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId2", for: indexPath) as! SportCell
            cell.sportImage.image = sports[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apellidos.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! CollectionInTableCell
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CollectionInTableCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row, forSection: indexPath.section)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }

    
}
