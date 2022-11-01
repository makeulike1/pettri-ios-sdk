//
//  ViewController.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 27/10/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Header: UILabel!
    
    @IBOutlet weak var buttonSignup: UIButton!
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    @IBOutlet weak var textFieldID: UITextField!
    
    @IBAction func signUp(_sender:UIButton){
        guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") else { return }
        self.navigationController?.pushViewController(homeVC, animated: true)
        print("signup")
    }
    
    @IBAction func login(_sender:UIButton){
        
        var userID:String = textFieldID.text!
        
        guard let login =
                self.storyboard?.instantiateViewController(identifier: "LoginViewController") else {return}
        self.present(login, animated:true)
        
    
        pettri.login(userId:userID)
        
        print("login")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Header.textAlignment = .center
    }
    
}

