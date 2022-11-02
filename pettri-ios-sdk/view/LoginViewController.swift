//
//  LoginViewController.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 01/11/2022.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var buttonGoMain: UIButton!
    
    @IBOutlet weak var Header: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Header.textAlignment = .center
        
    }

    @IBAction func goMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        pettri.logout()
    }
    
}

