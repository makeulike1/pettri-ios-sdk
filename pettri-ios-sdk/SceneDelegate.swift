//
//  SceneDelegate.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 27/10/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
        // Determine who sent the URL.
        if let urlContext = connectionOptions.urlContexts.first {

            let sendingAppID = urlContext.options.sourceApplication
            let url = urlContext.url
            print("source application = \(sendingAppID ?? "Unknown")")
            print("url = \(url)")

            // Process the URL similarly to the UIApplicationDelegate example.
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
 
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        for context in URLContexts {
            
            
            
            // 클릭키와 트래킹 아이디 추출
            let urlString  = context.url.absoluteURL.absoluteString
            
            print("Url: \(context.url.absoluteURL)")
            
            guard urlString.contains("click_key") else { return }
            guard urlString.contains("trkId") else { return }

            let components = URLComponents(string: urlString)
            let urlQueryItems = components?.queryItems ?? [] // [name=jake]

            var dictionaryData = [String: String]()
            urlQueryItems.forEach { dictionaryData[$0.name] = $0.value }

            guard let ck = dictionaryData["click_key"] else { return }
            guard let trackingId = dictionaryData["trkId"] else { return }

            print("Click key = \(ck)")
            print("Tracking id = \(trackingId)")
            
            
            
            
            
            // 첫 딥링크 오픈에 대해서 로그를 생성
            let url = "http://test.adrunner.co.kr:8083/install/create"
            let prop = [] as Array<Any>
            let params = ["ck":ck, "trackingId":trackingId, "prop":prop] as Dictionary<String, Any>
                        
            
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print("Request Data : ", params)
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status code: (\(httpResponse.statusCode))")
                    // do stuff.
                }
                
                /*
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                        print(json)
                    } catch {
                        print("error")
                    }
                 */
            })
        
            task.resume()
          }
    }

}

