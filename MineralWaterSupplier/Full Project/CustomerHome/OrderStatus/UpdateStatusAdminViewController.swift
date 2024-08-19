//
//  UpdateStatusAdminViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 19/01/2023.
//

import UIKit

class UpdateStatusAdminViewController: UIViewController {
    let backgroundimageview = UIImageView()
        @IBOutlet weak var rdbtnConfirmed: UIButton!
        @IBOutlet weak var rdbtnProcessing: UIButton!
        @IBOutlet weak var rdbtnOnway: UIButton!
        @IBOutlet weak var rdbdelivered: UIButton!
    var oid  = 0
 var status = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        print(status)
        if status == 0 {
                    rdbtnConfirmed.isSelected = false
                    rdbtnProcessing.isSelected = false
                    rdbtnOnway.isSelected = false
                    rdbdelivered.isSelected = false
                }
                else if  status == 1{
                    rdbtnConfirmed.isSelected = true
                    rdbtnProcessing.isSelected = false
                    rdbtnOnway.isSelected = false
                    rdbdelivered.isSelected = false
                }
                else if  status == 2{
                    rdbtnConfirmed.isSelected = false
                    rdbtnProcessing.isSelected = true
                    rdbtnOnway.isSelected = false
                    rdbdelivered.isSelected = false
                }
                else if  status == 3{
                    rdbtnConfirmed.isSelected = false
                    rdbtnProcessing.isSelected = false
                    rdbtnOnway.isSelected = true
                    rdbdelivered.isSelected = false
                }
                else if  status == 4{
                    rdbtnConfirmed.isSelected = false
                    rdbtnProcessing.isSelected = false
                    rdbtnOnway.isSelected = false
                    rdbdelivered.isSelected = true
                }
    }
    
    
    
    
    
    @IBAction private func TrackOrderAction(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "trackingViewController") as! trackingViewController
       
        vc.orderId = oid
        //self.dismiss(animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
        
    }

   
}
extension UpdateStatusAdminViewController {
    func setBackground(){
        view.addSubview(backgroundimageview)
        backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
        backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundimageview.image = UIImage(named: "Customertheme")
        view.sendSubviewToBack(backgroundimageview)
        
    }
}
