//
//  computerTableViewCell.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 08.08.2024.
//

import UIKit

class computerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var cpuLabel: UILabel!
    @IBOutlet weak var oopLabel: UILabel!
    @IBOutlet weak var hddLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    struct typeStruct {
        var delivered = "Ausgeliefert"
        var new = "Neu"
        var in_progress = "Wird bearbeitet"
        var refurbished = "Aufbereitet"
        var picked = "Kommissioniert"
        var destroyed = "Entsorgt"
        var loss = "Schwund"
    }
    
    var activeType: typeStruct = .init()

    
    func initCell(model:computerModel) -> UITableViewCell {
        
        self.nameLabel.text = "HA-E-\(model.number)"
        
        switch model.type {
        case 1:
            self.typeLabel.text = "Desktop"
        case 2:
            self.typeLabel.text = "Laptop"
        default:
            self.typeLabel.text = "-"
            
        }
        
        
        self.modelLabel.text = model.model
        self.cpuLabel.text = model.cpu ?? "-"
        self.oopLabel.text = "\(model.memory_in_gb) GB"
        self.hddLabel.text = "\(model.hard_drive_space_in_gb) GB"
        
        switch model.state {
            
        case "delivered":
            self.statusLabel.text = self.activeType.delivered
            
        case "new":
            self.statusLabel.text = self.activeType.new
            
        case "in_progress":
            self.statusLabel.text = self.activeType.in_progress
            
        case "refurbished":
            self.statusLabel.text = self.activeType.refurbished
            
        case "picked":
            self.statusLabel.text = self.activeType.picked
            
        case "destroyed":
            self.statusLabel.text = self.activeType.destroyed
            
        case "loss":
            self.statusLabel.text = self.activeType.loss
            
        default:
            "--"
        }
        
        
        self.dateLabel.text = model.created_at

        return self
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
