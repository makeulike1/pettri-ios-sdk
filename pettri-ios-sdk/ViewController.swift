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
    
    @IBAction func signUp(_sender:UIButton){
        /*
        guard let signUP =
                self.storyboard?.instantiateViewController(identifier: "SignUpViewController") else {return}
        self.present(signUP, animated:true)
         */
        // navigation controller 로 화면 전환
        guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") else { return }
        self.navigationController?.pushViewController(homeVC, animated: true)
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
        Header.textAlignment = .center
     
    }
    
}

