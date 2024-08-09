//
//  filterTableViewController.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 08.08.2024.
//

import UIKit

class filterTableViewController: UITableViewController {

    var allDataDicArray:Array<Dictionary<String, Array<computerModel>>> = Array()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allDataDicArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(allDataDicArray[indexPath.row].keys.first!)"
        cell.detailTextLabel?.text = "\(allDataDicArray[indexPath.row].values.first!.count) Stücke"
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let story:UIStoryboard = UIStoryboard(name: "Main", bundle: .main)
        let vc:detailListTableViewController = story.instantiateViewController(identifier: "detail") as! detailListTableViewController
        
        var array:Array<computerModel> = self.allDataDicArray[indexPath.row].values.first!

        vc.allData = array
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
