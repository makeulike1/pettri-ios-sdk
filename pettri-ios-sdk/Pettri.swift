//
//  Pettri.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 01/11/2022.
//

import Foundation

class Pettri{
    
    var CLICK_KEY:String        = ""
    var TRACKING_ID:String      = ""
    var USER_ID:String          = ""
    
    var isLogin:Bool            = false
    
    init(CLICK_KEY: String, TRACKING_ID: String, USER_ID:String) {
        self.CLICK_KEY = CLICK_KEY
        self.TRACKING_ID = TRACKING_ID
        self.USER_ID = USER_ID
    }
    
    
    /*** Initialize the Pettri Module. */
    func start(url:URL){
        let urlString  = url.absoluteString
        
        print("Url: \(url.absoluteURL)")
        
        guard urlString.contains("click_key") else { return }
        guard urlString.contains("trkId") else { return }

        let components = URLComponents(string: urlString)
        let urlQueryItems = components?.queryItems ?? [] // [name=jake]

        var dictionaryData = [String: String]()
        urlQueryItems.forEach { dictionaryData[$0.name] = $0.value }

        guard dictionaryData["click_key"] != nil else { return }
        guard dictionaryData["trkId"] != nil else { return }

        CLICK_KEY   = dictionaryData["click_key"]!
        TRACKING_ID = dictionaryData["trkId"]!
        
    }
    
    
    
    
    
    
    /*** Send Re-Installation Log to Attribution . */
    func sendInstall(){
        let req = RequestApi()
        let url = "http://test.adrunner.co.kr:8083/install/create"
        let prop = [] as Array<Any>
        let params = ["ck":CLICK_KEY, "trackingId":TRACKING_ID, "prop":prop] as Dictionary<String, Any>
        req.doPost(url:url, params:params)
    }
    
    
    
    /*** Send Event Log to Attribution. **/
    func sendEvent(name:String){
        let req = RequestApi()
        let url = "http://test.adrunner.co.kr:8083/event/create"
        let prop = [] as Array<Any>
        let params = ["ck":CLICK_KEY, "trackingId":TRACKING_ID, "userId":USER_ID, "name":name, "prop":prop] as Dictionary<String, Any>
        req.doPost(url: url, params: params)
    }
    
    
    /*** Save login data into Petrri module.*/
    func login(userId:String){
        USER_ID = userId
        isLogin = true
        
        sendEvent(name:"login")
    }
    
    
    
    /*** Save logout data into Pettri module. */
    func logout(userId:String){
        USER_ID = userId
        isLogin = false
        
        sendEvent(name:"logout")
    }
    
}


var pettri = Pettri(CLICK_KEY: "", TRACKING_ID: "", USER_ID: "")


