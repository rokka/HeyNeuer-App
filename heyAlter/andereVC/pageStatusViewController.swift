//
//  pageStatusViewController.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 23.07.2024.
//

import UIKit

class pageStatusViewController: UIViewController {
    
    
    var selectedTypeString:String = ""
    var nummerComp:String = ""
    var computerModel:computerModel?
    
    weak var delegate:updateComputerDelegate?
    
    @IBOutlet var actionArray: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initActiveButton()
        
    }
    
    
    func initActiveButton() {
        
        
        for butt in actionArray{
            
            if self.selectedTypeString == butt.titleLabel?.text{
                butt.backgroundColor = .systemGray
            }
        }
        
    }
    
    @IBAction func selectAction(_ sender: UIButton) {
        
        
        updateComputer(newStatus: sender.restorationIdentifier!)
        
        
        
    }
    
    func updateComputer(newStatus:String) {
        
        WebManager().updateComputer(compNumber: nummerComp, newStatus: newStatus) { files in
            
            print(files)
            
            if (files.isEmpty){
                                
                AlertController().showInformation(title: "", message: "Eroor", VC: self) { vc in
                    
                }
                
            }else{
                
                self.computerModel = heyAlter.computerModel().initModelFromFiles(dictionary: files as [String : AnyObject])
                
                self.delegate?.updateUIComputer(computerModel: self.computerModel!)
                
                self.dismiss(animated: true)
                
            }
            
        }
        
    }
    
}
