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
    
    @IBOutlet weak var textFieldID: UITextField!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var buttonSignUp: UIButton!
    
    @IBOutlet weak var Header: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Header.textAlignment = .center
    }
 
    @IBAction func goback(_sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signup(_ sender: Any) {
        let signupUserId:String = textFieldID.text!
        let signupEMAIL:String = textFieldEmail.text!
        let signupName:String = textFieldName.text!
 
        var prop = [Dictionary<String, Any>]()
        
        let dict1 = ["key":"email", "value": signupEMAIL]
        let dict2 = ["key":"name",  "value": signupName]
        
        prop.append(dict1)
        prop.append(dict2)
        
        pettri.createUser(userId: signupUserId, prop: prop)
        
    }
}

