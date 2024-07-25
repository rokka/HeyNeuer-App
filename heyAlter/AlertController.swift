//
//  AlertController.swift
//  AFRA
//
//  Created by Andrii Buchkivskyi on 07/10/2019.
//  Copyright © 2019 itDevStudia. All rights reserved.
//

import UIKit

class AlertController: NSObject {
    
    func showInformation(title:String,message:String, VC:UIViewController, completion: @escaping (Any) -> () ) {
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
            // VC.dismiss(animated: true, completion: nil)
            
            completion((Any).self)
            
        }
        
        alertController.addAction(okAction)
        
        VC.present(alertController, animated: true) {
            //
        }
        
    }
    
    
}

extension UIViewController {
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
