//
//  detailListTableViewController.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 08.08.2024.
//

import UIKit

class detailListTableViewController: UITableViewController {

    
    var allData:Array<computerModel> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(self.allData.count) Stücke"
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.allData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        var cell:computerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! computerTableViewCell
        cell = cell.initCell(model: allData[indexPath.row]) as! computerTableViewCell

        return cell
    }
    

}
