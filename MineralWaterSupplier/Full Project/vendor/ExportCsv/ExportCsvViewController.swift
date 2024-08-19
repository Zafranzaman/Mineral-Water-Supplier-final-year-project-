//
//  ExportCsvViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 28/05/2023.
//

import UIKit

class ExportCsvViewController: UIViewController {
    let backgroundimageview = UIImageView()
    var exportdata = [ExportData]()
    @IBOutlet weak var LastDate: UILabel!
    @IBOutlet weak var StartDateText: UITextField!
    @IBOutlet weak var EndDateText: UITextField!
    
    @IBOutlet weak var datePicker1: UIDatePicker!
    @IBOutlet weak var datePicker2: UIDatePicker!
    var sdate:Date?
    var edate:Date?
    let dateFormatter = DateFormatter()
    let dateFormatter1 = DateFormatter()
    var vid = 0
    var expoertdata = [ExportData]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        vid = UserSession.shared.user?.acountId ?? 0
        let vendorExportKey = "LastExportDate_\(vid)"
        if let lastDate = UserDefaults.standard.object(forKey: vendorExportKey) as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US")
            let formattedDate = dateFormatter.string(from: lastDate)
            LastDate.text = formattedDate
        }

        
        setBackground()
        
        
        datePicker1.locale = .current
        datePicker1.locale = Locale(identifier: "en_US")
        datePicker1.date = Date()
        datePicker1.preferredDatePickerStyle = .compact
        //datePicker1.addTarget(self, action: #selector(startdate), for: .valueChanged)
        
        datePicker1.addTarget(self, action: #selector(startdate(sender:)), for: UIControl.Event.valueChanged)
        StartDateText.inputView = datePicker1
        
        datePicker2.locale = .current
        datePicker2.locale = Locale(identifier: "en_US")
        datePicker2.date = Date()
        datePicker2.preferredDatePickerStyle = .compact
        datePicker2.addTarget(self, action: #selector(enddate(sender:)), for: UIControl.Event.valueChanged)
        
    }
    //        @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
    //
    //            StartDateText.text = dateFormatter.string(from: sender.date)
    //
    //
    //
    //            view.endEditing(true)
    //            print(sdate!)
    //        }
    
    //        @IBAction func EndDatePicker(_ sender: UIDatePicker) {
    //            EndDateText.text = dateFormatter1.string(from: sender.date)
    //
    //            EndDateText.text = dateFormatter1.string(from: datePicker2.date)
    //            edate = datePicker2.date
    //            view.endEditing(true)
    //            print(edate!)
    //
    //        }
    @objc func startdate(sender: UIDatePicker) {
        let selectedDate = sender.date
        let timeZoneOffset = TimeZone.current.secondsFromGMT()
        let adjustedDate = selectedDate.addingTimeInterval(TimeInterval(timeZoneOffset))
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        StartDateText.text = dateFormatter.string(from: adjustedDate)
        sdate = adjustedDate
        print(sdate!)
    }
    
    @objc func enddate(sender: UIDatePicker) {
        let selectedDate = sender.date
        let timeZoneOffset = TimeZone.current.secondsFromGMT()
        let adjustedDate = selectedDate.addingTimeInterval(TimeInterval(timeZoneOffset))
        
        dateFormatter1.dateFormat = "dd/MM/yyyy"
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        dateFormatter1.locale = Locale(identifier: "en_US")
        EndDateText.text = dateFormatter1.string(from: adjustedDate)
        edate = adjustedDate
        print(edate!)
    }
    
    
    
    
}
extension ExportCsvViewController {
    
    func setBackground() {
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Darktheme")
        view.sendSubviewToBack(backgroundimageview)
        
    }
    @IBAction func getDataAction(_ sender: Any) {
        if let endDate = edate {
                 let vendorExportKey = "LastExportDate_\(vid)"
                         UserDefaults.standard.set(endDate, forKey: vendorExportKey)
                         UserDefaults.standard.synchronize()
                         
                         dateFormatter.dateStyle = .medium
                         LastDate.text = dateFormatter.string(from: endDate)
                     }
        let endpoint = "ManageOrder/Csv"
        
        let params: [String: Any] = [
            "vid": UserSession.shared.user?.acountId ?? 0,
            "startdate": sdate!,
            "endDate": edate!
        ]
        
        NetworkManager.shared.request(endpoint, decoder: [ExportData].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.exportdata = data
                print(self.exportdata)
                
                // Calculate total quantity and total price
                var totalQuantity = 0
                var totalPrice = 0.0
                
                for export in self.exportdata {
                    totalQuantity += export.quantity!
                    
                    totalPrice += Double(export.totalPrice!)
                }
                
                // Generate CSV content
                // Generate CSV content
                var csvText = "Name,Product Name,Price,Quantity,Total Price,Date,Remaining Stock\n"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"

                for export in self.exportdata {
                    let dateString = dateFormatter.string(from: export.date!)
                    csvText += "\(export.name!),\(export.productname!),\(export.price!),\(export.quantity!),\(export.totalPrice!),\(dateString),\(export.remainingStock ?? 0)\n"
                }

                
                // Add total quantity and total price rows to CSV content
                csvText += "Total Quantity,,,\(totalQuantity),,\n"
                csvText += "Total Price,,,,\(totalPrice),\n"
            
                // Save CSV file to Downloads folder
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = documentDirectory.appendingPathComponent("\(UserSession.shared.user?.name! ?? "Vendor Data").Csv")
                    
                    do {
                        try csvText.write(to: fileURL, atomically: true, encoding: .utf8)
                        
                        DispatchQueue.main.async {
                            // Present file sharing controller
                            let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                            if let popoverController = activityViewController.popoverPresentationController {
                                popoverController.barButtonItem = self.navigationItem.rightBarButtonItem
                            }
                            self.present(activityViewController, animated: true, completion: nil)
                        }
                    } catch {
                        print("Failed to create CSV file: \(error)")
                        Utility.showAlertWithOkAndCancel(title: "Oops...!, error \(error.localizedDescription)")
                    }
                }
                
            case .failure(let error):
                print(error)
                Utility.showAlertWithOkAndCancel(title: "Oops...!, error \(error.localizedDescription)")
            }
        }
    }

    
}
