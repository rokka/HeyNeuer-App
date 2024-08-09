//
//  listeViewController.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 08.08.2024.
//

import UIKit
import ProgressHUD

class listeViewController: UITableViewController {
    
    var allData:Array<computerModel> = Array()
    
    var allDataDicArray:Array<Dictionary<String, Array<computerModel>>> = Array()
    
    
    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllData()
        
    }
    
    
    func loadAllData()  {
        
        self.myActivity.startAnimating()
        self.myActivity.isHidden = false
        
        WebManager().getAllListeComputer { files in
            
            let result:Array =  files["computers"] as! Array<AnyObject>
            
            for dic in result{
                let model:computerModel = computerModel().initModelFromFiles(dictionary: dic as! [String : AnyObject])
                self.allData.append(model)
                // print(model.created_at)
                
            }
            
            self.allData = self.allData.reversed()
            self.tableView.reloadData()
            self.myActivity.stopAnimating()
            self.myActivity.isHidden = true
            
            self.convertationAllDataToDate()
            
        }
    }
    
    func convertationAllDataToDate() {
        
        var activeDate:String = ""
        var activeArrayModel:Array<computerModel> = Array()
        
        for model:computerModel in self.allData {
            
            
            if activeArrayModel.isEmpty{
                
                activeDate = model.created_at
                activeArrayModel.append(model)
                
            }else{
                
                if model.created_at == activeDate{
                    
                    activeArrayModel.append(model)
                    
                }else{
                    
                    var dic:Dictionary = ["\(activeDate)":activeArrayModel]
                    self.allDataDicArray.append(dic)
                    
                    activeDate = model.created_at
                    activeArrayModel.removeAll()
                    
                }
                
            }
            
            
        }
        
        self.tableView.reloadData()
        // print(self.allDataDicArray)
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.allDataDicArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var array:Array<computerModel> = self.allDataDicArray[section].values.first!
        return array.count
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section < self.allDataDicArray.count {
            return "\(self.allDataDicArray[section].keys.first!) --- \(self.allDataDicArray[section].values.first!.count) Stücke"
        }
        
        return nil
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:computerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! computerTableViewCell
        var array:Array<computerModel> = self.allDataDicArray[indexPath.section].values.first!
        cell = cell.initCell(model: array[indexPath.row]) as! computerTableViewCell
        
        return cell
    }
    
    
    
    
    @IBAction func chartAction(_ sender: UIBarButtonItem) {

        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewControllerToPresent = storyboard.instantiateViewController(identifier: "statistic") as? statisticViewController
        viewControllerToPresent!.allDataDicArray = self.allDataDicArray
        
        if #available(iOS 15.0, *) {
            if let sheet = viewControllerToPresent?.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
                sheet.prefersGrabberVisible = true
                
            }
        } else {
            // Fallback on earlier versions
        }
        present(viewControllerToPresent!, animated: true, completion: nil)
        
    }
    
    @IBAction func filterAction(_ sender: UIBarButtonItem) {
        
        let story:UIStoryboard = UIStoryboard(name: "Main", bundle: .main)
        let vc:filterTableViewController = story.instantiateViewController(identifier: "filter") as! filterTableViewController
        vc.allDataDicArray = self.allDataDicArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

