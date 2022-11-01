//
//  SignUpCompleteViewController.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 01/11/2022.
//

import Foundation
import UIKit

class SignUpCompleteViewController: UIViewController {
 
    @IBOutlet weak var buttonGoMain: UIButton!
    
    @IBOutlet weak var header: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.textAlignment = .center
    }
    
    @IBAction func goMain(_ sender: Any) {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllerStack {
          if let goView = viewController as? ViewController {
            self.navigationController?.popToViewController(goView, animated: true)
            }
        }
    }
    
}

