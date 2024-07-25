//
//  ViewController.swift
//  heyAlter
//
//  Created by Andrii Buchkivskyi on 23.07.2024.
//

import UIKit
import BottomSheetController
import ProgressHUD
import QRCodeReader
import AVFoundation

var readerVC: QRCodeReaderViewController = {
    let builder = QRCodeReaderViewControllerBuilder {
        $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        
        // Configure the view controller (optional)
        $0.showTorchButton        = true
        $0.showSwitchCameraButton = false
        $0.showCancelButton       = false
        $0.showOverlayView        = false
        $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
    }
    
    return QRCodeReaderViewController(builder: builder)
}()

protocol updateComputerDelegate:AnyObject {
    
    func updateUIComputer(computerModel:computerModel)
    
}


class ViewController: UITableViewController, updateComputerDelegate, QRCodeReaderViewControllerDelegate{
    
        
    struct typeStruct {
        var delivered = "Ausgeliefert"
        var new = "Neu"
        var in_progress = "Wird bearbeitet"
        var refurbished = "Aufbereitet"
        var picked = "Kommissioniert"
        var destroyed = "Entsorgt"
        var loss = "Schwund"
    }
    
    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var compNummer: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var cpuLabel: UILabel!
    @IBOutlet weak var memoryLabel: UILabel!
    @IBOutlet weak var ssdLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var computerModel:computerModel?
    var activeType: typeStruct = .init()
    var selectedTypeString:String = ""
    
    var activeDataBool:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initUI()
        
        
    }
    
    func updateUIComputer(computerModel: computerModel) {
        self.computerModel = computerModel
        self.initCompInformation()
        // self.tableView.reloadData()
    }
    
    func initUI()  {
        
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        // set position
        actionView.translatesAutoresizingMaskIntoConstraints = false
        actionView.leftAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leftAnchor).isActive = true
        actionView.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor).isActive = true
        actionView.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        actionView.widthAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.widthAnchor).isActive = true
        actionView.heightAnchor.constraint(equalToConstant: 68).isActive = true // specify the height of the view
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if activeDataBool == true{
            return 2
        }else{
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }else if section == 1{
            
            if activeDataBool == true{
                return 1
            }else{
                return 0
            }
            
        }
        
        return 0
        
    }
    
    @IBAction func statusAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewControllerToPresent = storyboard.instantiateViewController(identifier: "status") as? pageStatusViewController
        viewControllerToPresent?.selectedTypeString = self.selectedTypeString
        viewControllerToPresent!.nummerComp = self.nameLabel.text!
        viewControllerToPresent!.delegate = self
        
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
    
    @IBAction func scannerAction(_ sender: UIButton) {
        
        readerVC.delegate = self

          // Or by using the closure pattern
          readerVC.completionBlock = { (result: QRCodeReaderResult?) in
              print(result?.value as Any)
              
              
              self.compNummer.text = result?.value
              self.searchComputer()

          }

          // Presents the readerVC as modal form sheet
          readerVC.modalPresentationStyle = .formSheet
         
          present(readerVC, animated: true, completion: nil)
        
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods

    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }

    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
       
        
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }

    
    @IBAction func searchAction(_ sender: UIButton) {
        
        if self.compNummer.text == ""{
            
        }else{
            searchComputer()
        }
        
        
    }
    
    func searchComputer() {
        
        
        self.myActivity.startAnimating()
        self.myActivity.isHidden = false
        
        WebManager().getComputer(compNumber: self.compNummer.text ?? "") { files in
            
            print(files)
            
            if (files.isEmpty){
                
                self.activeDataBool = false
                self.tableView.reloadData()
                
                AlertController().showInformation(title: "", message: "Nichts gefunden", VC: self) { vc in
                    
                }
                
                
            }else{
                
                self.computerModel = heyAlter.computerModel().initModelFromFiles(dictionary: files as [String : AnyObject])
                self.activeDataBool = true
                self.initCompInformation()
                self.tableView.reloadData()
                
            }
            
            self.myActivity.stopAnimating()
            self.myActivity.isHidden = true
            
        }
        
    }
    
    func initCompInformation() {
        
        self.nameLabel.text = "HA-E-\(String(describing: self.compNummer.text!))"
        self.modelLabel.text = self.computerModel?.model
        self.cpuLabel.text = self.computerModel?.cpu
        self.memoryLabel.text = "\(String(describing: self.computerModel!.memory_in_gb))"
        self.ssdLabel.text = "\(String(describing: self.computerModel!.hard_drive_space_in_gb))"
        
        switch self.computerModel?.state {
            
        case "delivered":
            self.statusLabel.text = self.activeType.delivered
            self.selectedTypeString = self.activeType.delivered
            
        case "new":
            self.statusLabel.text = self.activeType.new
            self.selectedTypeString = self.activeType.new
            
        case "in_progress":
            self.statusLabel.text = self.activeType.in_progress
            self.selectedTypeString = self.activeType.in_progress
            
        case "refurbished":
            self.statusLabel.text = self.activeType.refurbished
            self.selectedTypeString = self.activeType.refurbished
            
        case "picked":
            self.statusLabel.text = self.activeType.picked
            self.selectedTypeString = self.activeType.picked
            
        case "destroyed":
            self.statusLabel.text = self.activeType.destroyed
            self.selectedTypeString = self.activeType.destroyed
            
        case "loss":
            self.statusLabel.text = self.activeType.loss
            self.selectedTypeString = self.activeType.loss
            
        default:
            "--"
        }
        
        
        switch self.computerModel?.type {
        case 1:
            self.typeLabel.text = "Desktop"
        case 2:
            self.typeLabel.text = "Laptop"
        default:
            self.typeLabel.text = "-"
            
        }
        
        
        
        
    }
    
}

