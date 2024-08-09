//
//  WebManager.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 24.07.2024.
//

import UIKit
import Alamofire

class WebManager: NSObject {
    
    private let mainURL:String = "https://heyneuer.com/api"
    // rLEtJrkxLvrguSB8yvTTjFO8liL4h296fKB3vYWj
    
    ///Suchen Computer
    func getComputer(compNumber:String, completion: @escaping (Dictionary<String, Any>) -> () ) {
        
        
        
        AF.request("\(mainURL)/computers/HA-E-\(compNumber)", method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer \(Singletone.shared.api_token)"]).responseJSON {
            
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
    
    ///Suchen Computer
    func getAllListeComputer( completion: @escaping (Dictionary<String, Any>) -> () ) {
        
                
        AF.request("\(mainURL)/computers/", method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer \(Singletone.shared.api_token)"]).responseJSON {
            
            response in
            
            let responseData = response.result as AnyObject
            
            switch response.result {
                
            case .success(let value):
                
                let result =  value as? Dictionary<String, Any>
                                
            //    print(result)
                
                
                completion(result as! Dictionary<String, Any>)
                
            case .failure(let error):
                print(error)
                
                let dic:Dictionary = Dictionary<String, Any>.init()
                completion(dic)
                
            }
        }
    }
    
    
    ///Update Computer
    func updateComputer(compNumber:String, newStatus:String, completion: @escaping (Dictionary<String, Any>) -> () ) {
        
        
        let parameters = [
            "state"  : newStatus
        ]
        
        AF.request("\(mainURL)/computers/\(compNumber)", method: .patch,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: ["Authorization": "Bearer \(Singletone.shared.api_token)"]).responseJSON {
            
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


