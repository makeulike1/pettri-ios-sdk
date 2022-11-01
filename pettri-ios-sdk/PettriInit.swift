//
//  PettriInit.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 28/10/2022.
//

import Foundation

class PettriInit{
    
    var CLICK_KEY:String = ""
  
    var TRACKING_ID:String = ""
    
    
    // 클릭키와 트래킹 아이디 추출
    func parseCkAndTRKId(url:URL){
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
    
    
    // 첫 딥링크 오픈에 대해서 로그를 생성
    func sendInstall(){
        let req = RequestApi()
        let url = "http://test.adrunner.co.kr:8083/install/create"
        let prop = [] as Array<Any>
        let params = ["ck":CLICK_KEY, "trackingId":TRACKING_ID, "prop":prop] as Dictionary<String, Any>        
        req.doPost(url:url, params:params)
    }
    
    
}
