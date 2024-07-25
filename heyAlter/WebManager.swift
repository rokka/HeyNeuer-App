//
//  WebManager.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 24.07.2024.
//

import UIKit
import Alamofire

class WebManager: NSObject {
    
    
    ///Suchen Computer
    func getComputer(compNumber:String, completion: @escaping (Dictionary<String, Any>) -> () ) {
        
        let url = "https://heyneuer.com/api/computers/\(compNumber)"
        
        
        
        AF.request(url, method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer rLEtJrkxLvrguSB8yvTTjFO8liL4h296fKB3vYWj"]).responseJSON {
            
            response in
            
            let responseData = response.result as AnyObject
            
            switch response.result {
                
            case .success(let value):
                
                let result =  value as? Dictionary<String, Any>
                
                let result2 =  result!["computer"]
                
                print(result2!)
                
                
                completion(result2 as! Dictionary<String, Any>)
                
            case .failure(let error):
                print(error)
                
                let dic:Dictionary = Dictionary<String, Any>.init()
                completion(dic)
                
            }
        }
        
    }
    
    
    ///Update Computer
    func updateComputer(compNumber:String, newStatus:String, completion: @escaping (Dictionary<String, Any>) -> () ) {
        
        let url = "https://heyneuer.com/api/computers/\(compNumber)"
        
        let parameters = [
            "state"  : newStatus
        ]
        
        AF.request(url, method: .patch,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer rLEtJrkxLvrguSB8yvTTjFO8liL4h296fKB3vYWj"]).responseJSON {
            
            response in
            
            let responseData = response.result as AnyObject
            
            switch response.result {
                
            case .success(let value):
                
                let result =  value as? Dictionary<String, Any>
                
                completion(result!)
                
            case .failure(let error):
                print(error)
                
                let dic:Dictionary = Dictionary<String, Any>.init()
                completion(dic)
                
            }
        }
        
    }
    
}


