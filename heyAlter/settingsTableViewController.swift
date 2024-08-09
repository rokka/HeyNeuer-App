//
//  settingsTableViewController.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 03.08.2024.
//

import UIKit

class settingsTableViewController: UITableViewController {
    
    @IBOutlet weak var tokenLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tokenLabel.text = Singletone.shared.api_token
        
    }
    
    func saveNewToken() {
        
        let alertController = UIAlertController(title: "Schreiben Sie einen Token", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Token"
        }
        
        let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
            
            if let text = alertController.textFields?.first?.text {
                // Handle submitted text
                
                Singletone.shared.saveToken(token: text)
                self.tokenLabel.text = text
                self.navigationController?.popViewController(animated: true)
                
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Abschaffung", style: .cancel) { _ in
            
            
        }
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func addNewTokenAction(_ sender: UIBarButtonItem) {
        
        saveNewToken()
        
    }
    
}
