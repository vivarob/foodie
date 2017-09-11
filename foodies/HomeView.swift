//
//  HomeView.swift
//  KindleApp
//
//  Created by Roberto Pirck Valdés on 7/9/17.
//  Copyright © 2017 PEEP TECHNOLOGIES SL. All rights reserved.
//

import UIKit
import Firebase

class HomeView: UIViewController {
    
    var handle : AuthStateDidChangeListenerHandle?

    let emailTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.placeholder = "Enter your email"
        textfield.textColor = .black
        textfield.layer.cornerRadius = 8
        textfield.clipsToBounds = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    
    let passwordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.placeholder = "Enter your password"
        textfield.textColor = .black
        textfield.isSecureTextEntry = true
        textfield.layer.cornerRadius = 8
        textfield.clipsToBounds = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOG IN", for: .normal)
        button.backgroundColor = .red
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    let logInImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "login 2")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log in"
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.3)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let _ = user {
                print("User currently logged in")
                let navController = UINavigationController(rootViewController: ViewController())
                self.present(navController, animated: false, completion: nil)
            } else {
                self.setUpView()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func actionButtonPressed(){
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error == nil {
                if let _ = user {
                    print("entering app")
                    let navController = UINavigationController(rootViewController: ViewController())
                    self.present(navController, animated: false, completion: nil)
                } else {
                    print("problemas")
                }
            }
        }
//        
//        Auth.auth().createUser(withEmail: "robertopirck@gmail.com", password: "asdasd") { (user, error) in
//            if error != nil {
//                print(error)
//            }
//            if let user = user {
//                print(user.email)
//            } else {
//                print("no user ")
//            }
//        }

        print("PRESSED")
    }
    
    
    func setUpView(){
        self.view.addSubview(emailTextfield)
        emailTextfield.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emailTextfield.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        emailTextfield.widthAnchor.constraint(equalToConstant: 200) .isActive = true
        emailTextfield.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(passwordTextfield)
        passwordTextfield.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 8) .isActive = true
        passwordTextfield.widthAnchor.constraint(equalToConstant: 200) .isActive = true
        passwordTextfield.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(actionButton)
        actionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        actionButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 8) .isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 200) .isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(logInImage)
        logInImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logInImage.bottomAnchor.constraint(equalTo: emailTextfield.topAnchor, constant: -8) .isActive = true
        logInImage.widthAnchor.constraint(equalToConstant: 200) .isActive = true
        logInImage.heightAnchor.constraint(equalToConstant: 200).isActive = true

    }

}
