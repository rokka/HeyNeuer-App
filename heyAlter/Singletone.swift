//
//  Singletone.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 03.08.2024.
//

import UIKit

class Singletone: NSObject {
    
    static var shared: Singletone = {
        let instance = Singletone()
        
        return instance
    }()
    
    
    var api_token:String = ""
    
    func saveToken(token:String){
        
        self.api_token = token
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.synchronize()
        
    }
    
    func loadApiToken() {
        
        let userDefaults = UserDefaults.standard
        self.api_token = userDefaults.object(forKey: "token") as? String ?? ""
        print(self.api_token)
        
    }
    
    func deleteProfile() {
        
        self.api_token = ""
        UserDefaults.standard.set("", forKey: "token")
        
    }
    
}
