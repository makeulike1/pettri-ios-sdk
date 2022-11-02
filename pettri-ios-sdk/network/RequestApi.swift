//
//  RequesetApi.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 28/10/2022.
//

import Foundation

class RequestApi {
    
    func doPost(url:String, params:Dictionary<String, Any>){
        
        print("[PETTRI]Calling REST API... URL: (\(url)), Request Data : (\(params))")
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                print("[PETTRI]Status code: (\(httpResponse.statusCode))")
            }
    
        })
    
        task.resume()
    }
    
 
    
}
