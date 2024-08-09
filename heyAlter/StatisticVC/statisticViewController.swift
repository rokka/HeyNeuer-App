//
//  statisticViewController.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 08.08.2024.
//

import UIKit

class statisticViewController: UIViewController {
    
    @IBOutlet weak var lineChart: LineChart!
    var allDataDicArray:Array<Dictionary<String, Array<computerModel>>> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataEntries = generateEntries()
        
        lineChart.dataEntries = dataEntries
        lineChart.isCurved = true
        
        
        
    }
    
    private func generateEntries() -> [PointEntry] {
        
        var result: [PointEntry] = []
        
        for mod in self.allDataDicArray{
            
            let dateString:String = mod.keys.first!
            let valeyCount:Int = mod.values.first!.count
            
            result.append(PointEntry(value: valeyCount, label: dateString))
            
        }
        
        return result
    }
    
    
}
