//
//  ViewController.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 27/10/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonSignup: UIButton!
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    @IBAction func signUp(_sender:UIButton){
        guard let signUP =
                self.storyboard?.instantiateViewController(identifier: "SignUpViewController") else {return}
        self.present(signUP, animated:true)
        print("signup")
    }
    
    @IBAction func login(_sender:UIButton){
        guard let login =
                self.storyboard?.instantiateViewController(identifier: "LoginViewController") else {return}
        self.present(login, animated:true)
        print("login")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
}

