//
//  SignUpViewController.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 01/11/2022.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
 
    @IBOutlet weak var buttonGoback: UIButton!
    
    @IBOutlet weak var buttonSignUp: UIButton!
    
    @IBOutlet weak var Header: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Header.textAlignment = .center
     
    }
 
    @IBAction func goback(_sender:UIButton){
        print("signup_rollback")
        self.navigationController?.popViewController(animated: true)
    }
    
}

