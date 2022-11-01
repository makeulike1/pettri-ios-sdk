//
//  ViewController.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 27/10/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    @IBAction func signUp(_sender:UIButton){
        guard let signUP =
                self.storyboard?.instantiateViewController(identifier: "SignUpViewController") else {return}
        self.present(signUP, animated:true)
        print("signup")
    } 
    
}

